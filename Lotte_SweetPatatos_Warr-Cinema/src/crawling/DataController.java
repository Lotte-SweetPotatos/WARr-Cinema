package crawling;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MovieDao;
import dto.MovieDto;

@WebServlet("")
public class DataController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		MovieDao dao = MovieDao.getInstance();
		
		Crawling craw = Crawling.getInstance();
		
		if (dao.findAll().size() == 0) {
			
			List<MovieDto> movies = craw.findMovieInfo();
			
			dao.create(movies);
		}
		
		resp.sendRedirect("movie/main.jsp");
	}
}
