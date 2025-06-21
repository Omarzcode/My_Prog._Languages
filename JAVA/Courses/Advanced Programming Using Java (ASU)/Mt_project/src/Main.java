
public class Main {
    public static void main(String[] args) {
        Vector vector1 = new Vector();
        Vector vector2 = new Vector();
        Vector vector3 = new Vector();
        vector1.setX(10);
        vector1.setY(20);
        System.out.println(vector1.magnitude());
        vector1.print();
        vector2.setX(3);
        vector2.setY(4);
        vector2.print();
        System.out.println(vector2.magnitude());
        vector3.setX(9);
        vector3.setY(12);
        vector3.print();
        System.out.println(vector3.magnitude());
        Vector [] vectors = {vector1,vector2,vector3};
        Vector sum = vector1.add(vector2);
        sum.print();
        avg(vectors);
    }
    public static void avg(Vector[] arr)
    {
        double sum=0;
        for(Vector p : arr)
        {
            sum+=p.magnitude();
        }
        System.out.println(sum/arr.length);

    }


}
