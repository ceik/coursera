package JackCompiler;

import java.util.LinkedHashMap;

public class IdentifierStorage {
    // Stores a running number and the identifier itself
    LinkedHashMap<String, Identifier> map;

    public IdentifierStorage() {
        map = new LinkedHashMap<String, Identifier>();
    }
}