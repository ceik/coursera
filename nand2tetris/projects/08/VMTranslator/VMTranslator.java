package VMTranslator;

import java.io.IOException;
import java.io.File;

public class VMTranslator {
    static CleanCodeCatalog ccc;
    static Parser parser;
    static Writer writer;

    public static void main(String[] args) throws IOException {
        String inputFile = args[0];
        String outputFile = null;
        String[] nameParts = inputFile.split("\\.");
        String[] dirsInPath = nameParts[0].split("/");
        File file = new File(inputFile);

        boolean doesExist = file.exists();
        boolean isFile = file.isFile();
        boolean isDir = file.isDirectory();

        // Create a Parser that tokenizes each line and stores it in the
        // CleanCodeCatalog
        ccc = new CleanCodeCatalog();
        parser = new Parser(ccc);

        // Check whether input is a file or directory and:
        // 1. Use the corresponding parse function
        // 2. Create the output path/file
        if (doesExist) {
            if (isFile) {
                parser.parseFile(inputFile);
                outputFile = nameParts[0] + ".asm";
            } else if (isDir) {
                parser.parseDir(inputFile);
                outputFile = nameParts[0] + "/" +
                    dirsInPath[dirsInPath.length-1] + ".asm";
            } else {
                System.out.println("Input is neither a file nor a directory");
            }
        } else {
            System.out.println("Input does not exist");
        }

        // Create a Writer that takes in a CleanCodeCatalog, goes through all
        // the lines stored in there and writes them into a file (whose name is
        // determined by the input file).
        writer = new Writer(ccc);
        writer.writeLines(outputFile);
    }
}
