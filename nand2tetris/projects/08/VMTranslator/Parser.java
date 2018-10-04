package VMTranslator;

import java.io.FileReader;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.File;
import java.io.FilenameFilter;

public class Parser {
    static CleanCodeCatalog ccc;

    public Parser(CleanCodeCatalog inputCcc) {
        ccc = inputCcc;
    }

    // Parse a directory by using parseFile on all .vm files in that dir
    static void parseDir(String input) throws IOException {
        File inputDir = new File(input);

        // Use a FilenameFilter to create an array of only .vm files
        FilenameFilter asmFileFilter = new FilenameFilter() {
            public boolean accept(File inputDir, String name) {
                return name.toLowerCase().endsWith(".vm");
            }
        };

        File[] files = inputDir.listFiles(asmFileFilter);

        // Loop through all .vm files in dir
        if (files != null) {
            for (File file : files) {
                parseFile(file.getAbsolutePath());
            }
        }
    }

    // Go through all the lines of the input file and write the relevant ones
    // into a CleanCodeCatalog
    static void parseFile(String inputFilePath) throws IOException {
        BufferedReader inputStream = null;

        File inputFile = new File(inputFilePath);
        String inputFileName = inputFile.getName();

        try {
            inputStream = new BufferedReader(new FileReader(inputFilePath));

            String sourceLine;
            String[] lineParts;
            String cleanLine;
            int lineCounter = 0;
            String lineMetaData = null;

            while ((sourceLine = inputStream.readLine()) != null) {
                // Ignore empty lines & comments
                if (sourceLine.isEmpty() ||
                    sourceLine.substring(0, 2).equals("//")) {
                    continue;
                // Remove inline comments, put the line into the ccc, and
                // increment counter for all other lines
                } else {
                    lineParts = sourceLine.split("//");
                    cleanLine = lineParts[0].trim();

                    lineMetaData = inputFileName + " " +
                        Integer.toString(lineCounter);
                    ccc.map.put(lineMetaData.split(" "), cleanLine.split(" "));
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
