package movie;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TicketDao;
import dto.MovieDto;
import dto.RunningDto;
import net.sf.json.JSONObject;

@WebServlet("/movie")
public class MovieContorller extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		final Optional<String> param = Optional.ofNullable(req.getParameter("param"));
		if (param.isEmpty()) {
			resp.sendRedirect("index");
		}
		
		 TicketDao dao=TicketDao.getInstance();

			/*
			 * if("ticket".equals(param.get())) { resp.sendRedirect("movie/ticket.jsp");
			 * 
			 * }
			 * 
			 * else
			 */
		 if("ticket".equals(param.get())) {
				 
	         List<MovieDto> list= dao.findMovies();
	         req.setAttribute("movieList",list);
	         
	         forward("movie/ticket.jsp",req,resp);
	         
	     }
		 else  if("findTimeTable".equals(param.get())) {
	         int movieId=Integer.parseInt(req.getParameter("movieId"));
	         String runningDate=req.getParameter("runningDate");
	         
	         List<RunningDto> list=dao.findByMovieIdAndRunningDate(movieId,runningDate);
	         
	         JSONObject obj = new JSONObject();
	         obj.put("timeList", list); 
	         
	         resp.setContentType("application/x-json; charset=utf-8");
	         resp.getWriter().print(obj);
	      }

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 String param=req.getParameter("param");
	      System.out.println(param);
	      
	      TicketDao dao=TicketDao.getInstance();
	      
	      if("reserveTicket".equals(param)){
	    	  
	    	  System.out.println("reserveTicket");
	         
			 int memberId=Integer.parseInt(req.getParameter("memberId")); 
	         int runningId=Integer.parseInt(req.getParameter("selRunningId"));
	         int movieId=Integer.parseInt(req.getParameter("selMovieId"));
	         
	         System.out.println(memberId+" "+runningId+" "+movieId);
	         
	         
	         reserveTicket(memberId,runningId,movieId);
	         
	         // TODO: 예매 후 마이페이지 이동
	      }
	
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


}
