package JackCompiler;

public class Token {
    String lexElem;
    String value;

    Token(String lexElem, String value) {
        this.lexElem = lexElem;
        this.value = value;
    }

    String getLexElem() {
        return this.lexElem;
    }

    String getValue() {
        return this.value;
    }
}
