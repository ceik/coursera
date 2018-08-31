package HackAssembler;

import java.util.Hashtable;

// Stores Hashtables for the translation of c-instructions
public class SymbolTable {
    public static Hashtable<String, String> dest;
    public static Hashtable<String, String> comp;
    public static Hashtable<String, String> jump;

    public static void setDest(Hashtable<String, String> table) {
        table.put("null", "000");
        table.put("M", "001");
        table.put("D", "010");
        table.put("MD", "011");
        table.put("A", "100");
        table.put("AM", "101");
        table.put("AD", "110");
        table.put("AMD", "111");
    }

    public static void setComp(Hashtable<String, String> table) {
        table.put("null", "0000000");
        table.put("0", "0101010");
        table.put("1", "0111111");
        table.put("-1", "0111010");
        table.put("D", "0001100");
        table.put("A", "0110000");
        table.put("!D", "0001101");
        table.put("!A", "0110001");
        table.put("-D", "0001111");
        table.put("-A", "0110011");
        table.put("D+1", "0011111");
        table.put("A+1", "0110111");
        table.put("D-1", "0001110");
        table.put("A-1", "0110010");
        table.put("D+A", "0000010");
        table.put("D-A", "0010011");
        table.put("A-D", "0000111");
        table.put("D&A", "0000000");
        table.put("D|A", "0010101");
        table.put("M", "1110000");
        table.put("!M", "1110001");
        table.put("-M", "1110011");
        table.put("M+1", "1110111");
        table.put("M-1", "1110010");
        table.put("D+M", "1000010");
        table.put("D-M", "1010011");
        table.put("M-D", "1000111");
        table.put("D&M", "1000000");
        table.put("D|M", "1010101");
    }

    public static void setJump(Hashtable<String, String> table) {
        table.put("null", "000");
        table.put("JGT", "001");
        table.put("JEQ", "010");
        table.put("JGE", "011");
        table.put("JLT", "100");
        table.put("JNE", "101");
        table.put("JLE", "110");
        table.put("JMP", "111");
    }

    public cDictionary() {
        dest = new Hashtable<String, String>();
        comp = new Hashtable<String, String>();
        jump = new Hashtable<String, String>();
        setDest(dest);
        setComp(comp);
        setJump(jump);
    }
}
