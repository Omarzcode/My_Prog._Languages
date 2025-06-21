import java.time.LocalDate;

class ScienceBook extends TextBook {
    private String field;
    private String difficultyLevel;
    public ScienceBook(String title, LocalDate releaseDate, double price, int
            numberOfPages, String field, String difficultyLevel) {
        super(title, releaseDate, price, numberOfPages);
        this.field = field;
        this.difficultyLevel = difficultyLevel;
    }
    public String getField() {
        return field;
    }
    @Override
    public void displayInfo() {
        System.out.println(toString() + ", Field: " + field + ", Difficulty Level: " +
                difficultyLevel);
    }
}