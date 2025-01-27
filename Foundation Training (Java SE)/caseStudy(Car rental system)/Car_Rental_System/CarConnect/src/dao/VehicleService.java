package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entity.Vehicle;
import utility.DBConnUtil;
import utility.DBPropertyUtil;

public class VehicleService implements IVehicleService {
	// C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties
	String path = "C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties";

    private static final String GET_VEHICLE_BY_ID = "SELECT * FROM Vehicle WHERE VehicleID = ?";
    private static final String GET_AVAILABLE_VEHICLES = "SELECT * FROM Vehicle WHERE Availability = true";
    private static final String ADD_VEHICLE = "INSERT INTO Vehicle (Model, Make, Year, Color, RegistrationNumber, Availability, DailyRate) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_VEHICLE = "UPDATE Vehicle SET Model = ?, Make = ?, Year = ?, Color = ?, RegistrationNumber = ?, Availability = ?, DailyRate = ? WHERE VehicleID = ?";
    private static final String REMOVE_VEHICLE = "DELETE FROM Vehicle WHERE VehicleID = ?";

    @Override
    public Vehicle getVehicleById(int vehicleId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Vehicle vehicle = null;

        try {
        	// DBConnUtil.getConnection("C:\\Users\\hp\\Downloads\\Hexware JDBC\\CarConnect\\resources\\db.properties"))
            conn = DBConnUtil.getConnection(path);
            stmt = conn.prepareStatement(GET_VEHICLE_BY_ID);
            stmt.setInt(1, vehicleId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                vehicle = new Vehicle(
                        rs.getInt("VehicleID"),
                        rs.getString("Model"),
                        rs.getString("Make"),
                        rs.getInt("Year"),
                        rs.getString("Color"),
                        rs.getString("RegistrationNumber"),
                        rs.getBoolean("Availability"),
                        rs.getDouble("DailyRate")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return vehicle;
    }

    @Override
    public List<Vehicle> getAvailableVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnUtil.getConnection(path);
            stmt = conn.createStatement();
            rs = stmt.executeQuery(GET_AVAILABLE_VEHICLES);

            while (rs.next()) {
                vehicles.add(new Vehicle(
                        rs.getInt("VehicleID"),
                        rs.getString("Model"),
                        rs.getString("Make"),
                        rs.getInt("Year"),
                        rs.getString("Color"),
                        rs.getString("RegistrationNumber"),
                        rs.getBoolean("Availability"),
                        rs.getDouble("DailyRate")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return vehicles;
    }

    @Override
    public void addVehicle(Vehicle vehicle) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnUtil.getConnection(path);
            stmt = conn.prepareStatement(ADD_VEHICLE);

            stmt.setString(1, vehicle.getModel());
            stmt.setString(2, vehicle.getMake());
            stmt.setInt(3, vehicle.getYear());
            stmt.setString(4, vehicle.getColor());
            stmt.setString(5, vehicle.getRegistrationNumber());
            stmt.setBoolean(6, vehicle.isAvailability());
            stmt.setDouble(7, vehicle.getDailyRate());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void updateVehicle(Vehicle vehicle) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnUtil.getConnection(path);
            stmt = conn.prepareStatement(UPDATE_VEHICLE);

            stmt.setString(1, vehicle.getModel());
            stmt.setString(2, vehicle.getMake());
            stmt.setInt(3, vehicle.getYear());
            stmt.setString(4, vehicle.getColor());
            stmt.setString(5, vehicle.getRegistrationNumber());
            stmt.setBoolean(6, vehicle.isAvailability());
            stmt.setDouble(7, vehicle.getDailyRate());
            stmt.setInt(8, vehicle.getVehicleId());
            stmt.executeUpdate();
        } catch (SQLException  e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void removeVehicle(int vehicleId) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnUtil.getConnection(path);
            stmt = conn.prepareStatement(REMOVE_VEHICLE);

            stmt.setInt(1, vehicleId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

