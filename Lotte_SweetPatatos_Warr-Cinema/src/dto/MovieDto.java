package dto;

public class MovieDto {

	private long id;
	private String title;
	private String content;
	private double grade;
	private String genre;
	private String director;
	private int runningTime;
	private String openingDate;
	private String poster;
	private double percent;

	public MovieDto() {
	}

	public MovieDto(long id, String title) {
		this.id = id;
		this.title = title;
	}
	
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
}