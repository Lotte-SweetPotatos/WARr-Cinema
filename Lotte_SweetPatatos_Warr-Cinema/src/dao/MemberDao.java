package dao;

import db.DBConnection;
import dto.MemberDto;

import org.json.JSONArray;
import org.json.JSONObject;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

public class MemberDao {

    private static final MemberDao memberDao = new MemberDao();

    private MemberDao() {
        DBConnection.initConnection();
    }

    public static MemberDao getInstance() {
        return memberDao;
    }

    public boolean findBy(String userId) {
        String sql = "select count(*) from member where userId = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement psmt = conn.prepareStatement(sql)
        ) {
            psmt.setString(1, userId);

            try (
                    ResultSet rs = psmt.executeQuery()
            ) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Optional<MemberDto> findBy(String userId, String password) {
        String sql = "select * from member where userId = ? and password = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement psmt = conn.prepareStatement(sql)
        ) {
            psmt.setString(1, userId);
            psmt.setString(2, password);

            try (ResultSet rs = psmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(new MemberDto(
                            rs.getLong(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5)
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public boolean save(MemberDto memberDto) {
        String sql = "insert into member(userId, userName, password, email) values(?, ?, ?, ?)";
        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setString(1, memberDto.getUserId());
            pstmt.setString(2, memberDto.getUserName());
            pstmt.setString(3, memberDto.getPassword());
            pstmt.setString(4, memberDto.getEmail());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public JSONObject findByReserve(int user_id) {

		String sql = " select title,poster,cineName,runningDate,reserveStartTime,reserveEndTime, mv.id , rn.id from member m "
				+ "	join reservation r " + "	on r.member_id = m.id " + "	join movie mv " + "	on r.movie_id = mv.id "
				+ "	join running rn " + "	on r.running_id = rn.id " + " where m.id = ?; ";

		JSONObject jsonob = new JSONObject();

		try (
          Connection conn = DBConnection.getConnection(); 
          PreparedStatement psmt = conn.prepareStatement(sql);
		) {
			psmt.setInt(1, user_id);
			ResultSet rs = psmt.executeQuery();
			JSONArray jsonarr = new JSONArray();

			while (rs.next()) {
				JSONObject data = new JSONObject();
				data.put("title", rs.getString(1));
				data.put("poster", rs.getString(2));
				data.put("cineName", rs.getString(3));
				data.put("runningDate", rs.getString(4));
				data.put("reserveStartTime", rs.getString(5));
				data.put("reserveEndTime", rs.getString(6));
				data.put("movie_id", rs.getInt(7));
				data.put("running_id", rs.getInt(8));
				jsonarr.put(data);
			}

			jsonob.put("reserve", jsonarr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonob;
	}

	public boolean cancelReserve(int member_id, int movie_id, int running_id) {

		String sql = " delete from reservation where member_id = ? and movie_id = ? and running_id = ? ";
		int count = 0;

		try (
          Connection conn = DBConnection.getConnection(); 
          PreparedStatement psmt = conn.prepareStatement(sql);
		) {
			psmt.setInt(1, member_id);
			psmt.setInt(2, movie_id);
			psmt.setInt(3, running_id);

			count = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count > 0 ? true : false;
	}
}
