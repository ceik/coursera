package HackAssembler;

import java.util.Hashtable;

// The parser's purpose is to translate single lines of Hack Assembly code into
// machine code for the hack computer.
// For a detailed description on how this is supposed to work see:
// https://docs.wixstatic.com/ugd/44046b_b73759b866b249a0b3a715bf5a18f668.pdf
public class Parser {
    static cDictionary dict;

    public Parser(cDictionary inputDict) {
        dict = inputDict;
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

    // This method is called by HackAssembler to translate all lines.
    // HackAssembler will not write empty lines to output file.
    static String translateLine(String sourceLine) {
        String outLine;
        int intA;
        String[] tokenizedC;

        if (sourceLine.isEmpty()) {
            outLine = "";

        // parse comments
        } else if (sourceLine.substring(0, 2).equals("//")) {
            outLine = "";

        // parse A instructions
        } else if (sourceLine.substring(0, 1).equals("@")) {
            intA = Integer.parseInt(sourceLine.substring(1));
            outLine = String.format("0%15s",
                Integer.toBinaryString(intA)).replace(' ', '0');

        // parse C instructions
        } else {
            tokenizedC = tokenizeC(sourceLine);
            String destValue = dict.dest.get(tokenizedC[0]);
            String compValue = dict.comp.get(tokenizedC[1]);
            String jumpValue = dict.jump.get(tokenizedC[2]);

            outLine = "111" + compValue + destValue + jumpValue;
        }

        return outLine;
    }
}
