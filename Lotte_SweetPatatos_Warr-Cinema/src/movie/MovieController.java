package movie;

import dao.MemberDao;
import dao.MovieDao;
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
    private final MovieDao movieDao = MovieDao.getInstance();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        final Optional<String> param = Optional.ofNullable(req.getParameter("param"));

        if (param.isEmpty()) {
            resp.sendRedirect("main.jsp");
            return ;
        }

        if ("main".equals(param.get())) {
            List<MovieDto> allMovie = movieDao.findAllMainMovies();
            for (MovieDto movieDto : allMovie) {
                System.out.println(movieDto.toString());
            }
            req.setAttribute("allMovieList", allMovie);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }


}
