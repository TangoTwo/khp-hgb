package fh.ssd4.demos;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;

import javax.management.Attribute;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class SAXWriterTest {

    public static void main(String[] args) {
        System.out.println("SAXWriterTest BEGIN");


        SAXParserFactory saxParserFactory = SAXParserFactory.newInstance();
        saxParserFactory.setValidating(true);

        SAXParser saxParser;

        String outFile = "adressbook_out.xml";
        try {
            saxParser = saxParserFactory.newSAXParser();

            File file = new File("addressbook.xml");
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


        System.out.println("SAXWriterTest END");
    }
}

class WriteElementsHandler extends DefaultHandler {

    PrintWriter writer = null;

    public void setWriter(PrintWriter writer) {
        this.writer = writer;
    }

    @Override
    public void startDocument() throws SAXException {
        writer.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>"); // additional checking has to be done if version is correct!
        writer.println("<!DOCTYPE addressbook SYSTEM \"addressbook.dtd\">");
        writer.println("<!-- Date and Time:" + (new Date()).toString() + " -->");
    }

    @Override
    public void endDocument() throws SAXException {
        writer.flush();
        writer.close();
    }

    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        writer.print("<" + qName);
        for (int i = 0; i < attributes.getLength(); i++) {
            writer.print(" " + attributes.getQName(i) + "=\"" + attributes.getValue(i)
                    + "\"");
        }
        writer.print(">");
    }

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        String s = new String(ch, start, length);
        writer.print(s);
    }

    @Override
    public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {
        // do nothing
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        writer.print("</"+qName+">");
    }

} // class Writer
