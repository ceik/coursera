package VMTranslator;

import java.io.IOException;

public class VMTranslator {
    static CleanCodeCatalog ccc;
    static Parser parser;
    static Writer writer;

    public static void main(String[] args) throws IOException {
        String inputFile = args[0];
        String[] nameParts = inputFile.split("\\.");

        // Create a Parser that tokenizes each line and stores it in the
        // CleanCodeCatalog
        ccc = new CleanCodeCatalog();
        parser = new Parser(ccc);
        parser.parseFile(inputFile);

        // Create a Writer that takes in a CleanCodeCatalog, goes through all
        // the lines stored in there and writes them into a file (whose name is
        // determined by the input file).
        writer = new Writer(ccc);
        writer.writeLines(nameParts[0]);
    }
}
