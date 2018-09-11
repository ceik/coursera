package VMTranslator;

import java.util.HashMap;

public class CleanCodeCatalog {
    // Stores the line number and the content of each relevant line
    public static HashMap<Integer, String[]> map;

    public CleanCodeCatalog() {
        map = new HashMap<Integer, String[]>();
    }
}