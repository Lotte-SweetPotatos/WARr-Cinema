package movie;

import dao.MovieDao;
import dto.MovieDto;

import java.util.List;

public class testMain {
    public static void main(String[] args) {
        MovieDao instance = MovieDao.getInstance();
        List<MovieDto> allMovie = instance.findAllMainMovies();
        for (MovieDto movieDto : allMovie) {
            System.out.println(movieDto.toString());
        }
    }
}
