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
import dto.RunningDto;

public class TicketDao {
   
   private static final TicketDao ticketDao= new TicketDao();
   
   private TicketDao() {
      DBConnection.initConnection();
   }
   
   public static TicketDao getInstance() {
      return ticketDao;
   }
   
   // movieDao
   /**
    * 상영중인 영화 조회
    * @return List<MovieDto>
    */
   public List<MovieDto> findMovies() {
      
      String sql="select id,title from movie";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      List<MovieDto> list = new ArrayList<MovieDto>();
      
      try {
         conn = DBConnection.getConnection();
         psmt = conn.prepareStatement(sql);
         rs = psmt.executeQuery();
         
         while(rs.next()) {
            MovieDto dto = new MovieDto(rs.getInt(1), rs.getString(2));
            list.add(dto);
         }
         
      } catch (SQLException e) {
         e.printStackTrace();
         
      } finally {
         
         DBClose.close(conn, psmt, rs);
      }
      
      return list;
      
   }
   
   /**
    * movieId와 runningDate로 영화 조회
    * @param movieId
    * @param runningDate
    * @return List<RunningDto>
    */
   public List<RunningDto> findByMovieIdAndRunningDate(int movieId, String runningDate){
      
      String sql="select * from running where movie_Id=? and runningDate = ? order by reserveStartTime";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      List<RunningDto> list = new ArrayList<RunningDto>();
      
      try {
         conn = DBConnection.getConnection();
         
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1,movieId);
         psmt.setString(2, runningDate);
         
         rs = psmt.executeQuery();
         
         while(rs.next()) {
            RunningDto dto = new RunningDto(rs.getInt(1),
                                    rs.getInt(2),
                                    rs.getString(3),
                                    rs.getString(4),
                                    rs.getInt(5),
                                    rs.getString(6),
                                    rs.getString(7),
                                    rs.getInt(8),
                                    rs.getInt(9));
            list.add(dto);
         }
         
      } catch (SQLException e) {
         e.printStackTrace();
         
      } finally {
         DBClose.close(conn, psmt, rs);
      }
      
      return list;
   }
   
   /**
    * movie ticket 예매
    * @param userId
    * @param runningId
    * @param movieId
    */
   public void saveReserve(int memberId, int runningId, int movieId) {
	   System.out.println("saveReserve");
      
      String sql = "insert into reservation(member_id,running_id,movie_id) values(?,?,?);";
   
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      try {
         conn = DBConnection.getConnection();
         
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1,memberId);
         psmt.setInt(2, runningId);
         psmt.setInt(3, movieId);
         
         psmt.executeUpdate();
         
      } catch (SQLException e) {
         e.printStackTrace();
         
      } finally {
         DBClose.close(conn, psmt, rs);
         
      }
   }
   
   /**
    * 남은 좌석 업데이트(남은좌석 -1)
    * @param runningId
    */
   public void updateCurSeat(int runningId,int curSeat) {
      System.out.println("updateCurSeat");
      int updateSeat=curSeat-1;
      String sql ="update running set curSeat=? where id=?;";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      try {
         conn = DBConnection.getConnection();
         
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1,updateSeat);
         psmt.setInt(2, runningId);
         
         psmt.executeUpdate();
         
      } catch (SQLException e) {
         e.printStackTrace();
         
      } finally {
         DBClose.close(conn, psmt, rs);
         
      }
      
   }
   
   /**
    * 남은 좌석 수 조회
    * @param runningId
    * @return int
    */
   public int findCurSeat(int runningId) {
	   System.out.println("findCurSeat");
      
      String sql = "select curSeat from running where id=?";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      int curSeat=0;
      
      try {
         conn = DBConnection.getConnection();
         
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1,runningId);
         
         rs = psmt.executeQuery();
         
         while(rs.next()) {
            curSeat=rs.getInt(1);
         }
         
      } catch (SQLException e) {
         e.printStackTrace();
         
      } finally {
         DBClose.close(conn, psmt, rs);
         
      }
      
      return curSeat;
   }

}