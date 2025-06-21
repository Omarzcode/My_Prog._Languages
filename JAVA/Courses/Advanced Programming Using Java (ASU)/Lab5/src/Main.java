public class Main {
    public static void main(String[] args) {
        Canvas c = new Canvas();
        Shape[] shapes = {
                new Line(new Point2D(0, 0), new Point2D(5, 5)),
                new Line(new Point2D(-2, -2), new Point2D(5, 5)),
                new Line(new Point2D(-2, 0), new Point2D(0, 2)),
                new Rectangle(new Point2D(0, 0), 5, 5),
                new Rectangle(new Point2D(1, 1), 3, 2.5),
                new Rectangle(new Point2D(-1, 3), 2, 2),
                new Ellipse(new Point2D(0, 0), 5, 3.5),
                new Ellipse(new Point2D(2, 3), 3, 7),
                new Ellipse(new Point2D(10, 10), 3, 3.5)
        };
        for(Shape s: shapes){
            c.addShape(s);
        }
        // Will not remove, same values but different address.
        System.out.println(c.removeShape(new Line(new Point2D(0, 0), new Point2D(5, 5))));
        // Will remove, same address.
        System.out.println(c.removeShape(shapes[0]));
        c.getShape(new Point2D(2.5, 2.5)).draw();
        c.drawAll();
    }
}
