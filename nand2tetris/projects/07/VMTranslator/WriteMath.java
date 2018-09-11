package VMTranslator;

import java.io.PrintWriter;

public class WriteMath {

    static void writeAdd(PrintWriter outputStream) {
        outputStream.println("// add");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("M=D+M");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }

    static void writeSub(PrintWriter outputStream) {
        outputStream.println("// sub");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("M=M-D");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }

    static void writeNeg(PrintWriter outputStream) {
        outputStream.println("// neg");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("M=-M");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }
}
