package fh.ssd4.demos;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
 
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;

public class XMLTransformTest {

	public static void main(String[] args) {
		System.out.println("XMLTransformTest BEGIN");

		DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
		documentBuilderFactory.setValidating(true);
		documentBuilderFactory.setIgnoringElementContentWhitespace(true);

		try {
			DocumentBuilder builder = documentBuilderFactory.newDocumentBuilder();

			TransformerFactory transformerFactory = TransformerFactory.newInstance();

			File stylesheetFile = new File("addressbook.xsl");
			StreamSource stylesheet = new StreamSource(stylesheetFile);

			Transformer t = transformerFactory.newTransformer(stylesheet);

			File inFile = new File("addressbook.xml");
			Document document = builder.parse(inFile);
			DOMSource source = new DOMSource(document);

			File outFile = new File("adddressbook.html");
			StreamResult result = new StreamResult(new FileOutputStream(outFile));

			t.transform(source, result);

			System.out.println("A new file was created in " + outFile.getAbsolutePath());

		} catch (SAXException e) {
			e.printStackTrace();
		} catch (TransformerConfigurationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (TransformerException e) {
			e.printStackTrace();
		}
		System.out.println("XMLTransformTest END");
	}
} //XMLTransformTest
