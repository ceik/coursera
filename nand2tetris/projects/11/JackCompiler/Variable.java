package JackCompiler;

public class Variable {

    static void compileClassVars() {
        // Check for and compile occurances of classVarDec
        Boolean hasNextClassVarDec;
        do {
            if (Parser.nextLexElem.equals("keyword") &&
                    Parser.nextTokenValue.matches("^static|field$")) {
                compileClassVar();
                hasNextClassVarDec = true;
            } else {
                hasNextClassVarDec = false;
            }
        } while (hasNextClassVarDec);
    }

    static void compileClassVar() {
        // Pattern: ('static'|'field') type varName (',' varName)*';'

        String varType;
        String varName;
        String varKind;

        ParserUtils.advanceExpectRegex("keyword", "^static|field$");
        varKind = Parser.currTokenValue;
        varType = ParserUtils.advanceCheckTypeReturn(false);

        ParserUtils.advanceExpect("identifier");
        varName = Parser.currTokenValue;

        if (varKind.equals("static")) {
            VariableDeclaration.declareClassVarStatic(varName, varType);
        } else if (varKind.equals("field")) {
            VariableDeclaration.declareClassVarField(varName, varType);
        }

        // Check for and compile additional occurances of varName
        Boolean hasNextVarName = true;
        while (hasNextVarName) {
            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextTokenValue.equals(",")) {
                ParserUtils.advanceExpect("symbol", ",");
                ParserUtils.advanceExpect("identifier");
                varName = Parser.currTokenValue;
                if (varKind.equals("static")) {
                    VariableDeclaration.declareClassVarStatic(varName, varType);
                } else if (varKind.equals("field")) {
                    VariableDeclaration.declareClassVarField(varName, varType);
                }
            } else {
                hasNextVarName = false;
            }
        }

        ParserUtils.advanceExpect("symbol", ";");
    }

    static void compileLocalVariables() {
        // Check for and compile occurances of varDec in a subroutine
        Boolean hasNextVarDec;
        do {
            if (Parser.nextLexElem.equals("keyword") &&
                    Parser.nextTokenValue.equals("var")) {
                compileLocalVariable();
                hasNextVarDec = true;
            } else {
                hasNextVarDec = false;
            }
        } while (hasNextVarDec);
    }

    static void compileLocalVariable() {
        // Pattern: 'var' type varName (',' varName)*';'

        String varType;
        String varName;

        ParserUtils.advanceExpect("keyword", "var");
        varType = ParserUtils.advanceCheckTypeReturn(false);

        ParserUtils.advanceExpect("identifier");
        varName = Parser.currTokenValue;

        VariableDeclaration.declareLocalVar(varName, varType);
        SubroutineDeclaration.nVars++;

        // Check for and compile additional occurances of varName
        Boolean hasNextVarName = true;
        while (hasNextVarName) {
            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextTokenValue.equals(",")) {
                ParserUtils.advanceExpect("symbol", ",");
                ParserUtils.advanceExpect("identifier");
                varName = Parser.currTokenValue;
                VariableDeclaration.declareLocalVar(varName, varType);
                SubroutineDeclaration.nVars++;
            } else {
                hasNextVarName = false;
            }
        }

        ParserUtils.advanceExpect("symbol", ";");
    }

    static void compileSubrArgs() {
        String varType;
        String varName;
        Boolean hasNextParameter = true;
        Integer varCounter = 0;

        // Check for and compile the first occurance of an argument
        if ((Parser.nextLexElem.equals("keyword") &&
                Parser.nextTokenValue.matches("^int|char|boolean$")) ||
                Parser.nextLexElem.equals("identifier")) {

            varType = ParserUtils.advanceCheckTypeReturn(false);
            ParserUtils.advanceExpect("identifier");
            varName = Parser.currTokenValue;
            VariableDeclaration.declareArgument(varName, varType);
        } else {
            hasNextParameter = false;
        }

        // Check for and compile additional occurances of argument
        while (hasNextParameter) {
            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextTokenValue.equals(",")) {

                ParserUtils.advanceExpect("symbol", ",");
                varType = ParserUtils.advanceCheckTypeReturn(false);
                ParserUtils.advanceExpect("identifier");
                varName = Parser.currTokenValue;
                VariableDeclaration.declareArgument(varName, varType);
            } else {
                hasNextParameter = false;
            }
        }
    }

    static void assign() {
        // Pattern: varName('['expression']')? '=' expression ';'

        Identifier target;
        Boolean isArray = false;

        ParserUtils.advanceExpect("identifier");
        target = checkExistenceReturn(Parser.currTokenValue);

        if (Parser.nextLexElem.equals("symbol") &&
                Parser.nextTokenValue.equals("[")) {
            ParserUtils.advanceExpect("symbol", "[");
            Expression.compileExpression();
            Parser.outputStream.println("  pop temp 1");
            ParserUtils.advanceExpect("symbol", "]");
            isArray = true;
        }

        ParserUtils.advanceExpect("symbol", "=");

        Expression.compileExpression();

        if (isArray) {
            Parser.outputStream.println("  push " + target.getKind() + " " +
                target.getNumber());
            Parser.outputStream.println("  push temp 1");
            Parser.outputStream.println("  add");
            Parser.outputStream.println("  pop pointer 1");
            Parser.outputStream.println("  pop that 0");
        } else {
            Parser.outputStream.println("  pop " + target.getKind() + " " + target.getNumber());
        }
    }

    static Identifier checkExistenceReturn(String varName) {
        Identifier subrVar;
        Identifier classVar;

        subrVar = Parser.subrVars.map.get(varName);
        classVar = Parser.classVars.map.get(varName);
        if (subrVar != null) {
            return subrVar;
        } else if (classVar != null) {
            return classVar;
        } else {
            return null;
        }
    }
}
