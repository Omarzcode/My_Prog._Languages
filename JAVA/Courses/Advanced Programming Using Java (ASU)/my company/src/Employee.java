public class Employee extends Person{
    String employeeId;
    double salary;
    public Employee (String name,int age,String employeeId,double salary )
    {
        super(name, age);
        this.employeeId=employeeId;
        this.salary=salary;
    }
    double calculateBonus()
    {
        double bonus=0.1*salary;
        return bonus;
    }
@Override
void displayInfo()
{
    System.out.println("=================================");
    System.out.println("        Employee Info.         ");
    System.out.println("=================================");
    System.out.printf("Name         : %s%n", name);
    System.out.printf("Age          : %d%n", age);
    System.out.printf("Employee ID  : %s%n", employeeId);
    System.out.printf("Salary       : %.2f%n", salary);
    System.out.printf("Bonus        : %.2f%n", calculateBonus());
    System.out.println("=================================");
    System.out.println("                *                ");


}

}
