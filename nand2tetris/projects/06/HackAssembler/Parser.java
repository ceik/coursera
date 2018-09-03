package HackAssembler;

import java.util.Hashtable;


// The parser's purpose is to translate single lines of Hack Assembly code into
// machine code for the hack computer.
// For a detailed description on how this is supposed to work see:
// https://docs.wixstatic.com/ugd/44046b_b73759b866b249a0b3a715bf5a18f668.pdf
public class Parser {
    static CDictionary cTable;
    static SymbolTable symTable;
    // variableCounter keeps track of the address to put variables into. By
    // definition it starts at address 16.
    static int variableCounter;

    public Parser(CDictionary inputDict, SymbolTable inputSymTable) {
        cTable = inputDict;
        symTable = inputSymTable;
        variableCounter = 16;
    }

    static void processLabel(String labelLine, int lineCounter) {
        String cleanLabel = labelLine.replaceAll("[()]","");
        symTable.table.put(cleanLabel, Integer.toString(lineCounter));
    }

    // c-instructions are structured like: 'dest=comp;jump'. This method breaks
    // them up into their three parts, which need to be translate individually.
    // The components 'dest=' and ';jump' are not always present. In those
    // cases this function should set them to "null" so that translateLine can
    // handle them correctly.
    static String[] tokenizeC(String cLine) {
        String[] splitLine;
        String[] splitLine2;
        String destValue = "null";
        String compValue = "null";
        String jumpValue = "null";
        String[] returnValue = new String[3];

        if (cLine.contains("=")) {
            splitLine = cLine.split("=");
            destValue = splitLine[0];

            if (splitLine[1].contains(";")) {
                splitLine2 = splitLine[1].split(";");
                compValue = splitLine2[0];
                jumpValue = splitLine2[1];
            } else {
                compValue = splitLine[1];
            }
        } else if (cLine.contains(";")) {
            splitLine = cLine.split(";");
            compValue = splitLine[0];
            jumpValue = splitLine[1];
        } else {
            compValue = cLine;
        }

        returnValue[0] = destValue;
        returnValue[1] = compValue;
        returnValue[2] = jumpValue;
        return returnValue;
    }

    // Parse the c-instruction by first tokenizing it and then looking up the
    // three parts in their corresponing hashtables
    static String parseC(String sourceLine) {
        String[] tokenizedC = tokenizeC(sourceLine);

        String destValue = cTable.dest.get(tokenizedC[0]);
        String compValue = cTable.comp.get(tokenizedC[1]);
        String jumpValue = cTable.jump.get(tokenizedC[2]);

        return "111" + compValue + destValue + jumpValue;
    }

    static String parseA(String sourceLine) {
        String aValue = sourceLine.substring(1);
        int intA;
        String outLine;

        // Parse plain a-instructions (which contain only numbers)
        // The output must start with a 0 and be 16 bits long in total
        if (aValue.matches("^\\d+$")) {
            intA = Integer.parseInt(aValue);
            outLine = String.format("0%15s",
                Integer.toBinaryString(intA)).replace(' ', '0');
        // Parse variables
        } else {
            // If the value is not yet in the symbol table, add it
            if (!symTable.table.containsKey(aValue)) {
                symTable.table.put(aValue, Integer.toString(variableCounter));
                variableCounter += 1;
            }
            // Get the value of the variable from the symbol table
            intA = Integer.parseInt(symTable.table.get(aValue));
            outLine = String.format("0%15s",
                Integer.toBinaryString(intA)).replace(' ', '0');
        }

        return outLine;
    }

    // This method is called by HackAssembler to translate all lines.
    // HackAssembler will not write empty lines to output file.
    static String translateLine(String sourceLine) {
        String outLine;
        String[] tokenizedC;

        if (sourceLine.isEmpty()) {
            outLine = "";
        // parse comments
        } else if (sourceLine.substring(0, 2).equals("//")) {
            outLine = "";
        // parse label symbols
        } else if (sourceLine.substring(0, 1).equals("(")) {
            outLine = "";
        // parse A instructions
        } else if (sourceLine.substring(0, 1).equals("@")) {
            outLine = parseA(sourceLine);
        // parse C instructions
        } else {
            outLine = parseC(sourceLine);
        }

        return outLine;
    }
}
