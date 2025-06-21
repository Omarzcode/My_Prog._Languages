import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        TextBook textBook = new TextBook("Java Programming", LocalDate.of(2021, 5, 10), 45.99, 500);
        AudioBook audioBook = new AudioBook("Learn Python Fast", LocalDate.of(2022, 7, 20), 15.99, 120);
        FictionBook fictionBook = new FictionBook("Harry Potter", LocalDate.of(1997, 6, 26), 39.99, 400,
                "Fantasy", "J.K. Rowling");
        ScienceBook scienceBook = new ScienceBook("Physics for Beginners", LocalDate.of(2020, 9, 15), 29.99,
                350, "Physics", "Advanced");
        Podcast podcast = new Podcast("Tech Talk", LocalDate.of(2023, 3, 25), 5.99, 45, "John Doe", 10);
        Book[] books = {textBook, audioBook, fictionBook, scienceBook, podcast};
        for (Book book1 : books) {
            book1.displayInfo();

        }
        for (Book book1 : books) {
            if (book1 instanceof Podcast) {

                ((Podcast) book1).displayInfo();
            } else if (book1 instanceof TextBook) {

                System.out.println(((TextBook) book1).getPageCount());
            }


        }
    }

}
