package JackCompiler;

import java.io.File;
import java.io.IOException;
import javax.xml.stream.XMLStreamException;

public class JackCompiler {

    // The JackCompiler parses each .jack file into an .xml file of the same
    // name. These xml file need to be further processed to arrive at the
    // desired vm code.

    public static void main(String[] args) throws IOException,
            XMLStreamException {
        String inputFile = args[0];
        File file = new File(inputFile);

        boolean doesExist = file.exists();
        boolean isFile = file.isFile();
        boolean isDir = file.isDirectory();

        // Check whether input is a file or directory and
        // use the corresponding parse function
        if (doesExist) {
            if (isFile) {
                SyntaxAnalyzer.processFile(inputFile);
            } else if (isDir) {
                SyntaxAnalyzer.processDir(inputFile);
            } else {
                System.out.println("Input is neither a file nor a directory");
            }
        } else {
            System.out.println("Input does not exist");
        }
    }
}