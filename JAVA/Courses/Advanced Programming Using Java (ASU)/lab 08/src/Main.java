public class Main {
    public static void main(String[] args) {
        BankAccount acc1 = new BankAccount("001", "Alice", 500f);
        BankAccount acc2 = new BankAccount("002", "Bob", 0f);
        System.out.println("=== Initial Accounts ===");
        acc1.print();
        acc2.print();
        // deposit
        System.out.println("Depositing 200 to acc1...");
        acc1.deposit(200f);
        acc1.print();
        // deposit
        System.out.println("Trying to deposit -50 to acc1...");
        acc1.deposit(-50f);
        // withdrawal
        System.out.println("Withdrawing 100 from acc1...");
        acc1.withdraw(100f);
        acc1.print();
        // withdrawal
        System.out.println("Trying to withdraw 10000 from acc1...");
        acc1.withdraw(10000f);
        // withdrawal
        System.out.println("Trying to withdraw -10 from acc1...");
        acc1.withdraw(-10f);
        // close
        System.out.println("Trying to close acc1...");
        acc1.close();
        // Withdraw
        float remaining = acc1.getBalance();
        acc1.withdraw(remaining);
        acc1.print();
        // close
        System.out.println("Closing acc1...");
        acc1.close();
        acc1.print();
        // Deposit to closed account
        System.out.println("Trying to deposit to closed acc1...");
        acc1.deposit(100f);
        // Reopen account
        System.out.println("Reopening acc1...");
        acc1.reopen();
        acc1.print();
        // Final state
        System.out.println("=== Final Account States ===");
        acc1.print();
        acc2.print();
    }
}
