package movie;

import dao.MovieDao;
import dao.TicketDao;
import dto.MemberDto;
import dto.MovieDto;
import dto.RunningDto;
import org.json.JSONObject;

import javax.servlet.RequestDispatcher;
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

	private final MovieDao movieDao = MovieDao.getInstance();
	private final TicketDao ticketDao = TicketDao.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		final Optional<String> queryParam = Optional.ofNullable(req.getParameter("param"));
		if (isPresentParameter(queryParam)) {
			resp.sendRedirect("movie/main.jsp");
			return;
		}

		final String param = queryParam.get();

		if ("ticket".equals(param)) {
			String movieId = req.getParameter("movieId");

			List<MovieDto> list = ticketDao.findMovies();
			req.setAttribute("movieList", list);

			if (movieId != null && !movieId.equals("")) { // movie 선택 안하는 경우
				req.setAttribute("movieId", movieId);
			} else {
				req.setAttribute("movieId", "-1");
			}
			forward("movie/ticket.jsp", req, resp);
			return;
		}

		if ("findTimeTable".equals(param)) {
			int movieId = Integer.parseInt(req.getParameter("movieId"));
			String runningDate = req.getParameter("runningDate");

			List<RunningDto> list = ticketDao.findByMovieIdAndRunningDate(movieId, runningDate);
			JSONObject obj = new JSONObject();
			obj.put("timeList", list);

			resp.setContentType("application/x-json; charset=utf-8");
			resp.getWriter().print(obj);
			return;
		}

		if ("reserveTicket".equals(param)) {
			int memberId = Integer.parseInt(req.getParameter("memberId"));
			int runningId = Integer.parseInt(req.getParameter("selRunningId"));
			int movieId = Integer.parseInt(req.getParameter("selMovieId"));

			reserveTicket(memberId, runningId, movieId);

			resp.sendRedirect("member?param=mypage&memberId="+memberId);
			return;
		}

		if ("detail".equals(param)) {
			Optional<String> movieId = Optional.ofNullable(req.getParameter("movieId"));
			if (movieId.isEmpty()) {
				resp.sendRedirect("movie/main.jsp");
				return;
			}

			MovieDto movieDto = movieDao.find(Long.parseLong(movieId.get()));
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
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

	public void reserveTicket(int userId, int runningId, int movieId) {
		TicketDao dao = TicketDao.getInstance();
		dao.saveReserve(userId, runningId, movieId);

		int curSeat = dao.findCurSeat(runningId);
		dao.updateCurSeat(runningId, curSeat);
	}

	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(arg);
		dispatch.forward(req, resp);
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
