// Diese Klasse implementiert nur *zentrierte* reguläre Polygone, also mit midpoint = (0, 0).

public class RegularPolygon extends ConvexPolygon {

    private int N;
    private double radius;

    public RegularPolygon(int N, double radius) {
        super(createVertices(N, radius));
        this.N = N;
        this.radius = radius;
    }

    public RegularPolygon(RegularPolygon polygon) {
        super(polygon.vertices);
        this.N = polygon.N;
        this.radius = polygon.radius;
        // Note: This is a shallow copy of vertices (both objects reference same Vector2D objects)
        // This is intentional - changes to polygon won't affect this copy because resize() updates vertices
    }

    private static Vector2D[] createVertices(int N, double radius) {
        Vector2D[] vertices = new Vector2D[N];
        double angleStep = 2 * Math.PI / N;

        for (int i = 0; i < N; i++) {
            double angle = i * angleStep;
            double x = radius * Math.cos(angle);
            double y = radius * Math.sin(angle);
            vertices[i] = new Vector2D(x, y);
        }

        return vertices;
    }

    public void resize(double newradius) {
        this.radius = newradius;
        Vector2D[] newVertices = createVertices(N, newradius);
        for (int i = 0; i < N; i++) {
            this.vertices[i] = newVertices[i];
        }
    }

    @Override
    public String toString() {
        return "RegularPolygon{N=" + N + ", radius=" + radius + "}";
    }

    public static void main(String[] args) {
        RegularPolygon pentagon = new RegularPolygon(5, 1);
        System.out.println("Der Flächeninhalt des " + pentagon + " beträgt " + pentagon.area() + " LE^2.");
        // RegularPolygon otherpentagon = pentagon; // Dies funktioniert nicht!
        RegularPolygon otherpentagon = new RegularPolygon(pentagon);
        pentagon.resize(10);
        System.out.println("Nach Vergrößerung: " + pentagon + " mit Fläche " + pentagon.area() + " LE^2.");
        System.out.println("Die Kopie: " + otherpentagon + " mit Fläche " + otherpentagon.area() + " LE^2.");
        /*
         * HINWEIS: Machen Sie sich keine Sorgen um etwaige Abweichungen in den letzten
         * Nachkommastellen bei der Berechnung des Flächeninhalts.
         * Diese werden in den automatisierten Tests herausgerechnet.
         * Die erwartete Ausgabe ist:
         * Der Flächeninhalt des RegularPolygon{N=5, radius=1.0} beträgt
         * 2.377641290737883 LE^2.
         * Nach Vergrößerung: RegularPolygon{N=5, radius=10.0} mit Fläche
         * 237.7641290737884 LE^2.
         * Die Kopie: RegularPolygon{N=5, radius=1.0} mit Fläche 2.377641290737883 LE^2.
         */
    }
}
