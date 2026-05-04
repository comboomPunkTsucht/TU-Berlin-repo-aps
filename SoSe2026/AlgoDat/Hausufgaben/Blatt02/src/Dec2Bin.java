import java.util.Stack;
/** * A class for constructing a Decimal-to-Binary Number- Converter; * contains a main method for demonstration. */
public class Dec2Bin {

    public Stack<Integer> binStack;  // We make it public to modify it in our tests.
    private int N;

    /**
     * Constructor of an empty object. Use method {@code convert()} to convert a number.
     */
    public Dec2Bin() {
        binStack = new Stack<>();
    }

    /**
     * Returns the number that is converted as {@code int}.
     *
     * @return the converted number
     */
    public int getN() {
        return N;
    }

    /**
     * Converts the given number into binary format, with each digit being represented in a
     * stack of {@code int}.
     *
     * @param N the number that is to be converted.
     */
    public void convert(int N) {
        this.N = N;
        binStack.clear(); // Stack für neue Konvertierung leeren

        if (N == 0) {
            binStack.push(0);
            return;
        }

        int temp = N;
        while (temp > 0) {
            binStack.push(temp % 2); // Rest (0 oder 1) auf den Stack legen
            temp = temp / 2;         // Zahl halbieren
        }
    }

    /**
     * Returns the digits that are stored in {@code binStack} as a string. To is the binary format of the
     * converted number.
     * For testing purpose, we require that the function works also, if the variable {@code binStack} is
     * modified externally.
     *
     * @return a string representation of the number in binary format.
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        Stack<Integer> tempStack = new Stack<>();

        // Stack entleeren und in den String schreiben, dabei in tempStack sichern
        while (!binStack.isEmpty()) {
            int bit = binStack.pop();
            sb.append(bit);
            tempStack.push(bit);
        }

        // Ursprünglichen Stack wiederherstellen
        while (!tempStack.isEmpty()) {
            binStack.push(tempStack.pop());
        }

        return sb.toString();
    }

    public static void main(String[] args) {
        Dec2Bin dec2bin = new Dec2Bin();
        dec2bin.convert(50);
        System.out.println("Die Zahl " + dec2bin.getN() + " in Binärdarstellung: " + dec2bin);
        // Do it another time to demonstrate that toString does not erase the binStack.
        System.out.println("Die Zahl " + dec2bin.getN() + " in Binärdarstellung: " + dec2bin);
    }
}
