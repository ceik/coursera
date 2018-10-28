package JackCompiler;

import java.util.LinkedHashMap;

public class TokenStorage {
    // Stores a running token number and the token itself
    LinkedHashMap<Integer, Token> map;

    public TokenStorage() {
        map = new LinkedHashMap<Integer, Token>();
    }
}
