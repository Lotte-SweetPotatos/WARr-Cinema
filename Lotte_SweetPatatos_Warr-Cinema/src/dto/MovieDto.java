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

	public MovieDto(String title, String content, double grade, String genre, String director, int runningTime,
			String openingDate, String poster, double percent) {
		this.title = title;
		this.content = content;
		this.grade = grade;
		this.genre = genre;
		this.director = director;
		this.runningTime = runningTime;
		this.openingDate = openingDate;
		this.poster = poster;
		this.percent = percent;
	}

	public MovieDto(long id, String title, String content, double grade, String genre, String director, int runningTime,
			String openingDate, String poster, double percent) {

		this.id = id;
		this.title = title;
		this.content = content;
		this.grade = grade;
		this.genre = genre;
		this.director = director;
		this.runningTime = runningTime;
		this.openingDate = openingDate;
		this.poster = poster;
		this.percent = percent;
	}

	public MovieDto(Long id, String title, int runningTime, double grade, String poster, String openingDate) {
		this.id= id;
		this.title = title;
		this.runningTime = runningTime;
		this.grade = grade;
		this.poster = poster;
		this.openingDate = openingDate;
	}

	public long getId() {
		return id;
	}

	public String getTitle() {
		return title;
	}

	public String getContent() {
		return content;
	}

	public double getGrade() {
		return grade;
	}

	public String getGenre() {
		return genre;
	}

	public String getDirector() {
		return director;
	}

	public int getRunningTime() {
		return runningTime;
	}

	public String getOpeningDate() {
		return openingDate;
	}

	public String getPoster() {
		return poster;
	}

	public double getPercent() {
		return percent;
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