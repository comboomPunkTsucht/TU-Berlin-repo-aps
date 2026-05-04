/**
 * Basisklasse für elektronische Geräte
 */
public abstract class Elektrogeraete {
    protected int TageBisPruefdatum;

    public Elektrogeraete() {
        this.TageBisPruefdatum = 365;
    }

    public abstract void fill();

    public void getInfo() {
        System.out.println("Tage bis zum nächsten Prüfdatum: " + TageBisPruefdatum);
    }
}
