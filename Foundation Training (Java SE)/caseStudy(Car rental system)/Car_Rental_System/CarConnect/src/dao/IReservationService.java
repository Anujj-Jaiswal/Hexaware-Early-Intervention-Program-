package dao;

import entity.Reservation;
import java.util.List;

public interface IReservationService {
    Reservation getReservationById(int reservationId);
    List<Reservation> getReservationsByCustomerId(int customerId);
    void createReservation(Reservation reservation);
    void updateReservation(Reservation reservation);
    void cancelReservation(int reservationId);
}
