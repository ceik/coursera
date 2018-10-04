package JackCompiler;

import java.util.LinkedHashMap;

public class TokenStorage {
    // Stores the token number and the token itself as {lexElem, token}
    public static LinkedHashMap<Integer, String[]> map;

    public TokenStorage() {
        map = new LinkedHashMap<Integer, String[]>();
    }
}