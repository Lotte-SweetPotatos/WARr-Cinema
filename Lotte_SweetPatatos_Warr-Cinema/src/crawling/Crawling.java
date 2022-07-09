package crawling;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import db.DBClose;
import db.DBConnection;
import dto.MovieDto;

public class Crawling {
	private static Crawling craw = new Crawling();
	private Crawling() {}
	public static Crawling getInstance() {
		return craw;
	}
	public List<MovieDto> test() throws IOException {
		String[] moviesNum = { "85999", "82120", "85871", "85997", "85857" };

		List<MovieDto> list = new ArrayList<>();

		for (String midx : moviesNum) {
			Document doc = Jsoup.connect("http://www.cgv.co.kr/movies/detail-view/?midx=" + midx).get();

			// 영화제목
			Elements titles = doc.select("div.box-contents div.title strong");
			System.out.println("영화제목: " + titles.text());
			String title = titles.text();

			// 줄거리
			Elements contents = doc.select("div.sect-story-movie");
			System.out.println("영화줄거리: " + contents.text());
			String content = contents.text();

			// 평점
			Elements grades = doc.select("div.score div.egg-gage span.percent");
			String s = grades.text();
			double grade = Double.parseDouble(s.substring(0, s.length() - 1));
			System.out.println("평점: " + grade);

			// 장르
			Elements genres = doc.select("div.box-contents div.spec dl dt");
			System.out.println("장르: " + genres.get(2).text().substring(5));
			String genre = genres.get(2).text().substring(5);

			// 감독
			Elements directors = doc.select("div.box-contents div.spec dl dd a");
			System.out.println("감독: " + directors.get(0).text());
			String director = directors.get(0).text();

			// 러닝타임
			Elements runnings = doc.select("div.box-contents div.spec dl dd");
			s = runnings.get(4).text().split(",")[1];
			int running = Integer.parseInt(s.substring(1, s.length() - 1));
			System.out.println("러닝타임: " + running);

			// 개봉일
			Elements openings = doc.select("div.box-contents div.spec dl dd");
			System.out.println("개봉일: " + openings.get(5).text());
			String opening = openings.get(5).text();

			// 포스터
			Elements imgs = doc.select("div.box-image a span.thumb-image img");
			System.out.println("포스터: " + imgs.get(0).attr("src"));
			String img = imgs.get(0).attr("src");

			// 예매율
			Elements percents = doc.select("div.score strong.percent span");
			s = percents.text();
			double percent = Double.parseDouble(s.substring(0, s.length() - 1));
			System.out.println("예매율: " + percent);

			System.out.println();

			list.add(new MovieDto(title, content, grade, genre, director, running, opening, img, percent));
		}

		return list;
	}

}