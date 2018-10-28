package JackCompiler;

public class SubroutineCall {

    static void compile() {
        // subroutineName(expressionList) | (className|varName).SubroutineName(expressionList)
        String className = null;
        String subroutineName = null;
        Integer nArgs = 0;
        String methArg = null;
        Identifier methodVar;

        ParserUtils.advanceExpect("identifier");

        methodVar = Variable.checkExistenceReturn(Parser.currTokenValue);
        if (methodVar != null) {
            Parser.outputStream.println("  push " + methodVar.getKind() + " " +
                methodVar.getNumber());
            className = methodVar.getType();
            ParserUtils.advanceExpect("symbol", ".");

            Parser.advanceLine();
            subroutineName = Parser.currTokenValue;
            nArgs++;
        } else if (Parser.nextLexElem.equals("symbol") &&
                Parser.nextTokenValue.equals(".")) {
            className = Parser.currTokenValue;

            ParserUtils.advanceExpect("symbol", ".");

            Parser.advanceLine();
            subroutineName = Parser.currTokenValue;
        // subroutine calls without a classname are always local methods calls,
        // in which case a reference to itself needs to be pushed onto the stack
        } else {
            Parser.outputStream.println("  push pointer 0");
            className = Parser.currClassName;
            subroutineName =  Parser.currTokenValue;
            nArgs++;
        }

        ParserUtils.advanceExpect("symbol", "(");
        nArgs += Expression.compileExpressionList(methArg);
        ParserUtils.advanceExpect("symbol", ")");

        Parser.outputStream.println("  call " + className + "." +
            subroutineName + " " + Integer.toString(nArgs));
    }
}
