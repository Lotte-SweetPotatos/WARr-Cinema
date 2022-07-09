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

	public void setId(long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public double getGrade() {
		return grade;
	}

	public void setGrade(double grade) {
		this.grade = grade;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public int getRunningTime() {
		return runningTime;
	}

	public void setRunningTime(int runningTime) {
		this.runningTime = runningTime;
	}

	public String getOpeningDate() {
		return openingDate;
	}

	public void setOpeningDate(String openingDate) {
		this.openingDate = openingDate;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public double getPercent() {
		return percent;
	}

	public void setPercent(double percent) {
		this.percent = percent;
	}

	@Override
	public String toString() {
		return "MovieDto{" + "id=" + id + ", title='" + title + '\'' + ", content='" + content + '\'' + ", grade="
				+ grade + ", genre='" + genre + '\'' + ", director='" + director + '\'' + ", runningTime=" + runningTime
				+ ", openingDate='" + openingDate + '\'' + ", poster='" + poster + '\'' + ", percent=" + percent + '}';
	}
}