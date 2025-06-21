final class Line extends Shape{
    private Point2D end;
    public Line (Point2D start,Point2D end)
    {
        super(start);
        this.end=end;
    }
    @Override
    public void draw() {
        System.out.println("Drawing Line");
        System.out.println("Start " + this.getStart());
        System.out.println("End " + this.end);

    }
}
