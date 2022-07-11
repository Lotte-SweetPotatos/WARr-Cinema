package movie;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MovieDao;
import dto.MemberDto;

@WebServlet("/movie")
public class MovieController extends HttpServlet {
	
	private MovieDao movieDao = MovieDao.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		final Optional<String> queryParam = Optional.ofNullable(req.getParameter("param"));
		
		if (queryParam.isEmpty()) {
			resp.sendRedirect("movie/main.jsp");
			return;
		}
		
		final String param = queryParam.get();
		
		if ("detail".equals(param)) {
			if(!loginValidation(req)) {
				resp.sendRedirect("member/login.jsp");
				return;
			}
			
			final Optional<Long> movieId =  Optional.ofNullable(Long.parseLong(req.getParameter("id")));
			
			if(movieId.isEmpty()) {
				resp.sendRedirect("movie/main.jsp");
				return;
			}
			
			resp.sendRedirect(req.getContextPath()+"/movie/detail.jsp?id=" + movieId.get().longValue());
			
			return;
		}
		// 아래 메인과 예약 등등 기능을 작성해주시면 됩니다.
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	}
	
	private boolean loginValidation(HttpServletRequest req) {
		final Optional<MemberDto> member = Optional.ofNullable((MemberDto)(req.getSession().getAttribute("member")));
		
		if(member.isEmpty()) {
			return false;
		}
		
		return true;
	}
}
