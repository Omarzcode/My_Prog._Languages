public class Point2D {
    private double x, y;
    public Point2D()
    {
        x = 0;
        y = 0;
    }

    public Point2D(double x, double y)
    {
        this.x = x;
        this.y = y;
    }
    double getX()
    {
        return x;
    }

    double getY()
    {
        return y;
    }

    void setX(double x)
    {
        this.x = x;
    }

    void setY(double y)
    {
        this.y = y;
    }
}
