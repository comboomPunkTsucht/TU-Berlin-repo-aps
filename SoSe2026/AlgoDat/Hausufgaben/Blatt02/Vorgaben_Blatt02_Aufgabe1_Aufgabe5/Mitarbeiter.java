/**
 * Repräsentiert einen Mitarbeiter
 */
public class Mitarbeiter {
    private String Name;
    private int MitarbeiterNummer;

    public Mitarbeiter(String Name, int MitarbeiterNummer) {
        this.Name = Name;
        this.MitarbeiterNummer = MitarbeiterNummer;
    }

    public String getName() {
        return Name;
    }

    public int getMitarbeiterNummer() {
        return MitarbeiterNummer;
    }

    @Override
    public String toString() {
        return "Mitarbeiter{" +
                "Name='" + Name + '\'' +
                ", MitarbeiterNummer=" + MitarbeiterNummer +
                '}';
    }
}
