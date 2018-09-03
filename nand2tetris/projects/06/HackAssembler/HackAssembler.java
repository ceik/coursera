package HackAssembler;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.IOException;
import java.util.Hashtable;


public class HackAssembler {
    static CDictionary dict;
    static SymbolTable symTable;
    static Parser parser;

    public static void main(String[] args) throws IOException {
        BufferedReader inputStream = null;
        PrintWriter outputStream = null;

        dict = new CDictionary();
        symTable = new SymbolTable();
        parser = new Parser(dict, symTable);

        String sourceName = args[0];
        String[] nameParts = sourceName.split("\\.");
        String outName = nameParts[0] + ".hack";

        // First pass through the code to process label symbols.
        // The lines containing the label symbol declarations are not part of
        // the "actual" code and therefore must not be translated later. They
        // merely create a reference to the following line. The counter
        // therefore does not count them.
        try {
            inputStream = new BufferedReader(new FileReader(sourceName));

            String sourceLine;
            int lineCounter = 0;

            while ((sourceLine = inputStream.readLine()) != null) {
                // Ignore empty lines & comments
                if (sourceLine.isEmpty() ||
                    sourceLine.substring(0, 2).equals("//")) {
                    continue;
                // Process label symbols
                } else if (sourceLine.substring(0, 1).equals("(")) {
                    parser.processLabel(sourceLine, lineCounter);
                // Increment counter for all other lines
                } else {
                    lineCounter += 1;
                }
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }

        // Second pass through the code to translate files
        try {
            inputStream = new BufferedReader(new FileReader(sourceName));
            outputStream = new PrintWriter(new FileWriter(outName));

            String sourceLine;
            String outLine;
            String[] lineParts;
            String cleanLine;

            while ((sourceLine = inputStream.readLine()) != null) {
                lineParts = sourceLine.split("//");
                cleanLine = lineParts[0].trim();
                outLine = parser.translateLine(cleanLine);

                // translateLine returns an empty line for all lines that
                // should be ignored.
                if (!outLine.isEmpty()) {
                    outputStream.println(outLine);
                }
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            if (outputStream != null) {
                outputStream.close();
            }
        }
    }
}

