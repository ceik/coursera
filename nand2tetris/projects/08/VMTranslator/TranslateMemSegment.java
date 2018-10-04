package VMTranslator;

public class TranslateMemSegment {

    static String translate(String memSegment) {
        String segmentVariable;

        switch (memSegment) {
            case "local":
                segmentVariable = "LCL";
                break;
            case "argument":
                segmentVariable = "ARG";
                break;
            case "this":
                segmentVariable = "THIS";
                break;
            case "that":
                segmentVariable = "THAT";
                break;
            default:
                segmentVariable = null;
                break;
        }
        return segmentVariable;
    }
}
