package dao;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import entity.Admin;
import utility.DBConnUtil;
import utility.DBPropertyUtil;


public class AdminService implements IAdminService {

    private static final String GET_ADMIN_BY_ID = "SELECT * FROM Admin WHERE AdminID = ?";
    private static final String GET_ADMIN_BY_USERNAME = "SELECT * FROM Admin WHERE Username = ?";
    private static final String REGISTER_ADMIN = "INSERT INTO Admin (FirstName, LastName, Email, PhoneNumber, Username, Password, Role, JoinDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_ADMIN = "UPDATE Admin SET FirstName = ?, LastName = ?, Email = ?, PhoneNumber = ?, Username = ?, Password = ?, Role = ? WHERE AdminID = ?";
    private static final String DELETE_ADMIN = "DELETE FROM Admin WHERE AdminID = ?";

    @Override
    public Admin getAdminById(int adminId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnUtil.getConnection("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties");
            stmt = conn.prepareStatement(GET_ADMIN_BY_ID);
            stmt.setInt(1, adminId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return new Admin(
                        rs.getInt("AdminID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getDate("JoinDate")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return null;
    }

    @Override
    public Admin getAdminByUsername(String username) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnUtil.getConnection("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties");
            stmt = conn.prepareStatement(GET_ADMIN_BY_USERNAME);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return new Admin(
                        rs.getInt("AdminID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getDate("JoinDate")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return null;
    }

    @Override
    public void registerAdmin(Admin admin) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBConnUtil.getConnection("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties");
            stmt = conn.prepareStatement(REGISTER_ADMIN);
            stmt.setString(1, admin.getFirstName());
            stmt.setString(2, admin.getLastName());
            stmt.setString(3, admin.getEmail());
            stmt.setString(4, admin.getPhoneNumber());
            stmt.setString(5, admin.getUsername());
            stmt.setString(6, admin.getPassword());
            stmt.setString(7, admin.getRole());
            stmt.setDate(8, new java.sql.Date(admin.getJoinDate().getTime()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, conn);
        }
    }

    @Override
    public void updateAdmin(Admin admin) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBConnUtil.getConnection("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties");
            stmt = conn.prepareStatement(UPDATE_ADMIN);
            stmt.setString(1, admin.getFirstName());
            stmt.setString(2, admin.getLastName());
            stmt.setString(3, admin.getEmail());
            stmt.setString(4, admin.getPhoneNumber());
            stmt.setString(5, admin.getUsername());
            stmt.setString(6, admin.getPassword());
            stmt.setString(7, admin.getRole());
            stmt.setInt(8, admin.getAdminId());
            stmt.executeUpdate();
        } catch (SQLException  e) {
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, conn);
        }
    }

    @Override
    public void deleteAdmin(int adminId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBConnUtil.getConnection("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties");
            stmt = conn.prepareStatement(DELETE_ADMIN);
            stmt.setInt(1, adminId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, conn);
        }
    }

    private void closeResources(ResultSet rs, Statement stmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
