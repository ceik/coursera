package JackCompiler;

public class Identifier {
    String type;
    String kind;
    Integer number;

    public Identifier(String type, String kind, Integer number) {
        this.type = type;
        this.kind = kind;
        this.number = number;
    }

    String getType() {
        return this.type;
    }

    String getKind() {
        return this.kind;
    }

    Integer getNumber() {
        return this.number;
    }
}
