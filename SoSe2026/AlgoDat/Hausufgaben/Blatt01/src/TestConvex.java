public class TestConvex {
    public static void main(String[] args) {
        Polygon[] polygons = ConvexPolygon.somePolygons();
        
        System.out.println("=== somePolygons() Array ===");
        for (int i = 0; i < polygons.length; i++) {
            System.out.println((i+1) + ". " + polygons[i]);
            System.out.println("   Area: " + polygons[i].area() + " LE^2");
        }
        
        System.out.println("\n=== totalArea() ===");
        double total = ConvexPolygon.totalArea(polygons);
        System.out.println("Total area: " + total + " LE^2");
    }
}
