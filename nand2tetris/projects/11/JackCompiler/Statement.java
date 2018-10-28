package JackCompiler;

public class Statement {

    static void compileStatements() {
        // Check for and compile occurances of statements
        Boolean hasNextStatement;
        do {
            if (Parser.nextLexElem.equals("keyword") &&
                    Parser.nextTokenValue.matches("^let|if|while|do|return$")) {
                compileStatement();
                hasNextStatement = true;
            } else {
                hasNextStatement = false;
            }
        } while (hasNextStatement);
    }

    static void compileStatement() {
        // Call the right statement parsing function depending on the keyword
        if (Parser.nextLexElem.equals("keyword")) {
            if (Parser.nextTokenValue.equals("do")) {
                parseDo();
            } else if (Parser.nextTokenValue.equals("if")) {
                parseIf();
            } else if (Parser.nextTokenValue.equals("let")) {
                parseLet();
            } else if (Parser.nextTokenValue.equals("return")) {
                parseReturn();
            } else if (Parser.nextTokenValue.equals("while")) {
                parseWhile();
            } else {
                ParserUtils.syntaxError("keyword", "do|if|let|return|while");
            }
        } else {
            ParserUtils.syntaxError("keyword", "do|if|let|return|while");
        }
    }


    static void parseDo() {
        ParserUtils.advanceExpect("keyword", "do");
        SubroutineCall.compile();
        // subroutine calls in a do-statement should always be calls to void
        // methods, which require popping the returned value to garbage
        Parser.outputStream.println("  pop temp 0");
        ParserUtils.advanceExpect("symbol", ";");
    }

    static void parseIf() {
        String currStatementSubrName = SubroutineDeclaration.currSubrName;
        Integer currStatementControlFlowCounter = Parser.controlFlowCounter;
        Parser.controlFlowCounter++;

        ParserUtils.advanceExpect("keyword", "if");

        ParserUtils.advanceExpect("symbol", "(");
        Expression.compileExpression();
        Parser.outputStream.println("  not");
        ParserUtils.advanceExpect("symbol", ")");

        Parser.outputStream.println("  if-goto elseClause" +
            currStatementSubrName + "." + Parser.currClassName +
            Integer.toString(currStatementControlFlowCounter));

        ParserUtils.advanceExpect("symbol", "{");
        compileStatements();
        ParserUtils.advanceExpect("symbol", "}");

        Parser.outputStream.println("  goto end" +
            currStatementSubrName + "." + Parser.currClassName +
            Integer.toString(currStatementControlFlowCounter));

        Parser.outputStream.println("label elseClause" +
            currStatementSubrName + "." + Parser.currClassName +
            Integer.toString(currStatementControlFlowCounter));

        if (Parser.nextLexElem.equals("keyword") &&
                Parser.nextTokenValue.equals("else")) {
            ParserUtils.advanceExpect("keyword", "else");
            ParserUtils.advanceExpect("symbol", "{");
            compileStatements();
            ParserUtils.advanceExpect("symbol", "}");
        }

        Parser.outputStream.println("label end" +
            currStatementSubrName + "." + Parser.currClassName +
            Integer.toString(currStatementControlFlowCounter));
    }

    static void parseLet() {
        ParserUtils.advanceExpect("keyword", "let");
        Variable.assign();
        ParserUtils.advanceExpect("symbol", ";");
    }

    static void parseReturn() {
        ParserUtils.advanceExpect("keyword", "return");

        if (!(Parser.nextLexElem.equals("symbol") &&
                Parser.nextTokenValue.equals(";"))) {
            Expression.compileExpression();
        } else if (SubroutineDeclaration.returnType.equals("void")) {
            Parser.outputStream.println("  push constant 0");
        }
        Parser.outputStream.println("  return");
        ParserUtils.advanceExpect("symbol", ";");
    }

    static void parseWhile() {
        String currStatementSubrName = SubroutineDeclaration.currSubrName;
        Integer currStatementControlFlowCounter = Parser.controlFlowCounter;
        Parser.controlFlowCounter++;

        ParserUtils.advanceExpect("keyword", "while");

        Parser.outputStream.println("label whileStart" +
            currStatementSubrName + "." + Parser.currClassName +
            Integer.toString(currStatementControlFlowCounter));
        ParserUtils.advanceExpect("symbol", "(");
        Expression.compileExpression();
        Parser.outputStream.println("  not");
        ParserUtils.advanceExpect("symbol", ")");

        Parser.outputStream.println("  if-goto whileEnd" +
            currStatementSubrName + "." + Parser.currClassName +
            Integer.toString(currStatementControlFlowCounter));
        ParserUtils.advanceExpect("symbol", "{");
        compileStatements();
        ParserUtils.advanceExpect("symbol", "}");

        Parser.outputStream.println("  goto whileStart" +
            currStatementSubrName + "." + Parser.currClassName +
            Integer.toString(currStatementControlFlowCounter));

        Parser.outputStream.println("label whileEnd" +
            currStatementSubrName + "." + Parser.currClassName +
            Integer.toString(currStatementControlFlowCounter));
    }
}
