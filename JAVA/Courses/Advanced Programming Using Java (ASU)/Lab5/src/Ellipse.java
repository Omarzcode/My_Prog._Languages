final class Ellipse extends Shape{
    private double length;
    private double width;
    public Ellipse(Point2D start, double length , double width)
    {
        super(start);
        this.length=length;
        this.width=width;
    }
    @Override
    public void draw() {
        System.out.println("Drawing Ellipse");
        System.out.println("Start " + this.getStart());
        System.out.println("Length = " + this.length);
        System.out.println("width = " + this.width);
    }
}
