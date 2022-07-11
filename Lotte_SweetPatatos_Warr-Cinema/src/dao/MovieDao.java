package dao;

import db.DBConnection;
import dto.MovieDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * title varchar(100) not null,
 * content varchar(4000) not null,
 * grade decimal(8,2) not null,
 * genre varchar(100) not null,
 * director varchar(100) not null,
 * runningTime int not null,
 * openingDate varchar(100) not null,
 * poster varchar(1000) not null,
 * percent decimal(8,2) not null
 */
public class MovieDao {

    private static final MovieDao movieDao = new MovieDao();

    public MovieDao() {
        DBConnection.initConnection();
    }

    public static MovieDao getInstance() {
        return movieDao;
    }


    public List<MovieDto> findAllMovie() {
        String sql = "select title, grade, poster from movie";

        List<MovieDto> movieDtoList = new ArrayList<>();
        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String title = rs.getString(1);
                double grade = rs.getDouble(2);
                String post = rs.getString(3);
                movieDtoList.add(new MovieDto(title, grade, post));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movieDtoList;
    }
}


