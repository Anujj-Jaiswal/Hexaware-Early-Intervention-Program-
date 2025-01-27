package entity;

import java.util.Date;

public class Reservation {
	private int reservationId;
	private int customerId;
	private int vehicleId;
	private Date startDate;
	private Date endDate;
	private double totalCost;
	private String status;

	// Constructors
	public Reservation() {}
	
	

	public Reservation(int reservationId, int customerId, int vehicleId, Date startDate, Date endDate,
			double totalCost, String status) {
		this.reservationId = reservationId;
		this.customerId = customerId;
		this.vehicleId = vehicleId;
		this.startDate = startDate;
		this.endDate = endDate;
		this.totalCost = totalCost;
		this.status = status;
	}

	public int getReservationId() {
		return reservationId;
	}

	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public int getVehicleId() {
		return vehicleId;
	}

	public void setVehicleId(int vehicleId) {
		this.vehicleId = vehicleId;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public double getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	// Method to calculate total cost
	public double calculateTotalCost() {
		long duration = (endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24);
		return duration * totalCost;
	}

	
}
