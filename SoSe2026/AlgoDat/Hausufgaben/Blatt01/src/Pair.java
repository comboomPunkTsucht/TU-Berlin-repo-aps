import java.util.Objects;

public class Pair<T> {
// TODO
private T l, r;

  public Pair(T l, T r) {
    this.l = l;
    this.r = r;
  }

  // Copy constructor
  public Pair(Pair<T> template) {
    this.l = template.l;
    this.r = template.r;
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj) return true;
    if (obj == null || getClass() != obj.getClass()) return false;
    Pair<?> p2 = (Pair<?>) obj;
    return (Objects.equals(this.l, p2.l) && Objects.equals(this.r, p2.r)) || 
           (Objects.equals(this.r, p2.l) && Objects.equals(this.l, p2.r));
  }

  public void swap() {
    T temp = this.r;
    this.r = this.l;
    this.l = temp;
  }

  public void setFirst( T l ) {
    this.l = l;
  }

  public T getFirst () {return this.l;}

  public void setSecond( T r ) {
    this.r = r;
  }

  public T getSecond() {return this.r;}
  
  
    public static void main(String[] args) {
        Pair<Integer> pair1 = new Pair<>(1, 2);
        Pair<Integer> pair2 = new Pair<>(1, 2);
        System.out.println("Variable pair1 hat den Wert: " + pair1);
        System.out.println("Variable pair2 hat den Wert: " + pair2);
        System.out.println("Syntaktische Gleichheit von pair1 und pair2 ist: " + (pair1==pair2));
        System.out.println("Semantische Gleichheit von pair1 und pair2 ist: " + pair1.equals(pair2));
        Pair<Integer> pair1b = pair1;
        Pair<Integer> pair2b = new Pair<>(pair2);
        pair1.swap();
        pair2.setFirst(10);
        System.out.println("Nach swap() hat Variable pair1 den Wert: " + pair1);
        System.out.println("Nach setFirst(10) hat Variable pair2 den Wert: " + pair2);
        System.out.println("Die zuvor erstellte Kopie pair1b hat den Wert: " + pair1b);
        System.out.println("Die zuvor erstellte Kopie pair2b hat den Wert: " + pair2b);
        /*
        Die erwartete Ausgabe ist:
        Variable pair1 hat den Wert: Pair<1, 2>
        Variable pair2 hat den Wert: Pair<1, 2>
        Syntaktische Gleichheit von pair1 und pair2 ist: false
        Semantische Gleichheit von pair1 und pair2 ist: true
        Nach swap() hat Variable pair1 den Wert: Pair<2, 1>
        Nach setFirst(10) hat Variable pair2 den Wert: Pair<10, 2>
        Die zuvor erstellte Kopie pair1b hat den Wert: Pair<2, 1>
        Die zuvor erstellte Kopie pair2b hat den Wert: Pair<1, 2>
         */
    }
  @Override
  public String toString() {
    return "Pair<" + this.l + ", " + this.r + ">";
  }
}

