import java.util.ArrayList;

public class Canvas {
    ArrayList<Shape> shapes= new ArrayList<>();

    public void addShape(Shape shape) {
        shapes.add(shape);
    }
    public boolean removeShape(Shape shape)
    {
        return shapes.remove(shape);
    }
    public Shape getShape(Point2D ref) {
       Shape closest = shapes.get(0);
       double mindistance = ref.distance(closest.getStart());
       for (Shape s :shapes)
       {
           double dis=ref.distance(s.getStart());
           if(dis<mindistance) {
               mindistance = dis;
                closest=s;
           }
       }
       return closest;
    }

    public void drawAll() {
        for (Shape s :shapes)
        {
            s.draw();
        }
    }
}
