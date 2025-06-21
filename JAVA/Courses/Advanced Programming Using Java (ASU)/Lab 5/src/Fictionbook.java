import java.time.LocalDate;

class FictionBook extends TextBook {
    private String genre;
    private String author;
    public FictionBook(String title, LocalDate releaseDate, double price, int
            numberOfPages, String genre, String author) {
        super(title, releaseDate, price, numberOfPages);
        this.genre = genre;
        this.author = author;
    }
    public String getGenre() {
        return genre;
    }
    @Override
    public void displayInfo() {
        System.out.println(toString() + ", Genre: " + genre + ", Author: " + author);
    }
}
