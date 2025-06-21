import java.time.LocalDate;
class Book {
    private static int idCounter = 1;
    protected int id;
    protected String title;
    protected LocalDate releaseDate;
    protected double price;
    public Book(String title, LocalDate releaseDate, double price) {
        this.id = idCounter++;
        this.title = title;
        this.releaseDate = releaseDate;
        this.price = price;
    }

    public String toString() {
        return "Book ID: " + id + ", Title: " + title + ", Release Date: " + releaseDate + ", Price: $" + price;

    }
    public void displayInfo() {
        System.out.println(toString());
    }
}
