package VMTranslator;

import java.io.PrintWriter;

public class WriteCompare {

    static void writeEq(PrintWriter outputStream, String lineNumber) {
        outputStream.println("// eq");
        // Calculate Difference
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=D-M");
        // Jump to TRUE if D=0
        outputStream.println("@TRUE" + lineNumber);
        outputStream.println("D;JEQ");
        // Else it's FALSE, set value at pointer to 0
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=0");
        outputStream.println("@ENDEQ" + lineNumber);
        outputStream.println("0;JMP");
        // TRUE: Set value at pointer to -1
        outputStream.println("(TRUE" + lineNumber + ")");
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=-1");
        // Increment pointer
        outputStream.println("(ENDEQ" + lineNumber + ")");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }

    static void writeLt(PrintWriter outputStream, String lineNumber) {
        outputStream.println("// lt");
        // Calculate Difference
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=D-M");
        // Jump to TRUE if D>0
        outputStream.println("@TRUE" + lineNumber);
        outputStream.println("D;JGT");
        // Else it's FALSE, set value at pointer to 0
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=0");
        outputStream.println("@ENDEQ" + lineNumber);
        outputStream.println("0;JMP");
        // TRUE: Set value at pointer to -1
        outputStream.println("(TRUE" + lineNumber + ")");
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=-1");
        // Increment pointer
        outputStream.println("(ENDEQ" + lineNumber + ")");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }

    static void writeGt(PrintWriter outputStream, String lineNumber) {
        outputStream.println("// gt");
        // Calculate Difference
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=D-M");
        // Jump to TRUE if D<0
        outputStream.println("@TRUE" + lineNumber);
        outputStream.println("D;JLT");
        // Else it's FALSE, set value at pointer to 0
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=0");
        outputStream.println("@ENDEQ" + lineNumber);
        outputStream.println("0;JMP");
        // True: Set value at pointer to -1
        outputStream.println("(TRUE" + lineNumber + ")");
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=-1");
        // Increment pointer
        outputStream.println("(ENDEQ" + lineNumber + ")");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
    }
}
