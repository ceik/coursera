package JackCompiler;

import javax.xml.stream.XMLStreamException;

public class ParseFunctions {

    static void compileClass() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("class");
        Parser.currIndent++;

        compileKeyword("class");
        compileClassName();
        compileSymbol("{");

        // Check for and compile occurances of classVarDec
        Boolean hasNextClassVarDec;
        do {
            if (Parser.nextLexElem.equals("keyword") &&
                    Parser.nextToken.matches("^static|field$")) {
                compileClassVarDec();
                hasNextClassVarDec = true;
            } else {
                hasNextClassVarDec = false;
            }
        } while (hasNextClassVarDec);

        // Check for and compile occurances of SubroutineDec
        Boolean hasNextSubroutineDec;
        do {
            if (Parser.nextLexElem.equals("keyword") &&
                    Parser.nextToken.matches("^constructor|function|method$")) {
                compileSubroutineDec();
                hasNextSubroutineDec = true;
            } else {
                hasNextSubroutineDec = false;
            }
        } while (hasNextSubroutineDec);

        compileSymbol("}");

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("class");
    }

    static void compileClassName() throws XMLStreamException {
        compileIdentifier();
    }

    static void compileClassVarDec() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("classVarDec");
        Parser.currIndent++;

        // (static|field) keyword
        compileKeyword(Parser.nextToken);

        compileType();
        compileVarName();

        // Check for and compile additional occurances of varName
        Boolean hasNextVarName = true;
        while (hasNextVarName) {
            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextToken.equals(",")) {
                compileSymbol(",");
                compileVarName();
            } else {
                hasNextVarName = false;
            }
        }

        compileSymbol(";");

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("classVarDec");
    }

    static void compileExpression() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("expression");
        Parser.currIndent++;

        compileTerm();

        // Check for and compile occurances of (op term)
        Boolean hasNextTerm;
        do {
            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextToken.matches("^\\+|\\-|\\*|/|&|\\||<|>|=$")) {
                compileSymbol(Parser.nextToken);
                compileTerm();
                hasNextTerm = true;
            } else {
                hasNextTerm = false;
            }
        } while (hasNextTerm);

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("expression");
    }

    static void compileExpressionList() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("expressionList");
        Parser.currIndent++;

        // Expression Lists are only used between brackets. So this checks if
        // the bracket gets closed immediately. If so, the expressionList is
        // empty. This is awkward, but because an expression can be so many
        // things, this makes the implementation a lot simpler.
        if (!(Parser.nextLexElem.equals("symbol") &&
                Parser.nextToken.equals(")"))) {
            // Compile the first occurance of an expression
            compileExpression();

            // Check for and compile additional occurances of expressions
            Boolean hasNextExpression = true;
            while (hasNextExpression) {
                if (Parser.nextLexElem.equals("symbol") &&
                        Parser.nextToken.equals(",")) {
                    compileSymbol(",");
                    compileExpression();
                } else {
                    hasNextExpression = false;
                }
            }
        }

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("expressionList");
    }

    static void compileIdentifier() throws XMLStreamException {
        Parser.advanceLine();
        if (Parser.currLexElem.equals("identifier")) {
            XMLWriterUtils.writeXMLNode(Parser.currLexElem, Parser.currToken);
        } else {
            syntaxError();
        }
    }

    static void compileIntegerConstant() throws XMLStreamException {
        Parser.advanceLine();
        if (Parser.currLexElem.equals("integerConstant")) {
            XMLWriterUtils.writeXMLNode(Parser.currLexElem, Parser.currToken);
        } else {
            syntaxError();
        }
    }

    static void compileKeyword(String token) throws XMLStreamException {
        Parser.advanceLine();
        if (Parser.currLexElem.equals("keyword") &&
                Parser.currToken.equals(token)) {
            XMLWriterUtils.writeXMLNode(Parser.currLexElem, Parser.currToken);
        } else {
            syntaxError();
        }
    }

    static void compileParameterList() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("parameterList");
        Parser.currIndent++;

        Boolean hasNextParameter = true;

        // Check for and compile the first occurance of a parameter
        if (Parser.nextLexElem.equals("keyword") &&
                Parser.nextToken.matches("^int|char|boolean$")) {
            compileType();
            compileVarName();
        } else if (Parser.nextLexElem.equals("identifier")) {
            compileType();
            compileVarName();
        } else {
            hasNextParameter = false;
        }

        // Check for and compile additional occurances of parameters
        while (hasNextParameter) {
            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextToken.equals(",")) {
                compileSymbol(",");
                compileType();
                compileVarName();
            } else {
                hasNextParameter = false;
            }
        }

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("parameterList");
    }

    static void compileStatements() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("statements");
        Parser.currIndent++;

        // Check for and compile occurances of statements
        Boolean hasNextStatement;
        do {
            if (Parser.nextLexElem.equals("keyword") &&
                    Parser.nextToken.matches("^let|if|while|do|return$")) {
                compileStatement();
                hasNextStatement = true;
            } else {
                hasNextStatement = false;
            }
        } while (hasNextStatement);

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("statements");
    }

    static void compileStatement() throws XMLStreamException {

        // Call the right compileStatement function depending on the keyword
        if (Parser.nextLexElem.equals("keyword")) {
            if (Parser.nextToken.equals("let")) {
                compileStatementLet();
            } else if (Parser.nextToken.equals("if")) {
                compileStatementIf();
            } else if (Parser.nextToken.equals("while")) {
                compileStatementWhile();
            } else if (Parser.nextToken.equals("do")) {
                compileStatementDo();
            } else if (Parser.nextToken.equals("return")) {
                compileStatementReturn();
            } else {
                syntaxError();
            }
        } else {
            syntaxError();
        }
    }

    static void compileStatementDo() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("doStatement");
        Parser.currIndent++;

        compileKeyword("do");
        compileSubroutineCall();
        compileSymbol(";");

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("doStatement");
    }

    static void compileStatementIf() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("ifStatement");
        Parser.currIndent++;

        compileKeyword("if");
        compileSymbol("(");
        compileExpression();
        compileSymbol(")");
        compileSymbol("{");
        compileStatements();
        compileSymbol("}");

        // check if an else-clase is present and compile it
        if (Parser.nextLexElem.equals("keyword") &&
                Parser.nextToken.equals("else")) {
            compileKeyword("else");
            compileSymbol("{");
            compileStatements();
            compileSymbol("}");
        }

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("ifStatement");
    }

    static void compileStatementLet() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("letStatement");
        Parser.currIndent++;

        compileKeyword("let");
        compileVarName();

        if (Parser.nextToken.equals("[")) {
            compileSymbol("[");
            compileExpression();
            compileSymbol("]");
        }

        compileSymbol("=");
        compileExpression();
        compileSymbol(";");

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("letStatement");
    }

    static void compileStatementReturn() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("returnStatement");
        Parser.currIndent++;

        compileKeyword("return");

        // check if optional expression is present
        if (!(Parser.nextLexElem.equals("symbol") &&
                Parser.nextToken.equals(";"))) {
            compileExpression();
        }

        compileSymbol(";");

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("returnStatement");
    }

    static void compileStatementWhile() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("whileStatement");
        Parser.currIndent++;

        compileKeyword("while");
        compileSymbol("(");
        compileExpression();
        compileSymbol(")");
        compileSymbol("{");
        compileStatements();
        compileSymbol("}");

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("whileStatement");
    }

    static void compileStringConstant() throws XMLStreamException {
        Parser.advanceLine();
        if (Parser.currLexElem.equals("stringConstant")) {
            XMLWriterUtils.writeXMLNode(Parser.currLexElem, Parser.currToken);
        } else {
            syntaxError();
        }
    }

    static void compileSubroutineBody() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("subroutineBody");
        Parser.currIndent++;

        compileSymbol("{");

        // Check for and compile occurances of varDec
        Boolean hasNextVarDec;
        do {
            if (Parser.nextLexElem.equals("keyword") &&
                    Parser.nextToken.equals("var")) {
                compileVarDec();
                hasNextVarDec = true;
            } else {
                hasNextVarDec = false;
            }
        } while (hasNextVarDec);

        compileStatements();
        compileSymbol("}");

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("subroutineBody");
    }

    static void compileSubroutineCall() throws XMLStreamException {

        // technically this can also be a className or varName, but since they
        // are all just identifiers, it doesn't make a difference
        compileSubroutineName();

        // if the previous identifier is a class- or varName, it is followed by
        // ".subroutineName"
        if (Parser.nextLexElem.equals("symbol") &&
                Parser.nextToken.equals(".")) {
            compileSymbol(".");
            compileSubroutineName();
        }

        compileSymbol("(");
        compileExpressionList();
        compileSymbol(")");
    }

    static void compileSubroutineDec() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("subroutineDec");
        Parser.currIndent++;

        // (constructor|function|method)
        compileKeyword(Parser.nextToken);

        if (Parser.nextLexElem.equals("keyword") &&
                Parser.nextToken.equals("void")) {
            compileKeyword("void");
        } else {
            compileType();
        }

        compileSubroutineName();
        compileSymbol("(");
        compileParameterList();
        compileSymbol(")");
        compileSubroutineBody();

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("subroutineDec");
    }

    static void compileSubroutineName() throws XMLStreamException {
        compileIdentifier();
    }

    static void compileSymbol(String token) throws XMLStreamException {
        Parser.advanceLine();

        if (Parser.currLexElem.equals("symbol") &&
                Parser.currToken.equals(token)) {
            XMLWriterUtils.writeXMLNode(Parser.currLexElem, token);
        }
    }

    static void compileTerm() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("term");
        Parser.currIndent++;

        String lexElem2Ahead = Parser.peekAhead(2, "lexElem");
        String token2Ahead = Parser.peekAhead(2, "token");

        // integerConstant
        if (Parser.nextLexElem.equals("integerConstant")) {
            compileIntegerConstant();
        // stringConstant
        } else if (Parser.nextLexElem.equals("stringConstant")) {
            compileStringConstant();
        // keywordConstant
        } else if (Parser.nextLexElem.equals("keyword") &&
                Parser.nextToken.matches("^true|false|null|this$")) {
            compileKeyword(Parser.nextToken);
        // varName
        } else if (Parser.nextLexElem.equals("identifier") &&
                !((lexElem2Ahead.equals("symbol")) &&
                  (token2Ahead.matches("^\\(|\\.$")))) {

            compileVarName();
            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextToken.equals("[")) {
                compileSymbol("[");
                compileExpression();
                compileSymbol("]");
            }

        // subroutineCall
        } else if (Parser.nextLexElem.equals("identifier") &&
                lexElem2Ahead.equals("symbol") &&
                token2Ahead.matches("^\\(|\\.$")) {
            compileSubroutineCall();
        // (expression)
        } else if (Parser.nextLexElem.equals("symbol") &&
                Parser.nextToken.equals("(")) {
            compileSymbol("(");
            compileExpression();
            compileSymbol(")");
        // unaryOp term
        } else if (Parser.nextLexElem.equals("symbol") &&
                Parser.nextToken.matches("^\\-|~$")) {
            compileUnaryOp();
            compileTerm();
        } else {
            System.out.println("now what?");
        }


        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("term");
    }

    static void compileType() throws XMLStreamException {
        if (Parser.nextLexElem.equals("keyword") &&
                Parser.nextToken.matches("^int|char|boolean$")) {
            compileKeyword(Parser.nextToken);
        } else if (Parser.nextLexElem.equals("identifier")) {
            compileIdentifier();
        } else {
            syntaxError();
        }
    }

    static void compileUnaryOp() throws XMLStreamException {
        if (Parser.nextLexElem.equals("symbol") &&
                Parser.nextToken.matches("^\\-|~$")) {
            compileSymbol(Parser.nextToken);
        } else {
            syntaxError();
        }
    }

    static void compileVarDec() throws XMLStreamException {
        XMLWriterUtils.writeXMLStart("varDec");
        Parser.currIndent++;

        compileKeyword("var");
        compileType();
        compileVarName();

        // Check for and compile additional occurances of varName
        Boolean hasNextVarName = true;
        while (hasNextVarName) {
            if (Parser.nextLexElem.equals("symbol") &&
                    Parser.nextToken.equals(",")) {
                compileSymbol(",");
                compileVarName();
            } else {
                hasNextVarName = false;
            }
        }

        compileSymbol(";");

        Parser.currIndent--;
        XMLWriterUtils.writeXMLEnd("varDec");
    }

    static void compileVarName() throws XMLStreamException {
        compileIdentifier();
    }

    static void syntaxError() {
        System.out.println("Syntax Error at token " +
            Integer.toString(Parser.currLine + 1));
        System.exit(42);
    }
}
