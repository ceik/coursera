package JackCompiler;

import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.File;
import java.util.StringTokenizer;

public class Tokenizer {

    static int lineCounter;

    static void ingestFile(String inputFilePath, TokenStorage tokens) throws
            IOException {

        lineCounter = 0;
        BufferedReader inputStream = null;
        File inputFile = new File(inputFilePath);
        String inputFileName = inputFile.getName();

        try {
            inputStream = new BufferedReader(new FileReader(inputFilePath));

            String sourceLine;
            String[] lineParts;
            String cleanLine;

            while ((sourceLine = inputStream.readLine()) != null) {
                // Remove comments & leading/trailing whitespace from the line
                lineParts = sourceLine.split("//");
                cleanLine = lineParts[0].trim();

                // Ignore empty lines & comments
                if (cleanLine.isEmpty()) {
                    continue;
                // Need to handle these two lines separately so that the
                // following substring calls don't throw errors
                } else if (cleanLine.substring(0, 1).equals("}")) {
                    tokenizeLine(cleanLine, tokens);
                } else if (cleanLine.substring(0, 1).equals("*")) {
                    continue;
                // The patterns are different than in the actual code because
                // leading whitespace gets removed in cleanLine
                } else if (cleanLine.substring(0, 2).equals("//") ||
                           cleanLine.substring(0, 2).equals("*/") ||
                           cleanLine.substring(0, 2).equals("* ") ||
                           cleanLine.substring(0, 3).equals("/**")) {
                    continue;
                } else {
                    tokenizeLine(cleanLine, tokens);
                }
            }

        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }
    }

    static void tokenizeLine(String inputLine, TokenStorage tokens) {
        // Using a string instead of char so that I can use String.matches.
        // Chars don't seem to have a regex match function
        String currentChar;
        int nextQuot = 0;

        // Looping through all characters in a line until a "separator" (double
        // quote or one of the characters in the regex pattern below) is
        // encountered. Token(s) are then created for the string up to the
        // separator and tokenizeLine is called recursively on the remaining
        // string.
        checkChars:
        for (int i=0; i<inputLine.length(); i++) {
            currentChar = inputLine.substring(i, (i+1));

            // Handle string constants
            if (currentChar.matches("\"")) {
                // nextQuot is the index of next double quote (after currentChar)
                nextQuot = inputLine.indexOf("\"", (i+1));
                writeToken(tokens, inputLine.substring(1, nextQuot),
                    "stringConstant");
                tokenizeLine(inputLine.substring(nextQuot+1), tokens);
                break checkChars;
            // Handle all other separators (incl. spaces). This actually creates
            // 2 tokens: One for the string up to the separator and one for the
            // separator itself. Spaces are thrown away later.
            } else if (currentChar.matches("[ {}()\\[\\].,;+\\-*/&|<>=~;]")) {
                writeToken(tokens, inputLine.substring(0, (i)), null);
                writeToken(tokens, inputLine.substring(i, (i+1)),
                    "symbol");
                tokenizeLine(inputLine.substring(i+1), tokens);
                break checkChars;
            }
        }
    }

    static void writeToken(TokenStorage tokens, String tokenValue,
            String lexElem) {
        // Throw away spaces
        String cleanToken = tokenValue.trim();
        if (!cleanToken.isEmpty()) {
            if (lexElem == null) {
                lexElem = determineTag(cleanToken);
            }
            tokens.map.put(lineCounter, new Token(lexElem, cleanToken));
            lineCounter += 1;
        }
    }

    static String determineTag(String token) {
        if (token.matches("^class|constructor|function|method|field|static|" +
            "var|int|char|boolean|void|true|false|null|this|let|do|if|else|" +
            "while|return$")) {
            return "keyword";
        } else if (token.matches("\\d+")) {
            return "integerConstant";
        } else {
            return "identifier";
        }
    }
}
