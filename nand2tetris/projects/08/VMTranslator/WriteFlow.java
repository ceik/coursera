package VMTranslator;

import java.io.PrintWriter;

public class WriteFlow {

    static void writeLabel(PrintWriter outputStream, String[] commandParts) {
        outputStream.println("// label " + commandParts[1]);
        outputStream.println("(" + commandParts[1] + ")");
    }

    static void writeIfGoTo(PrintWriter outputStream, String[] commandParts) {
        outputStream.println("// if-goto " + commandParts[1]);
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");
        outputStream.println("@" + commandParts[1]);
        outputStream.println("D;JNE");
    }

    static void writeGoTo(PrintWriter outputStream, String[] commandParts) {
        outputStream.println("// goto " + commandParts[1]);
        outputStream.println("@" + commandParts[1]);
        outputStream.println("0;JMP");
    }
}