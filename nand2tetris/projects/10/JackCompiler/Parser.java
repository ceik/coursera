package JackCompiler;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;

import javax.xml.stream.XMLEventWriter;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;


public class Parser {

    static TokenStorage tokens;
    static Integer totalLines;
    static String[] tokenArray;
    static Integer currIndent;

    static Integer currLine;
    static Integer nextLine;
    static String currLexElem;
    static String nextLexElem;
    static String currToken;
    static String nextToken;

    static XMLEventWriter xmlEventWriter;

    static void parseFile(TokenStorage inputTokens, String outputFilePath)
            throws IOException, XMLStreamException {

        tokens = inputTokens;
        XMLOutputFactory xmlOutputFactory = XMLOutputFactory.newInstance();
        xmlEventWriter = xmlOutputFactory.createXMLEventWriter(
            new FileOutputStream(outputFilePath), "UTF-8");

        // Initialize the variables
        // currentLine serves as a pointer
        currIndent = 0;
        totalLines = tokens.map.entrySet().size();

        currLine = -1;
        nextLine = 0;

        tokenArray = tokens.map.get(nextLine);
        nextLexElem = tokenArray[0];
        nextToken = tokenArray[1];

        // As per the specs each file starts with and contains only one class
        // compileClass kickstarts the compilation process
        if (nextLexElem.equals("keyword") && nextToken.equals("class")) {
            ParseFunctions.compileClass();
        } else {
            System.out.println("Input must start with the keyword class");
        }

        xmlEventWriter.close();
    }

    static void advanceLine() {
        currLine++;
        nextLine++;

        tokenArray = tokens.map.get(currLine);
        currLexElem = tokenArray[0];
        currToken = tokenArray[1];

        if (!(tokens.map.get(nextLine) == null)) {
            tokenArray = tokens.map.get(nextLine);
            nextLexElem = tokenArray[0];
            nextToken = tokenArray[1];
        }
    }

    // Peeks ahead by a certain distance and returns the requested element
    static String peekAhead(Integer distance, String kind) {
        String[] tokenArray;

        // ensure that looking ahead by distance is even possible
        if (tokens.map.get(distance) == null) {
            return "";
        }

        tokenArray = tokens.map.get(currLine + distance);
        if (kind.equals("lexElem")) {
            return tokenArray[0];
        } else if (kind.equals("token")) {
            return tokenArray[1];
        } else {
            return "";
        }
    }
}
