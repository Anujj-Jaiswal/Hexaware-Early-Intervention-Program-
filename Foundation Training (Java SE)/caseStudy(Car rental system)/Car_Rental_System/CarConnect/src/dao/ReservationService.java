package dao;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entity.Reservation;
import utility.DBConnUtil;
import utility.DBPropertyUtil;

public class ReservationService implements IReservationService {

    private static final String GET_RESERVATION_BY_ID = "SELECT * FROM Reservation WHERE ReservationID = ?";
    private static final String GET_RESERVATIONS_BY_CUSTOMER_ID = "SELECT * FROM Reservation WHERE CustomerID = ?";
    private static final String CREATE_RESERVATION = "INSERT INTO Reservation (CustomerID, VehicleID, StartDate, EndDate, TotalCost, Status) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_RESERVATION = "UPDATE Reservation SET StartDate = ?, EndDate = ?, TotalCost = ?, Status = ? WHERE ReservationID = ?";
    private static final String CANCEL_RESERVATION = "DELETE FROM Reservation WHERE ReservationID = ?";

    @Override
    public Reservation getReservationById(int reservationId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnUtil.getConnection(DBPropertyUtil.getConnectionString("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties"));
            stmt = conn.prepareStatement(GET_RESERVATION_BY_ID);
            stmt.setInt(1, reservationId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return new Reservation(
                        rs.getInt("ReservationID"),
                        rs.getInt("CustomerID"),
                        rs.getInt("VehicleID"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getDouble("TotalCost"),
                        rs.getString("Status")
                );
            }
        } catch (SQLException  e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return null;
    }

    @Override
    public List<Reservation> getReservationsByCustomerId(int customerId) {
        List<Reservation> reservations = new ArrayList<Reservation>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnUtil.getConnection(DBPropertyUtil.getConnectionString("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties"));
            stmt = conn.prepareStatement(GET_RESERVATIONS_BY_CUSTOMER_ID);
            stmt.setInt(1, customerId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                reservations.add(new Reservation(
                        rs.getInt("ReservationID"),
                        rs.getInt("CustomerID"),
                        rs.getInt("VehicleID"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getDouble("TotalCost"),
                        rs.getString("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return reservations;
    }

    @Override
    public void createReservation(Reservation reservation) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBConnUtil.getConnection(DBPropertyUtil.getConnectionString("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties"));
            stmt = conn.prepareStatement(CREATE_RESERVATION);
            stmt.setInt(1, reservation.getCustomerId());
            stmt.setInt(2, reservation.getVehicleId());
            stmt.setDate(3, new java.sql.Date(reservation.getStartDate().getTime()));
            stmt.setDate(4, new java.sql.Date(reservation.getEndDate().getTime()));
            stmt.setDouble(5, reservation.getTotalCost());
            stmt.setString(6, reservation.getStatus());
            stmt.executeUpdate();
        } catch (SQLException  e) {
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, conn);
        }
    }

    @Override
    public void updateReservation(Reservation reservation) {
        PreparedStatement stmt = null;
        Connection conn = null;
        try {
            conn = DBConnUtil.getConnection(DBPropertyUtil.getConnectionString("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties"));
            stmt = conn.prepareStatement(UPDATE_RESERVATION);
            stmt.setDate(1, new java.sql.Date(reservation.getStartDate().getTime()));
            stmt.setDate(2, new java.sql.Date(reservation.getEndDate().getTime()));
            stmt.setDouble(3, reservation.getTotalCost());
            stmt.setString(4, reservation.getStatus());
            stmt.setInt(5, reservation.getReservationId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, stmt, conn);
        }
    }

    @Override
    public void cancelReservation(int reservationId) {
        PreparedStatement stmt = null;
        Connection conn = null;
        try {
            conn = DBConnUtil.getConnection(DBPropertyUtil.getConnectionString("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties"));
            stmt = conn.prepareStatement(CANCEL_RESERVATION);
            stmt.setInt(1, reservationId);
            stmt.executeUpdate();
        } catch (SQLException  e) {
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

