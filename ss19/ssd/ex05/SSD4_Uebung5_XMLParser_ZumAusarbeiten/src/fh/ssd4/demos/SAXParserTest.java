package fh.ssd4.demos;
import java.io.*;
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
			File file = new File("addressbook.xml");
			saxParser.parse(file, new PrintElementsHandler());

		} catch (ParserConfigurationException e1) {
			System.out.println("ParserConfigurationException: "+e1.getMessage());
		} catch (SAXException e1) {
			System.out.println("SAXException: "+e1.getMessage());
		} catch (IOException e) {
			System.out.println("IOException: "+e.getMessage());
		}
	}
} //SAXParserTest

class PrintElementsHandler extends DefaultHandler {
	StringBuffer blanks = new StringBuffer();
	int depth = 0; // node depth
	//
	// TODO Overwrite DefaultHandler methods
	//
	@Override
	public void startDocument() throws SAXException {
		System.out.println("start document -------------");
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
		blanks.append("   ");
		depth++;
		System.out.println(blanks.toString() + depth + " - " + qName + ": ");
		for (int i = 0; i < attributes.getLength(); i++) {
			System.out.println(blanks.toString()+ attributes.getQName(i) + " = " + attributes.getValue(i));
		}
		//System.out.println();
	}

	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		String s = new String(ch, start, length);
		System.out.println(blanks.toString() + "   " + (depth+1) + "- " + s);
	}

	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException {
		depth--;
		blanks.delete(0, 3);
	}

	@Override
	public void endDocument() throws SAXException {
		System.out.println("End document --------------");
	}

	//
	// TODO Overwrite ErrorHandler methods (warning, error, fatalError)
	//

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

	/** Prints the error message. */
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
