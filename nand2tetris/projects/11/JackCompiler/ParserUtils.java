package JackCompiler;

public class ParserUtils {

    // Advance the pointer, expect to see certain lexElem and value, throw
    // error if something else is encountered
    static void advanceExpect(String lexElem, String value) {
        Parser.advanceLine();

        if (!(Parser.currLexElem.equals(lexElem) &&
                Parser.currTokenValue.equals(value))) {
            syntaxError(lexElem, value);
        }
    }

    static void advanceExpectRegex(String lexElem, String value) {
        Parser.advanceLine();

        if (!(Parser.currLexElem.equals(lexElem) &&
                Parser.currTokenValue.matches(value))) {
            syntaxError(lexElem, value);
        }
    }

    static void advanceExpect(String lexElem) {
        Parser.advanceLine();

        if (!(Parser.currLexElem.equals(lexElem))) {
            syntaxError(lexElem, "any");
        }
    }

    // Advance the pointer, check if token is a type, and return that type
    static String advanceCheckTypeReturn(boolean allowVoid) {
        Parser.advanceLine();

        if (Parser.currLexElem.equals("keyword") &&
                Parser.currTokenValue.matches("^int|char|boolean$")) {
            return Parser.currTokenValue;
        } else if (Parser.currLexElem.equals("identifier")) {
            return Parser.currTokenValue;
        } else if (allowVoid &&
                Parser.currLexElem.equals("keyword") &&
                Parser.currTokenValue.equals("void")) {
            return Parser.currTokenValue;
        } else {
            invalidTypeError();
        }

        return null;
    }

    static String translateOpCode(String opCode) {
        String returnValue = null;

        switch (opCode) {
            case "+":
                returnValue = "add";
                break;
            case "-":
                returnValue = "sub";
                break;
            case "*":
                returnValue = "call Math.multiply 2";
                break;
            case "/":
                returnValue = "call Math.divide 2";
                break;
            case "&":
                returnValue = "and";
                break;
            case "|":
                returnValue = "or";
                break;
            case "<":
                returnValue = "lt";
                break;
            case ">":
                returnValue = "gt";
                break;
            case "=":
                returnValue = "eq";
                break;
        }

        return "  " + returnValue;
    }

    static String translateUnaryOpCode(String opCode) {
        String returnValue = null;

        switch (opCode) {
            case "-":
                returnValue = "neg";
                break;
            case "~":
                returnValue = "not";
                break;
        }

        return "  " + returnValue;
    }


    static void syntaxError(String lexElem, String value) {
        System.out.println("Syntax Error at token " +
            Integer.toString(Parser.currLine));
        System.out.println("Expected " + lexElem + " '" + value + "'. Found " +
            Parser.currLexElem + " '" + Parser.currTokenValue + "' instead.");
        System.exit(42);
    }

    static void invalidTypeError() {
        System.out.println("Invalid Type Error at token " +
            Integer.toString(Parser.currLine + 1));
        System.exit(42);
    }

    // static void identifierNotFoundError() {
    //     System.out.println("Error, Identifier '" + Parser.currTokenValue +
    //         "' not found");
    //     System.exit(42);
    // }
}