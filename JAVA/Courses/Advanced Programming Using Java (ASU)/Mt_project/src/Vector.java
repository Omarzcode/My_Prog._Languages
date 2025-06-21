public class Vector {
private double m_x;
private double m_y;

    void setX(double x)
    {
       m_x= x;
    }
    void setY(double y)
    {
    m_y= y;
    }
    double getX()
    {
        return m_x;
    }
    double getY()
    {
        return m_y;
    }
    double magnitude()
    {
        return Math.sqrt(Math.pow(m_x,2)+Math.pow(m_y,2));
    }
    double angel()
    {
        return Math.atan(m_y/m_x);
    }
void print()
{
    System.out.println("vector is :("+m_x+"i + "+m_y+"j)");
    System.out.println("vector is :("+magnitude()+"["+angel()+"])");
}
 Vector add(Vector v)
 {
     Vector sum = new Vector();
     sum.m_x=m_x+ v.m_x;
     sum.m_y=m_y+ v.m_y;
     return sum;
 }
    Vector sub(Vector v)
    {
        Vector sum = new Vector();
        sum.m_x=m_x+ v.m_x;
        sum.m_y=m_y+ v.m_y;
        return sum;
    }

}
