package JackCompiler;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import javax.xml.stream.XMLStreamException;


public class SyntaxAnalyzer {

    // The SyntaxAnalyzer first tokenizes the content of a file into a
    // LinkedHashMap (TokenStorage). Afterwards the map is parsed into an xml
    // file.

    // Parse a directory by using parseFile on all .jack files in that dir
    static void processDir(String input) throws IOException, XMLStreamException {
        File inputDir = new File(input);

        // Use a FilenameFilter to create an array of only .jack files
        FilenameFilter asmFileFilter = new FilenameFilter() {
            public boolean accept(File inputDir, String name) {
                return name.toLowerCase().endsWith(".jack");
            }
        };
        File[] files = inputDir.listFiles(asmFileFilter);

        // Loop through all .jack files in dir
        if (files != null) {
            for (File file : files) {
                processFile(file.getAbsolutePath());
            }
        }
    }

    static void processFile(String inputFilePath) throws IOException,
            XMLStreamException {
        String[] inputFilePathParts = inputFilePath.split("\\.");
        String tokenizedFilePath = inputFilePathParts[0] + "TestT.xml";
        String finalFilePath = inputFilePathParts[0] + "Test.xml";
        TokenStorage tokens = new TokenStorage();

        Tokenizer.ingestFile(inputFilePath, tokens);

        Parser.parseFile(tokens, finalFilePath);
    }
}