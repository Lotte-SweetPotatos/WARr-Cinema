package crawling;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MovieDetailDao;
import dto.MovieDto;

@WebServlet("/")
public class DataController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MovieDetailDao dao = MovieDetailDao.getInstance();
		Crawling craw = Crawling.getInstance();
		List<MovieDto> movies = craw.test();
		if (dao.findAll().size() == 0) {
			dao.insertData(movies);
		}
	}
}
