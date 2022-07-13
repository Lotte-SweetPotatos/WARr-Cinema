package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MovieDto;
import dto.RunningDto;

public class RunningDao {
	private static RunningDao dao = new RunningDao();
	
	private RunningDao() {
		DBConnection.initConnection();
	}

	public static RunningDao getInstance() {
		return dao;
	}
	
	public void save(RunningDto dto) {
		String sql = "insert into running(movie_id, reserveStartTime, reserveEndTime, runningTime, runningDate, cineName, totalSeat, curSeat) "
				+ "values(?,?,?,?,?,?,?,?) ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			
			conn = DBConnection.getConnection();
			
			psmt = conn.prepareStatement(sql);
	        psmt.setLong(1,dto.getMovie_id());
	        psmt.setString(2, dto.getReserveStartTime());
	        psmt.setString(3, dto.getReserveEndTime());
	        psmt.setInt(4, dto.getRunningTime());
	        psmt.setString(5, dto.getRunningDate());
	        psmt.setString(6, dto.getCineName());
	        psmt.setInt(7, dto.getTotalSeat());
	        psmt.setInt(8, dto.getCurSeat());
	        
	        psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
	}
}
