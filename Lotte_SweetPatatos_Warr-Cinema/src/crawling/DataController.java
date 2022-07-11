package crawling;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MovieDao;
import dao.RunningDao;
import dto.MovieDto;
import dto.RunningDto;

@WebServlet("")
public class DataController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		MovieDao dao = MovieDao.getInstance();
		RunningDao rDao = RunningDao.getInstance();

		Crawling craw = Crawling.getInstance();

		if (dao.findAll().size() == 0) {

			List<MovieDto> movies = craw.findMovieInfo();

			dao.create(movies);

			// data insert
			List<MovieDto> movieIds = dao.findIdAndRunningTime();
			String[][] startTime = {
					{"10:10","12:40","15:10","17:40","20:10"},
					{"10:20","13:00","15:40","18:20","21:00"},
					{ "9:40", "11:20", "15:25", "18:20", "21:00" },
					{"9:00","11:50","14:40","17:30","20:20"},
			        {"10:00","12:45","15:00","18:20","20:00"}
			};
			String[] runningDate = { "2022.07.10", "2022.07.11", "2022.07.12", "2022.07.13", "2022.07.14", "2022.07.15",
					"2022.07.16" };

			for (int i = 0; i < movieIds.size(); ++i) { // movie
				for (int j = 0; j < runningDate.length; ++j) { // runningDate
					for (int z = 0; z < startTime.length; ++z) { //startTime
						MovieDto dto = movieIds.get(i);
						RunningDto rDto = new RunningDto(dto.getId(), startTime[i][z],
								getEndTime(startTime[i][z], dto.getRunningTime()), dto.getRunningTime(), runningDate[j],
								(i + 1)+"", 300, 300);

						rDao.save(rDto);
					}
				}

			}
		}

		resp.sendRedirect("movie/main.jsp");
	}

	public String getEndTime(String startTime, int runningTime) {
		long start = strToMin(startTime);
		long endTime = start + runningTime;
		return minToStr(endTime);
	}

	public long strToMin(String s) {
		String[] arr = s.split(":");
		return Integer.parseInt(arr[0]) * 60 + Integer.parseInt(arr[1]);
	}

	public String minToStr(long time) {
		return String.format("%02d:%02d", time / 60, time % 60);
	}
}
