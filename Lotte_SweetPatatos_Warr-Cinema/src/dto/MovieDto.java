package dto;

public class MovieDto {

    private Long id;
    private String title;
    private String content;
    private Double grade;
    private String genre;
    private String director;
    private Integer runningTime;
    private String openingDate;
    private String poster;
    private Double percent;

    public MovieDto(String title, Double grade, String poster) {
        this.title = title;
        this.grade = grade;
        this.poster = poster;
    }

    @Override
    public String toString() {
        return "MovieDto{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", grade=" + grade +
                ", genre='" + genre + '\'' +
                ", director='" + director + '\'' +
                ", runningTime=" + runningTime +
                ", openingDate='" + openingDate + '\'' +
                ", poster='" + poster + '\'' +
                ", percent=" + percent +
                '}';
    }
}
