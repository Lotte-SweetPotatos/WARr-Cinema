package movie;

import dao.MovieDao;
import dto.MemberDto;
import dto.MovieDto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/movie")
public class MovieController extends HttpServlet {

	final private MovieDao movieDao = MovieDao.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		final Optional<String> queryParam = Optional.ofNullable(req.getParameter("param"));
		if (isPresentParameter(queryParam)) {
			resp.sendRedirect("movie/main.jsp");
			return;
		}

		final String param = queryParam.get();

		if ("detail".equals(param)) {
			if (!loginValidation(req)) {
				resp.sendRedirect("member/login.jsp");
				return;
			}

			final Optional<Long> movieId = Optional.ofNullable(Long.parseLong(req.getParameter("movieId")));

			if (movieId.isEmpty()) {

				resp.sendRedirect("movie/main.jsp");
				return;
			}

			MovieDto movieDto = movieDao.find(movieId.get());

			resp.setContentType("application/x-json; charset=utf-8");
			req.setAttribute("movie", movieDto);
			req.getRequestDispatcher("movie/detail.jsp").forward(req, resp);
			
			return;
		}

		if ("main".equals(param)) {
			List<MovieDto> allMovie = movieDao.findAllMainMovies();
			for (MovieDto movieDto : allMovie) {
				System.out.println(movieDto.toString());
			}
			req.setAttribute("allMovieList", allMovie);
			req.getRequestDispatcher("movie/main.jsp").forward(req, resp);
			return;
		}
		if ("ticket".equals(param)) {
			resp.sendRedirect("movie/ticket.jsp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

	private boolean loginValidation(HttpServletRequest req) {
		final Optional<MemberDto> member = Optional.ofNullable((MemberDto) (req.getSession().getAttribute("member")));

		if (member.isEmpty()) {
			return false;
		}

		return true;
	}

	private boolean isPresentParameter(Optional<String> queryParam) {
		return queryParam.isEmpty() || "".equals(queryParam.get());
	}
}