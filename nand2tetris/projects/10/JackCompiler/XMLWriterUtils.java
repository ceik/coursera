package JackCompiler;

import javax.xml.stream.XMLEventFactory;
import javax.xml.stream.XMLEventWriter;
import javax.xml.stream.XMLStreamException;

public class XMLWriterUtils {

    static XMLEventFactory eventFactory = XMLEventFactory.newInstance();

    static void writeXMLStart(String name) throws XMLStreamException {
        Integer count = 0;
        while (count < Parser.currIndent) {
            Parser.xmlEventWriter.add(eventFactory.createCharacters("  "));
            count++;
        }

        Parser.xmlEventWriter.add(eventFactory.createStartElement("", "", name));
        Parser.xmlEventWriter.add(eventFactory.createCharacters("\n"));
    }

    static void writeXMLEnd(String name) throws XMLStreamException {
        Integer count = 0;
        while (count < Parser.currIndent) {
            Parser.xmlEventWriter.add(eventFactory.createCharacters("  "));
            count++;
        }

        Parser.xmlEventWriter.add(eventFactory.createEndElement("", "", name));
        Parser.xmlEventWriter.add(eventFactory.createCharacters("\n"));
    }

    static void writeXMLNode(String tag, String element)
            throws XMLStreamException {

        Integer count = 0;
        while (count < Parser.currIndent) {
            Parser.xmlEventWriter.add(eventFactory.createCharacters("  "));
            count++;
        }

        Parser.xmlEventWriter.add(eventFactory.createStartElement("", "", tag));
        Parser.xmlEventWriter.add(eventFactory.createCharacters(" " + element + " "));
        Parser.xmlEventWriter.add(eventFactory.createEndElement("", "", tag));
        Parser.xmlEventWriter.add(eventFactory.createCharacters("\n"));
    }

}

