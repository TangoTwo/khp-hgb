package fh.ssd4.demos;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class SAXWriterTest {

    public static void main(String[] args) {
        System.out.println("SAXWriterTest BEGIN");
        long startTime = System.currentTimeMillis();


        SAXParserFactory saxParserFactory = SAXParserFactory.newInstance();
        saxParserFactory.setValidating(true);

        SAXParser saxParser;

        String outFile = "out.xml";
        try {
            saxParser = saxParserFactory.newSAXParser();

            File file = new File("files/10k.xml");
            WriteElementsHandler writeHandler = new WriteElementsHandler();

            OutputStream os = new FileOutputStream(new File(outFile));
            PrintWriter writer = new PrintWriter(os);
            writeHandler.setWriter(writer);

            // parse
            saxParser.parse(file, writeHandler);


        } catch (ParserConfigurationException e1) {
            System.out.println("ParserConfigurationException: " + e1.getMessage());
        } catch (SAXException e1) {
            System.out.println("SAXException: " + e1.getMessage());
        } catch (IOException e) {
            System.out.println("IOException: " + e.getMessage());
        }

        long endTime = System.currentTimeMillis();
        System.out.println("SAXWriterTest END");
        System.out.println("Total time taken = " + (endTime - startTime) + "ms");
    }
}

class WriteElementsHandler extends DefaultHandler {
    private static final double DOLLAR_TO_EURO = 0.89285714285;
    PrintWriter writer = null;
    String curElement = "";
    int curNumber;
    boolean exchangeToEuro = false;
    int amountAuthors = 0;
    int multipleAuthorsBooks = 0;

    public void setWriter(PrintWriter writer) {
        this.writer = writer;
    }

    @Override
    public void startDocument() throws SAXException {
        writer.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>"); // additional checking has to be done if version is correct!
        writer.println("<!-- Date and Time:" + (new Date()).toString() + " -->");
    }

    @Override
    public void endDocument() throws SAXException {
        writer.flush();
        writer.close();
    }

    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        curElement = qName;
        if(curElement.equals("Preis")) {
            exchangeToEuro = attributes.getValue("waehrung").equals("Dollar");
        } else if(curElement.equals("Posten"))
            curNumber = Integer.parseInt(attributes.getValue("nr"));
        writer.print("<" + qName);
        for (int i = 0; i < attributes.getLength(); i++) {
            if(attributes.getQName(i).equals("waehrung")) {
                writer.print(" " + attributes.getQName(i) + "=\"" + "Euro"
                        + "\"");
            } else {
                writer.print(" " + attributes.getQName(i) + "=\"" + attributes.getValue(i)
                        + "\"");
            }
        }
        writer.print(">");
    }

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        String s = new String(ch, start, length);
        if(curElement.equals("Autor")) {
            amountAuthors++;
        } else if(curElement.equals("Preis") && exchangeToEuro) {
            s = String.format("%.2f", Double.valueOf(s) * DOLLAR_TO_EURO);
        }
        s = s.replaceFirst("ISBN: ", "");
        s = s.replace("&", "&amp;");
        writer.print(s);
    }

    @Override
    public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {
        // do nothing
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if(qName.equals("Buch")){
            if(amountAuthors > 1)
                multipleAuthorsBooks++;
            amountAuthors = 0;
        } else if (qName.equals("Rechnungen")) {
            writer.print("<Statistik>");
            writer.print("<Autoren mehrAls=\"1\">"+ multipleAuthorsBooks + "</Autoren>");
            writer.print("</Statistik>");
        }
        writer.print("</"+qName+">");
        writer.println();
        curElement = "";
    }

} // class Writer
