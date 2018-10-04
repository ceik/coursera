package VMTranslator;

import java.io.PrintWriter;

public class WriteBool {

    static void writeAnd(PrintWriter outputStream) {
        outputStream.println("// and");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("M=D&M");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }

    static void writeOr(PrintWriter outputStream) {
        outputStream.println("// or");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("M=D|M");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }

    static void writeNot(PrintWriter outputStream) {
        outputStream.println("// not");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("M=!M");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }
}
