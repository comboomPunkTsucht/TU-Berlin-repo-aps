/**
 * Created by Jannes on 09.04.20.
 */

import java.util.LinkedList;
import java.util.Queue;

public class Drucker extends Elektrogeraete{
    String Netzwerkname;
    Queue<Druckauftrag> Druckauftraege;
    int Tinte;

    public Drucker(String Netzwerkname) {
        this.Netzwerkname = Netzwerkname;
        this.Druckauftraege = new LinkedList<>();
        this.Tinte = 100; // Wir starten mit 100% Tinte
    }

    public void DruckauftragEinreihen(Druckauftrag d) {
        this.Druckauftraege.add(d);
    }

    public void fill() {
        this.Tinte = 100;
        System.out.println("Drucker wurde wieder auf 100% aufgefüllt.");
    }

    private void warten(int Sekunden) {
        try {
            for (int i = 0; i < 20; i++){
                Thread.sleep(Sekunden * 50);
                System.out.print(".");
            }
            System.out.println();

        } catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
        }
    }

    public void getInfo(){
        System.out.println("Aktuelle infromationen zum Drucker: " + this.Netzwerkname);
        System.out.println("Füllstand:                       " + this.Tinte + "%");
        System.out.println("Anstehende Aufträge:             " + this.Druckauftraege.size() + "\n");
        System.out.println("Tage bis zum nächsten Prüfdatum: " + this.TageBisPruefdatum+ "\n");

    }

    public void drucken() {
        if (this.Druckauftraege.isEmpty()) {
            System.out.println("Keine Druckaufträge in der Warteschlange.");
            return;
        }

        while (!this.Druckauftraege.isEmpty()) {
            if (this.Tinte <= 0) {
                System.err.println("Tinte leer! Bitte Drucker auffüllen (fill).");
                return;
            }

            // Hole den nächsten Auftrag aus der Queue
            Druckauftrag aktuell = this.Druckauftraege.poll();

            // Simuliere Drucken (hier ca. 1 Sekunde Wartezeit pro Auftrag)
            System.out.print("Drucke Auftrag... ");
            warten(1);

            // Tinte reduzieren (z.B. pauschal um 10% pro Auftrag,
            // oder angepasst an Seitenanzahl, je nachdem wie Druckauftrag aufgebaut ist)
            this.Tinte -= 10;
            if (this.Tinte < 0) this.Tinte = 0;

            System.out.println(" Fertig!");
        }
        System.out.println("Alle Aufträge wurden gedruckt.");
    }
}
