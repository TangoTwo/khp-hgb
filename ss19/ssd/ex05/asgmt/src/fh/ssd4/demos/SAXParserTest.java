package fh.ssd4.demos;

import java.io.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;
import javax.xml.parsers.*;

import org.xml.sax.*;
import org.xml.sax.helpers.DefaultHandler;

public class SAXParserTest {

    public static void main(String[] args) {

        SAXParserFactory saxParserFactory = SAXParserFactory.newInstance();
        saxParserFactory.setValidating(true);
        SAXParser saxParser;
        try {
            saxParser = saxParserFactory.newSAXParser();
            File file = new File("Entlassungsbrief.xml");
            saxParser.parse(file, new PrintElementsHandler());

        } catch (ParserConfigurationException e1) {
            System.out.println("ParserConfigurationException: " + e1.getMessage());
        } catch (SAXException e1) {
            System.out.println("SAXException: " + e1.getMessage());
        } catch (IOException e) {
            System.out.println("IOException: " + e.getMessage());
        }
    }
} //SAXParserTest

class PrintElementsHandler extends DefaultHandler {
    StringBuffer titelVor = new StringBuffer();
    StringBuffer vorname = new StringBuffer();
    StringBuffer nachname = new StringBuffer();
    StringBuffer titelNach = new StringBuffer();
    StringBuffer geschlecht = new StringBuffer();
    StringBuffer arzeimittel = new StringBuffer();
    StringBuffer curBuf = null;

    @Override
    public void startElement(java.lang.String uri, java.lang.String localName, java.lang.String qName, Attributes attributes) throws SAXException {
        if (qName.equals("Titel") && attributes.getValue("position").equals("vor")) {
            curBuf = titelVor;
        } else if (qName.equals("Titel") && attributes.getValue("position").equals("nach")) {
            curBuf = titelNach;
        } else if (qName.equals("Vorname")) {
            curBuf = vorname;
        } else if (qName.equals("Nachname")) {
            curBuf = nachname;
        } else if (qName.equals("Geschlecht")) {
            curBuf = geschlecht;
        } else if (qName.equals("Arzneimittel")) {
            String dateString = attributes.getValue("bis");
            if (dateString == null) {
                curBuf = arzeimittel;
                return;
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date today = Calendar.getInstance().getTime();
            try {
                Date date = sdf.parse(dateString);
                if (today.compareTo(date) < 0)
                    curBuf = arzeimittel;
                else
                    curBuf = null;
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            curBuf = null;
        }
    }

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        String s = new String(ch, start, length);
        if (curBuf != null) {
            curBuf.append(s.trim());
            if (curBuf == arzeimittel)
                curBuf.append("\n");
        }
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if (qName.equals("Patient")) {
            if (geschlecht.toString().trim().equals("männlich")) {
                System.out.println("Sehr geehrter Herr");
            } else if (geschlecht.toString().trim().equals("weiblich")) {
                System.out.println("Sehr geehrte Frau");
            } else {
                System.out.println("Grüß Gott");
            }

            if (!titelVor.toString().isEmpty())
                System.out.print(titelVor.toString());
            System.out.print(vorname.toString());
            System.out.print(nachname.toString());
            if (!titelNach.toString().isEmpty())
                System.out.print(titelNach.toString());
        } else {
            if (curBuf != null && curBuf != arzeimittel)
                curBuf.append(" ");
            curBuf = null;
        }
    }

    @Override
    public void endDocument() throws SAXException {
        System.out.println();
        if (!arzeimittel.toString().isEmpty()) {
            System.out.println("Ihnen wurden folgende Medikamente verordnet:");
            System.out.print(arzeimittel.toString());
        } else {
            System.out.println("Ihnen wurden keine Medikamente verordnet.");
        }
    }


    @Override
    public void warning(SAXParseException e) throws SAXException {
        printError("Warning", e);
    }

    @Override
    public void error(SAXParseException e) throws SAXException {
        printError("Error", e);
    }

    @Override
    public void fatalError(SAXParseException e) throws SAXException {
        printError("FatalError", e);
    }

    //
    // Protected methods
    //

    /**
     * Prints the error message.
     */
    protected void printError(String type, SAXParseException ex) {

        System.err.print("[");
        System.err.print(type);
        System.err.print("] ");
        if (ex == null) {
            System.err.println("!!!");
        }
        String systemId = ex.getSystemId();
        if (systemId != null) {
            int index = systemId.lastIndexOf('/');
            if (index != -1)
                systemId = systemId.substring(index + 1);
            System.err.print(systemId);
        }
        System.err.print(':');
        System.err.print(ex.getLineNumber());
        System.err.print(':');
        System.err.print(ex.getColumnNumber());
        System.err.print(": ");
        System.err.print(ex.getMessage());
        System.err.println();
        System.err.flush();

    } // printError(String,SAXParseException)


} //PrintElementsHandler
