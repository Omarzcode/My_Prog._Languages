import java.time.LocalDate;

class Podcast extends AudioBook {
    private String host;
    private int episodeNumber;
    public Podcast(String title, LocalDate releaseDate, double price, double
            lengthInMinutes, String host, int episodeNumber) {
        super(title, releaseDate, price, lengthInMinutes);
        this.host = host;
        this.episodeNumber = episodeNumber;
    }
    public String getHost() {
        return host;
    }
    @Override
    public void displayInfo() {
        System.out.println(toString() + ", Host: " + host + ", Episode: " + episodeNumber);
    }
}