package JackCompiler;

import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;
import java.util.Map;

public class Parser {

    // these will get initialized by the respective ParserFunctions
    static IdentifierStorage classVars;
    static IdentifierStorage subrVars;
    static Integer staticVarCount;
    static Integer fieldVarCount;
    static Integer argVarCount;
    static Integer localVarCount;

    static TokenStorage tokens;
    static Integer totalTokens;
    static Integer currIndent;

    static Integer currLine;
    static Integer nextLine;
    static Token currToken;
    static Token nextToken;
    static String currLexElem;
    static String nextLexElem;
    static String currTokenValue;
    static String nextTokenValue;

    static String currClassName;
    static Integer controlFlowCounter;

    static PrintWriter outputStream = null;


    static void parseFile(TokenStorage inputTokens, String outputFilePath, String outputFileName)
            throws IOException {

        try {
            outputStream = new PrintWriter(new FileWriter(outputFilePath));
            tokens = inputTokens;

            currIndent = 0;
            totalTokens = tokens.map.entrySet().size();

            currLine = -1;
            nextLine = 0;

            nextToken = tokens.map.get(nextLine);
            nextLexElem = nextToken.getLexElem();
            nextTokenValue = nextToken.getValue();

            // As per the specs each file starts with and contains only one class
            // compileClass therefore kickstarts the compilation process
            if (nextLexElem.equals("keyword") && nextTokenValue.equals("class")) {
                Class.compile();
            } else {
                System.out.println("Input must start with the keyword class");
            }

        } finally {
            if (outputStream != null) {
                outputStream.close();
            }
        }
    }

    static void advanceLine() {
        currLine++;
        nextLine++;

        currToken = tokens.map.get(currLine);
        currLexElem = currToken.getLexElem();
        currTokenValue = currToken.getValue();

        if (!(tokens.map.get(nextLine) == null)) {
            nextToken = tokens.map.get(nextLine);
            nextLexElem = nextToken.getLexElem();
            nextTokenValue = nextToken.getValue();
        }
    }

    // Peeks ahead by a certain distance and returns the requested element
    static String peekAhead(Integer distance, String kind) {
        Token tokenFromTheFuture;

        // ensure that looking ahead by distance is even possible
        if (tokens.map.get(distance) == null) {
            return "";
        }

        tokenFromTheFuture = tokens.map.get(currLine + distance);
        if (kind.equals("lexElem")) {
            return tokenFromTheFuture.getLexElem();
        } else if (kind.equals("token")) {
            return tokenFromTheFuture.getValue();
        } else {
            return "";
        }
    }
}
