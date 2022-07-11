package dao;

import db.DBConnection;
import dto.MemberDto;

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
}
