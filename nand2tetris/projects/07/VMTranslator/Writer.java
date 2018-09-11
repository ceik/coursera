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
    public static void writeLines(String outputFile) throws IOException {
        PrintWriter outputStream = null;

        try {
            outputStream = new PrintWriter(new FileWriter(outputFile + ".asm"));

            String lineNumber;
            String[] commandParts;
            String commandType;

            for (Map.Entry<Integer, String[]> line : ccc.map.entrySet()) {
                lineNumber = Integer.toString(line.getKey());
                commandParts = line.getValue();
                commandType = commandParts[0];

                // Print the asm translation of the lines to the outputStream
                switch (commandType) {
                    case "push":
                        WritePush.writePush(outputStream, commandParts,
                            outputFile.replace("/", ""));
                        break;
                    case "pop":
                        WritePop.writePop(outputStream, commandParts,
                            outputFile.replace("/", ""));
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
                }
            }
        } finally {
            if (outputStream != null) {
                outputStream.close();
            }
        }
    }
}
