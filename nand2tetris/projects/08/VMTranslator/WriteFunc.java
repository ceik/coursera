package VMTranslator;

import java.io.PrintWriter;

public class WriteFunc {

    static void writeCall(PrintWriter outputStream, String[] commandParts,
            String inputFileName, String lineNumber) {
        String functionName = commandParts[1];
        String nVars = commandParts[2];
        Integer argOffset = Integer.parseInt(nVars) + 5;

        outputStream.println("// call " + functionName + " " + nVars);
        // push return address
        outputStream.println("@" + inputFileName + "$" +
            lineNumber);
        outputStream.println("D=A");
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=D");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
        // push LCL
        outputStream.println("@LCL");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=D");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
        // push ARG
        outputStream.println("@ARG");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=D");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
        // push THIS
        outputStream.println("@THIS");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=D");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
        // push THAT
        outputStream.println("@THAT");
        outputStream.println("D=M");
        outputStream.println("@SP");
        outputStream.println("A=M");
        outputStream.println("M=D");
        outputStream.println("@SP");
        outputStream.println("M=M+1");
        // ARG = SP - nArgs - 5
        outputStream.println("@SP");
        outputStream.println("D=M");
        outputStream.println("@" + Integer.toString(argOffset));
        outputStream.println("D=D-A");
        outputStream.println("@ARG");
        outputStream.println("M=D");
        // LCL = SP
        outputStream.println("@SP");
        outputStream.println("D=M");
        outputStream.println("@LCL");
        outputStream.println("M=D");
        // goto function
        outputStream.println("@" + functionName);
        outputStream.println("0;JMP");
        // return label
        outputStream.println("(" + inputFileName + "$" + lineNumber + ")");
    }

    static void writeFunction(PrintWriter outputStream, String[] commandParts) {
        String functionName = commandParts[1];
        String nVars = commandParts[2];

        outputStream.println("// function " + functionName + " " + nVars);
        outputStream.println("(" + functionName + ")");

        for (int i=0; i<Integer.parseInt(nVars); i++) {
            outputStream.println("@SP");
            outputStream.println("A=M");
            outputStream.println("M=0");
            outputStream.println("@SP");
            outputStream.println("M=M+1");

        }
    }

    static void writeReturn(PrintWriter outputStream) {

        outputStream.println("// return");

        // frame = LCL
        outputStream.println("@LCL");
        outputStream.println("D=M");
        outputStream.println("@frame");
        outputStream.println("M=D");

        // retAddr = *(frame - 5)
        outputStream.println("@5");
        outputStream.println("A=D-A");
        outputStream.println("D=M");
        outputStream.println("@retAddr");
        outputStream.println("M=D");

        // *ARG = pop
        outputStream.println("@SP");
        outputStream.println("M=M-1");
        outputStream.println("A=M");
        outputStream.println("D=M");
        outputStream.println("@ARG");
        outputStream.println("A=M");
        outputStream.println("M=D");

        // SP = ARG + 1
        outputStream.println("D=A+1");
        outputStream.println("@SP");
        outputStream.println("M=D");

        // THAT = *(frame - 1)
        outputStream.println("@frame");
        outputStream.println("A=M-1");
        outputStream.println("D=M");
        outputStream.println("@THAT");
        outputStream.println("M=D");

        // THIS = *(frame - 2)
        outputStream.println("@2");
        outputStream.println("D=A");
        outputStream.println("@frame");
        outputStream.println("A=M-D");
        outputStream.println("D=M");
        outputStream.println("@THIS");
        outputStream.println("M=D");

        // ARG = *(frame - 3)
        outputStream.println("@3");
        outputStream.println("D=A");
        outputStream.println("@frame");
        outputStream.println("A=M-D");
        outputStream.println("D=M");
        outputStream.println("@ARG");
        outputStream.println("M=D");

        // LCL = *(frame - 4)
        outputStream.println("@4");
        outputStream.println("D=A");
        outputStream.println("@frame");
        outputStream.println("A=M-D");
        outputStream.println("D=M");
        outputStream.println("@LCL");
        outputStream.println("M=D");

        //goto retAddr
        outputStream.println("@retAddr");
        outputStream.println("A=M");
        outputStream.println("0;JMP");

    }
}