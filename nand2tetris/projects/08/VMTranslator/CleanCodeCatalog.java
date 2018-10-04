package VMTranslator;

import java.util.LinkedHashMap;

public class CleanCodeCatalog {
    // Stores the line number and the content of each relevant line
    public static LinkedHashMap<String[], String[]> map;

    public CleanCodeCatalog() {
        map = new LinkedHashMap<String[], String[]>();
    }
}