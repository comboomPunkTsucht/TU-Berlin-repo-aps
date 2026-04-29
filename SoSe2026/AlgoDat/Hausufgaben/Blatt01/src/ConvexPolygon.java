
public class ConvexPolygon extends Polygon {

    public ConvexPolygon(Vector2D[] vertices) {
        // Store references to the vectors (not copies)
        this.vertices = new Vector2D[vertices.length];
        for (int i = 0; i < vertices.length; i++) {
            this.vertices[i] = vertices[i];
        }
    }

    @Override
    public double perimeter() {
        double perimeter = 0;
        int n = vertices.length;
        for (int i = 0; i < n; i++) {
            Vector2D v1 = vertices[i];
            Vector2D v2 = vertices[(i + 1) % n];
            double dx = v2.getX() - v1.getX();
            double dy = v2.getY() - v1.getY();
            Vector2D side = new Vector2D(dx, dy);
            perimeter += side.length();
        }
        return perimeter;
    }

    @Override
    public double area() {
        double totalArea = 0;
        int n = vertices.length;

        // Triangulation: fix vertices[0] as anchor, create triangles with adjacent vertices
        for (int i = 1; i < n - 1; i++) {
            Triangle triangle = new Triangle(vertices[0], vertices[i], vertices[i + 1]);
            totalArea += triangle.area();
        }

        return totalArea;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("ConvexPolygon([");
        for (int i = 0; i < vertices.length; i++) {
            sb.append(vertices[i].toString());
            if (i < vertices.length - 1) {
                sb.append(", ");
            }
        }
        sb.append("])");
        return sb.toString();
    }

    public static double totalArea(Polygon[] polygons) {
        double sum = 0;
        for (Polygon polygon : polygons) {
            sum += polygon.area();
        }
        return sum;
    }

    public static Polygon[] somePolygons() {
        Polygon[] polygons = new Polygon[4];

        // 1. Triangle with (0,0), (10,0), (5,5)
        polygons[0] = new Triangle(
            new Vector2D(0, 0),
            new Vector2D(10, 0),
            new Vector2D(5, 5)
        );

        // 2. Tetragon with (0,0), (10,-5), (12,2), (3,17)
        polygons[1] = new Tetragon(
            new Vector2D(0, 0),
            new Vector2D(10, -5),
            new Vector2D(12, 2),
            new Vector2D(3, 17)
        );

        // 3. Regular Pentagon with radius 1
        polygons[2] = new RegularPolygon(5, 1);

        // 4. Regular Hexagon with radius 1
        polygons[3] = new RegularPolygon(6, 1);

        return polygons;
    }
}
