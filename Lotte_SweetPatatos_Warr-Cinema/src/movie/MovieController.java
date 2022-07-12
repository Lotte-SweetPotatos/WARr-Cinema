package movie;

import java.io.IOException;

import java.util.List;
import java.util.Optional;
import dao.MemberDao;
import dao.MovieDao;
import dto.MovieDto;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

import dao.TicketDao;
import dto.MovieDto;
import dto.RunningDto;
import net.sf.json.JSONObject;
import dto.MemberDto;

@WebServlet("/movie")
public class MovieController extends HttpServlet {

	private MovieDao movieDao = MovieDao.getInstance();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		final Optional<String> queryParam = Optional.ofNullable(req.getParameter("param"));
		if (isPresentParameter(queryParam)) {
			resp.sendRedirect("movie/main.jsp");
			return;
		}

		final String param = queryParam.get();
		
		 TicketDao dao=TicketDao.getInstance();

		 if("ticket".equals(param)) {
			 
			 String movieId=req.getParameter("movieId");
			 
			 List<MovieDto> list= dao.findMovies();
			 req.setAttribute("movieList",list);
         
			 
			 
			 if(movieId!=null && !movieId.equals("")) { // movie 선택 안하는 경우
				 
				 req.setAttribute("movieId",movieId);
			 }
			 else {
				 req.setAttribute("movieId","-1");
			 }
				 
			 forward("movie/ticket.jsp",req,resp);
	         
	     }
		 else if("findTimeTable".equals(param)) {
			 System.out.println("findTimeTable");
	         int movieId=Integer.parseInt(req.getParameter("movieId"));
	         String runningDate=req.getParameter("runningDate");
	         
	         System.out.println(movieId+" "+runningDate);
	         
	         List<RunningDto> list=dao.findByMovieIdAndRunningDate(movieId,runningDate);
	         System.out.println(list.size());
	         JSONObject obj = new JSONObject();
	         obj.put("timeList", list); 
	         
	         resp.setContentType("application/x-json; charset=utf-8");
	         resp.getWriter().print(obj);
	      }
		 else if("reserveTicket".equals(param)){
	    	  
			 int memberId=Integer.parseInt(req.getParameter("memberId")); 
	         int runningId=Integer.parseInt(req.getParameter("selRunningId"));
	         int movieId=Integer.parseInt(req.getParameter("selMovieId"));
	         
	         reserveTicket(memberId,runningId,movieId);
	         
	         // TODO: 예매 후 마이페이지 이동
	         req.setAttribute("userId",memberId);
	         forward("member/mypage.jsp",req,resp);
	      }
		 else if ("detail".equals(param)) {
			if (!loginValidation(req)) {
				resp.sendRedirect("member/login.jsp");
				return;
			}

			final Optional<Long> movieId = Optional.ofNullable(Long.parseLong(req.getParameter("id")));

			if (movieId.isEmpty()) {
				resp.sendRedirect("movie/main.jsp");
				return;
			}

			resp.sendRedirect(req.getContextPath() + "/movie/detail.jsp?id=" + movieId.get().longValue());
			return;
		}
		else if ("main".equals(param)) {
			List<MovieDto> allMovie = movieDao.findAllMainMovies();
			for (MovieDto movieDto : allMovie) {
				System.out.println(movieDto.toString());
			}
			req.setAttribute("allMovieList", allMovie);
			resp.sendRedirect("movie/main.jsp");
			return;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	public void reserveTicket(int userId, int runningId, int movieId) {
	       TicketDao dao=TicketDao.getInstance();
	       dao.saveReserve(userId,runningId,movieId);
	       
	       int curSeat=dao.findCurSeat(runningId);
	       dao.updateCurSeat(runningId,curSeat);
	}
	       
	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
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
