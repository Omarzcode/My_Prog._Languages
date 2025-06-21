public class Main {

    public static void main(String[] args)
    {
        MyStringBuffer msb1 = new MyStringBuffer("12345");
        MyStringBuffer msb2 = new MyStringBuffer("abcd");
        MyStringBuffer msb3 = new MyStringBuffer("24680");

        System.out.println( "String length = " + msb1.length());

        System.out.println("index of '3' in the string is " + msb1.indexOf('3'));

        msb1.erase(1, 3);
        msb1.print();
        msb1.insert(1, "234");
        msb1.print();

        msb2.erase(0, 100);
        msb2.print();
        msb2.insert(0, "abcd");
        msb2.print();

        msb3.insert(100, "xyz");
        msb3.print();
    }
}