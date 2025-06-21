public abstract class Shape {
    private Point2D start;

    public Shape(Point2D start) {
        this.start = start;
    }

    public Point2D getStart() {
        return start;
    }
    abstract public void draw ();

}
