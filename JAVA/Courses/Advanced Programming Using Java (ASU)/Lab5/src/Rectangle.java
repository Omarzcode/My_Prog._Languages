final class Rectangle extends Shape{
    private final double length;
    private double width;
    public Rectangle(Point2D start,double length ,double width)
    {
        super(start);
        this.length=length;
        this.width=width;
    }
    @Override
    public void draw() {
        System.out.println("Drawing Rectangle");
        System.out.println("Start " + this.getStart());
        System.out.println("Length = " + this.length);
        System.out.println("Width = " + this.width);
    }
}
