package JackCompiler;

public class Term {

    static void compile() {
        String lexElem2Ahead = Parser.peekAhead(2, "lexElem");
        String token2Ahead = Parser.peekAhead(2, "token");

        // integerConstant
        if (Parser.nextLexElem.equals("integerConstant")) {
            Parser.advanceLine();
            Parser.outputStream.println("  push constant " +
                Parser.currTokenValue);

        // stringConstant
        } else if (Parser.nextLexElem.equals("stringConstant")) {
            Parser.advanceLine();
            Parser.outputStream.println("  push constant " +
                Parser.currTokenValue.length());
            Parser.outputStream.println("  call String.new 1");
            // loop through chars and append their ascii to the string
            for (int i = 0, n = Parser.currTokenValue.length(); i < n; i++) {
                Parser.outputStream.println("  push constant " +
                    (int) Parser.currTokenValue.charAt(i));
                Parser.outputStream.println("  call String.appendChar 2");
            }

        // keywordConstant
        } else if (Parser.nextLexElem.equals("keyword") &&
                Parser.nextTokenValue.matches("^true|false|this|null$")) {
            Parser.advanceLine();
            if (Parser.currTokenValue.equals("true")) {
                Parser.outputStream.println("  push constant 1");
                Parser.outputStream.println("  neg");
            } else if (Parser.currTokenValue.matches("^false|null$")) {
                Parser.outputStream.println("  push constant 0");
            } else if (Parser.currTokenValue.equals("this")) {
                Parser.outputStream.println("  push pointer 0");
            }

        // subroutineCall
        } else if (Parser.nextLexElem.equals("identifier") &&
                lexElem2Ahead.equals("symbol") &&
                token2Ahead.matches("^\\(|\\.$")) {
            SubroutineCall.compile();

        // varName
        // If the identifier would be followed by a '(' or '.' this would be a
        // subroutineCall (see above). Logic is duplicated here to be explicit.
        } else if (Parser.nextLexElem.equals("identifier") &&
                !((lexElem2Ahead.equals("symbol")) &&
                  (token2Ahead.matches("^\\(|\\.$")))) {

            Parser.advanceLine();
            Identifier variable = Variable.checkExistenceReturn(
                Parser.currTokenValue);

            Parser.outputStream.println("  push " + variable.getKind() + " " +
                variable.getNumber());

            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextTokenValue.equals("[")) {
                ParserUtils.advanceExpect("symbol", "[");
                Expression.compileExpression();
                ParserUtils.advanceExpect("symbol", "]");
                Parser.outputStream.println("  add");
                Parser.outputStream.println("  pop pointer 1");
                Parser.outputStream.println("  push that 0");
            }

        // (expression)
        } else if (Parser.nextLexElem.equals("symbol") &&
                Parser.nextTokenValue.equals("(")) {
            ParserUtils.advanceExpect("symbol", "(");
            Expression.compileExpression();
            ParserUtils.advanceExpect("symbol", ")");

        // unaryOp term
        } else if (Parser.nextLexElem.equals("symbol") &&
                Parser.nextTokenValue.matches("^\\-|~$")) {
            Parser.advanceLine();
            String unaryOp = ParserUtils.translateUnaryOpCode(
                Parser.currTokenValue);
            Term.compile();
            Parser.outputStream.println(unaryOp);
        }
    }
}
