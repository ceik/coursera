package JackCompiler;

public class SubroutineDeclaration {

    static Integer nVars;
    static String currSubrName;
    static String returnType;

    static void compile() {

        Parser.subrVars = new IdentifierStorage();
        Parser.argVarCount = 0;
        Parser.localVarCount = 0;
        Parser.controlFlowCounter = 0;
        String subrType;
        returnType = null;
        nVars = 0;

        ParserUtils.advanceExpectRegex("keyword", "^function|constructor|method$");
        subrType = Parser.currTokenValue;

        // for methods, the object on which it is called is arg 0
        if (subrType.equals("method")) {
            Parser.argVarCount++;
        }

        // Used by Statement.parseReturn
        returnType = ParserUtils.advanceCheckTypeReturn(true);

        // Store subroutine name for later use
        ParserUtils.advanceExpect("identifier");
        currSubrName = Parser.currClassName + "." + Parser.currTokenValue;

        ParserUtils.advanceExpect("symbol", "(");
        Variable.compileSubrArgs();
        ParserUtils.advanceExpect("symbol", ")");

        ParserUtils.advanceExpect("symbol", "{");
        Variable.compileLocalVariables();
        Parser.outputStream.println("function " + currSubrName + " " +
            Integer.toString(nVars));

        if (subrType.equals("constructor")) {
            Parser.outputStream.println("  push constant " +
                Integer.toString(Parser.fieldVarCount));
            Parser.outputStream.println("  call Memory.alloc 1");
            Parser.outputStream.println("  pop pointer 0");
        } else if (subrType.equals("method")) {
            Parser.outputStream.println("  push argument 0");
            Parser.outputStream.println("  pop pointer 0");
        }

        Statement.compileStatements();

        ParserUtils.advanceExpect("symbol", "}");

    }
}
