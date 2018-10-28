package JackCompiler;


public class Class {

    static void compile() {
        Parser.outputStream.println("// class start");

        Parser.classVars = new IdentifierStorage();
        Parser.staticVarCount = 0;
        Parser.fieldVarCount = 0;

        ParserUtils.advanceExpect("keyword", "class");

        parseClassName();

        ParserUtils.advanceExpect("symbol", "{");

        Variable.compileClassVars();

        Boolean hasNextSubroutineDec;
        do {
            if (Parser.nextLexElem.equals("keyword") &&
                    Parser.nextTokenValue.matches(
                        "^constructor|function|method$")) {
                SubroutineDeclaration.compile();
                hasNextSubroutineDec = true;
            } else {
                hasNextSubroutineDec = false;
            }
        } while (hasNextSubroutineDec);

        ParserUtils.advanceExpect("symbol", "}");

        Parser.outputStream.println("// class end");
    }

    static void parseClassName() {
        ParserUtils.advanceExpect("identifier");
        Parser.outputStream.println("// class name: " + Parser.currTokenValue);
        Parser.currClassName = Parser.currTokenValue;
    }
}