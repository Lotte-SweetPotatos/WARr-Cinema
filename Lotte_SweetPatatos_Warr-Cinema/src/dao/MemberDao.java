package dao;

import db.DBConnection;
import dto.MemberDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

    public void save(MemberDto memberDto) {
        String sql = "insert into member(userId, userName, password, email) values(?, ?, ?, ?)";
        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {

            pstmt.setString(1, memberDto.getUserId());
            pstmt.setString(2, memberDto.getUserName());
            pstmt.setString(3, memberDto.getPassword());
            pstmt.setString(4, memberDto.getEmail());
            int i = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
