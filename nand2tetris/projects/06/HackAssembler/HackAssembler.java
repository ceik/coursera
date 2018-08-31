package HackAssembler;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.IOException;
import java.util.Hashtable;

// Proposed stages:
// - assembler without symbols (use L versions to test)
// - add symboltable


public class HackAssembler {
    static cDictionary dict;
    static Parser parser;

    public static void main(String[] args) throws IOException {
        BufferedReader inputStream = null;
        PrintWriter outputStream = null;

        dict = new cDictionary();
        parser = new Parser(dict);

        String sourceName = args[0];
        String[] nameParts = sourceName.split("\\.");
        String outName = nameParts[0] + ".hack";

        try {
            inputStream = new BufferedReader(new FileReader(sourceName));
            outputStream = new PrintWriter(new FileWriter(outName));

            String sourceLine;
            String outLine;

            while ((sourceLine = inputStream.readLine()) != null) {
                outLine = parser.translateLine(sourceLine);

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

