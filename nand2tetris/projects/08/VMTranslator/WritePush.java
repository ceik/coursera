package VMTranslator;

import java.io.PrintWriter;

public class WritePush {

    static void writePush(PrintWriter outputStream,
        String[] commandParts, String inputFile) {

        String commandMemSegment = commandParts[1];
        String commandMemSegmentVariable =
            TranslateMemSegment.translate(commandParts[1]);
        String commandMemAddress = commandParts[2];

        outputStream.println("// push " + commandMemSegment + " " +
            commandMemAddress);

        // Load D with the value that is supposed to be pushed onto the stack
        if (commandMemSegment.equals("constant")) {
            outputStream.println("@" + commandMemAddress);
            outputStream.println("D=A");
        } else if (commandMemSegment.equals("static")) {
            outputStream.println("@" + inputFile + "." + commandMemAddress);
            outputStream.println("D=M");
        } else {
            outputStream.println("@" + commandMemAddress);
            outputStream.println("D=A");
            if (commandMemSegment.equals("temp")) {
                outputStream.println("@5");
                outputStream.println("A=D+A");
                outputStream.println("D=M");
            } else if (commandMemSegment.equals("pointer")) {
                outputStream.println("@3");
                outputStream.println("A=D+A");
                outputStream.println("D=M");
            } else {
                outputStream.println("@" + commandMemSegmentVariable);
                outputStream.println("A=D+M");
                outputStream.println("D=M");
            }
        }

        // Push the value of D onto the stack
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=D");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }
}
