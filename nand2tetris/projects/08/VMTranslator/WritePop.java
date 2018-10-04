package VMTranslator;

import java.io.PrintWriter;

public class WritePop {

    static void writePop(PrintWriter outputStream,
        String[] commandParts, String outputFile) {

        String commandMemSegment = commandParts[1];
        String commandMemSegmentVariable =
            TranslateMemSegment.translate(commandParts[1]);
        String commandMemAddress = commandParts[2];

        outputStream.println("// pop " + commandMemSegment + " " +
            commandMemAddress);

        // Load the target address into D
        if (commandMemSegment.equals("static")) {
            outputStream.println("@" + outputFile + "." + commandMemAddress);
            outputStream.println("D=A");
        } else {
            outputStream.println("@" + commandMemAddress);
            outputStream.println("D=A");

            if (commandMemSegment.equals("temp")) {
                outputStream.println("@5");
                outputStream.println("D=D+A");
            } else if (commandMemSegment.equals("pointer")) {
                outputStream.println("@3");
                outputStream.println("D=D+A");
            } else {
                outputStream.println("@" + commandMemSegmentVariable);
                outputStream.println("D=D+M");
            }
        }

        // Load target address into R13
        outputStream.println("@R13");
        outputStream.println("M=D");

        // Load value from Stack into D
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");

        // Put value from D into target address
        outputStream.println("@R13");
        outputStream.println("A=M");
        outputStream.println("M=D");
    }
}
