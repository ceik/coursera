package JackCompiler;

public class VariableDeclaration {

    static void declareArgument(String varName, String varType) {
        Parser.subrVars.map.put(varName,
            new Identifier(varType, "argument", Parser.argVarCount));
        Parser.argVarCount++;
    }

    static void declareLocalVar(String varName, String varType) {
        Parser.subrVars.map.put(varName,
            new Identifier(varType, "local", Parser.localVarCount));
        Parser.localVarCount++;
    }

    static void declareClassVarStatic(String varName, String varType) {
        Parser.classVars.map.put(varName,
            new Identifier(varType, "static", Parser.staticVarCount));
        Parser.staticVarCount++;
    }

    static void declareClassVarField(String varName, String varType) {
        Parser.classVars.map.put(varName,
            new Identifier(varType, "this", Parser.fieldVarCount));
        Parser.fieldVarCount++;
    }
}
