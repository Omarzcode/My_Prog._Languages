import java.time.LocalDate;

class TextBook extends Book {
    protected int numberOfPages;
    public TextBook(String title, LocalDate releaseDate, double price, int
            numberOfPages) {
        super(title, releaseDate, price);
        this.numberOfPages = numberOfPages;
    }
    @Override
    public String toString() {
        return super.toString() + ", Pages: " + numberOfPages;
    }
    public int getPageCount() {
        return numberOfPages;
    }
}