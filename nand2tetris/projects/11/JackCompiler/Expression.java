package JackCompiler;

public class Expression {

    static Integer compileExpressionList(String methArg) {
        Integer nArgs = 0;

        if (!(methArg == null)) {
            Parser.outputStream.println("push methArg");
            nArgs++;
        }

        // If the next immediate token is a closing bracket, the Expression
        // List is empty
        if (!(Parser.nextLexElem.equals("symbol") &&
                Parser.nextTokenValue.equals(")"))) {
            // Compile the first occurance of an expression
            compileExpression();
            nArgs++;

            // Check for and compile additional occurances of Expression
            Boolean hasNextExpression = true;
            while (hasNextExpression) {
                if (Parser.nextLexElem.equals("symbol") &&
                        Parser.nextTokenValue.equals(",")) {
                    ParserUtils.advanceExpect("symbol", ",");
                    compileExpression();
                    nArgs++;
                } else {
                    hasNextExpression = false;
                }
            }
        }

        return nArgs;
    }

    static void compileExpression() {
        String opStorage = null;

        Term.compile();

        // Check for and compile occurances of (op term)
        Boolean hasNextTerm;
        do {
            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextTokenValue.matches(
                        "^\\+|\\-|\\*|/|&|\\||<|>|=$")) {
                Parser.advanceLine();
                opStorage = ParserUtils.translateOpCode(Parser.currTokenValue);
                Term.compile();
                Parser.outputStream.println(opStorage);
                hasNextTerm = true;
            } else {
                hasNextTerm = false;
            }
        } while (hasNextTerm);
    }
}