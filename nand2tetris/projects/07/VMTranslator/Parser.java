package VMTranslator;

import java.io.FileReader;
import java.io.BufferedReader;
import java.io.IOException;


public class Parser {
    static CleanCodeCatalog ccc;

    public Parser(CleanCodeCatalog inputCcc) {
        ccc = inputCcc;
    }

    // Go through all the lines of the input file and write the relevant ones
    // into a CleanCodeCatalog
    public static void parseFile(String inputFile) throws IOException {
        BufferedReader inputStream = null;

        try {
            inputStream = new BufferedReader(new FileReader(inputFile));

            String sourceLine;
            int lineCounter = 0;

            while ((sourceLine = inputStream.readLine()) != null) {
                // Ignore empty lines & comments
                if (sourceLine.isEmpty() ||
                    sourceLine.substring(0, 2).equals("//")) {
                    continue;
                // Put the line into the ccc and increment counter for all
                // other lines
                } else {
                    ccc.map.put(lineCounter, sourceLine.split(" "));
                    lineCounter += 1;
                }
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }

    }
}
