public class BankAccount {
    private String AccountNumber;
    private String Name;
    private Float Balance;
    private Boolean IsActive;
    public BankAccount(String AccountNumber, String Name, Float Balance) {
        this.AccountNumber = AccountNumber;
        this.Name = Name;
        this.Balance = Balance;
        IsActive = true;
    }
    public void print() {
        System.out.println("Account Number: " + AccountNumber);
        System.out.println("Name: " + Name);
        System.out.println("Balance: " + Balance);
        System.out.println("Is Active: " + IsActive);
    }

    public Float getBalance() {
        return Balance;
    }

    public void close() {
        try {
            if (getBalance() != 0) {
                throw new IllegalStateException("You can't close an account with a non-zero balance.");
            }
            if (!IsActive) {
                throw new IllegalStateException("Account is already closed.");
            }
            IsActive = false;
        } catch (IllegalStateException e) {
            System.out.println("Error in closing account: " + e.getMessage());
        }
    }

    public void reopen() {
        try {
            if (IsActive) {
                throw new IllegalStateException("Account is already open.");
            }
            IsActive = true;
        } catch (IllegalStateException e) {
            System.out.println("Error in reopening account: " + e.getMessage());
        }
    }

    public void deposit(Float amount) {
        try {
            if (amount <= 0) {
                throw new IllegalArgumentException("Amount must be positive.");
            }
            if (!IsActive) {
                throw new IllegalStateException("Account is closed.");
            }
            Balance += amount;
        } catch (IllegalArgumentException | IllegalStateException e) {
            System.out.println("Error in deposit: " + e.getMessage());
        }
    }

    public void withdraw(Float amount) {
        try {
            if (amount <= 0) {
                throw new IllegalArgumentException("Amount must be positive.");
            }
            if (!IsActive) {
                throw new IllegalStateException("Account is closed.");
            }
            if (amount > Balance) {
                throw new IllegalStateException("Insufficient funds.");
            }
            Balance -= amount;
        } catch (IllegalArgumentException | IllegalStateException e) {
            System.out.println("Error in withdrawal: " + e.getMessage());
        }
    }

}
