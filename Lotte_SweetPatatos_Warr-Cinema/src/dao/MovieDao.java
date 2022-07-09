package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.MovieDto;

/*
 	영화 상세 페이지의 dao
 */
public class MovieDao {
	
	private static MovieDao movieDetailDao = new MovieDao();

	public MovieDao() {
		DBConnection.initConnection();
	}

	public static MovieDao getInstance() {
		return movieDetailDao;
	}

	/*
	 * @param id : 영화 id
	 */
	public MovieDto find(long id) {
		
		String sql = " select * " + " from movie " + " where id = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MovieDto movie = null;
		
		try {
			
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setLong(1, id);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				
				int i = 1;
				
				movie = new MovieDto(rs.getLong(i++),
									 rs.getString(i++), 
									 rs.getString(i++), 
									 rs.getDouble(i++), 
									 rs.getString(i++), 
									 rs.getString(i++), 
									 rs.getInt(i++), 
									 rs.getString(i++), 
									 rs.getString(i++), 
									 rs.getDouble(i++));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return movie;
	}
	
	public List<MovieDto> findAll() {
		
		String sql = " select * " + " from movie ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<MovieDto> list = new ArrayList<MovieDto>();
		
		try {
			
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				
				MovieDto dto =new MovieDto();
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
	
	public boolean create(List<MovieDto> dto) {
		
		String sql = "insert into movie(title, content, grade, genre, director, runningTime, openingDate, poster, percent) "
				+ "values(?,?,?,?,?,?,?,?,?) ";

		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;

		try {
			
			conn = DBConnection.getConnection();

			for (MovieDto m : dto) {

				psmt = conn.prepareStatement(sql);

				psmt.setString(1, m.getTitle());
				psmt.setString(2, m.getContent());
				psmt.setDouble(3, m.getGrade());
				psmt.setString(4, m.getGenre());
				psmt.setString(5, m.getDirector());
				psmt.setInt(6, m.getRunningTime());
				psmt.setString(7, m.getOpeningDate());
				psmt.setString(8, m.getPoster());
				psmt.setDouble(9, m.getPercent());
				
				count = psmt.executeUpdate();
				
				if(count!=1) {
					return false;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return true;
	}
}
