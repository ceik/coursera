package VMTranslator;

import java.io.PrintWriter;

public class WriteBootstrap {

    static void bootstrap(PrintWriter outputStream) {
        String[] commandParts = new String[]{"call", "Sys.init", "0"};

        outputStream.println("// Bootstrap Code");
        outputStream.println("// SP=256");
        outputStream.println("@256");
        outputStream.println("D=A");
        outputStream.println("@SP");
        outputStream.println("M=D");

        // Call Sys.init
        WriteFunc.writeCall(outputStream, commandParts,
            "bootstrap", "000");
    }
}
