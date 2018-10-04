package VMTranslator;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;
import java.util.Map;

public class Writer {
    static CleanCodeCatalog ccc;

    public Writer(CleanCodeCatalog inputCcc) {
        ccc = inputCcc;
    }

    // Go through all the lines in the CleanCodeCatalog and write them to a file
    static void writeLines(String outputFile) throws IOException {
        PrintWriter outputStream = null;

        try {
            outputStream = new PrintWriter(new FileWriter(outputFile));

            String[] outputFileParts = outputFile.split("/");
            String outputFileName = outputFileParts[outputFileParts.length-1];

            String[] lineMetaData;
            String lineNumber;
            String inputFileName;
            String[] commandParts;
            String commandType;

            // Write Bootstrap Code at start of file
            WriteBootstrap.bootstrap(outputStream);

            // Write lines from CCC
            for (Map.Entry<String[], String[]> line : ccc.map.entrySet()) {
                lineMetaData = line.getKey();
                inputFileName = lineMetaData[0];
                lineNumber = lineMetaData[1];
                commandParts = line.getValue();
                commandType = commandParts[0];

                // Print the asm translation of the lines to the outputStream
                switch (commandType) {
                    case "push":
                        WritePush.writePush(outputStream, commandParts,
                            inputFileName);
                        break;
                    case "pop":
                        WritePop.writePop(outputStream, commandParts,
                            inputFileName);
                        break;
                    case "add":
                        WriteMath.writeAdd(outputStream);
                        break;
                    case "sub":
                        WriteMath.writeSub(outputStream);
                        break;
                    case "neg":
                        WriteMath.writeNeg(outputStream);
                        break;
                    case "and":
                        WriteBool.writeAnd(outputStream);
                        break;
                    case "or":
                        WriteBool.writeOr(outputStream);
                        break;
                    case "not":
                        WriteBool.writeNot(outputStream);
                        break;
                    case "eq":
                        WriteCompare.writeEq(outputStream, lineNumber);
                        break;
                    case "lt":
                        WriteCompare.writeLt(outputStream, lineNumber);
                        break;
                    case "gt":
                        WriteCompare.writeGt(outputStream, lineNumber);
                        break;
                    case "label":
                        WriteFlow.writeLabel(outputStream, commandParts);
                        break;
                    case "if-goto":
                        WriteFlow.writeIfGoTo(outputStream, commandParts);
                        break;
                    case "goto":
                        WriteFlow.writeGoTo(outputStream, commandParts);
                        break;
                    case "call":
                        WriteFunc.writeCall(outputStream, commandParts,
                            inputFileName, lineNumber);
                        break;
                    case "function":
                        WriteFunc.writeFunction(outputStream, commandParts);
                        break;
                    case "return":
                        WriteFunc.writeReturn(outputStream);
                        break;
                }
            }
        } finally {
            if (outputStream != null) {
                outputStream.close();
            }
        }
    }
}
