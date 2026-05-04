/**
 * Repräsentiert einen Druckauftrag
 */
public class Druckauftrag {
    private String Auftraggeber;
    private int Seitenanzahl;

    public Druckauftrag(String Auftraggeber, int Seitenanzahl) {
        this.Auftraggeber = Auftraggeber;
        this.Seitenanzahl = Seitenanzahl;
    }

    public String getAuftraggeber() {
        return Auftraggeber;
    }

    public int getSeitenanzahl() {
        return Seitenanzahl;
    }

    @Override
    public String toString() {
        return "Druckauftrag{" +
                "Auftraggeber='" + Auftraggeber + '\'' +
                ", Seitenanzahl=" + Seitenanzahl +
                '}';
    }
}
