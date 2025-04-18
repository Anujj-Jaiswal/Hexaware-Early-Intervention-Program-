package com.simplyfly.dto;



public class BookingDTO {
    private Integer bookingId;
    private Integer userId;
    private Integer routeId;
    private int seatsBooked;
    private double totalPrice;
    private String status;
    private String bookingDate;
    public Integer getBookingId() {
        return bookingId;
    }
    public void setBookingId(Integer bookingId) {
        this.bookingId = bookingId;
    }
    public Integer getUserId() {
        return userId;
    }
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    public Integer getRouteId() {
        return routeId;
    }
    public void setRouteId(Integer routeId) {
        this.routeId = routeId;
    }
    public int getSeatsBooked() {
        return seatsBooked;
    }
    public void setSeatsBooked(int seatsBooked) {
        this.seatsBooked = seatsBooked;
    }
    public double getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(double d) {
        this.totalPrice = d;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getBookingDate() {
        return bookingDate;
    }
    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    // Getters and setters

    
}
