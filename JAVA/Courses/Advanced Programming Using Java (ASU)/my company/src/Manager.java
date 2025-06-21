public class Manager extends  Employee{
    String department;
    double extraBonus;
    public Manager (String name,int age,String employeeId,double salary, String department,double  extraBonus)
    {
        super(name, age,employeeId,salary);
        this.department=employeeId;
        this.extraBonus=extraBonus;
    }
    @Override
    double calculateBonus()
    {
        double bonus= (salary * 0.20) + (age * 50) + extraBonus;
        return bonus;
    }
    @Override
    void displayInfo() {
        System.out.println("=================================");
        System.out.println("         Manager Info.         ");
        System.out.println("=================================");
        System.out.printf("Name         : %s%n", name);
        System.out.printf("Age          : %d%n", age);
        System.out.printf("Employee ID  : %s%n", employeeId);
        System.out.printf("Salary       : %.2f%n", salary);
        System.out.printf("Department   : %s%n", department);
        System.out.printf("Bonus        : %.2f%n", calculateBonus());
        System.out.println("=================================");
        System.out.println("                *                ");

    }

}
