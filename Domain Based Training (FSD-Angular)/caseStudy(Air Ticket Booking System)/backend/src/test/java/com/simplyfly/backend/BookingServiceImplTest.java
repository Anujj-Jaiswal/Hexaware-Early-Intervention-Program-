package com.simplyfly.backend;

import com.simplyfly.dto.BookingDTO;
import com.simplyfly.entity.Booking;
import com.simplyfly.entity.Route;
import com.simplyfly.entity.User;
import com.simplyfly.exception.ResourceNotFoundException;
import com.simplyfly.exception.InvalidRequestException;
import com.simplyfly.repository.BookingRepository;
import com.simplyfly.repository.RouteRepository;
import com.simplyfly.repository.UserRepository;
import com.simplyfly.service.impl.BookingServiceImpl;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class BookingServiceImplTest {

    @InjectMocks
    private BookingServiceImpl bookingService;

    @Mock
    private BookingRepository bookingRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private RouteRepository routeRepository;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void createBooking_Success() {
        BookingDTO bookingDTO = new BookingDTO();
        bookingDTO.setUserId(1);
        bookingDTO.setRouteId(1);
        bookingDTO.setSeatsBooked(2);
        bookingDTO.setTotalPrice(500.0);
        bookingDTO.setStatus("CONFIRMED");

        User user = new User();
        user.setUserId(1);

        Route route = new Route();
        route.setRouteId(1);
        route.setAvailableSeats(10);

        Booking savedBooking = new Booking();
        savedBooking.setBookingId(1);
        savedBooking.setUser(user);
        savedBooking.setRoute(route);
        savedBooking.setSeatsBooked(2);
        savedBooking.setTotalPrice(500.0);
        savedBooking.setStatus(Booking.Status.CONFIRMED);
        savedBooking.setBookingDate(LocalDateTime.now());

        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(routeRepository.findById(1)).thenReturn(Optional.of(route));
        when(bookingRepository.save(any(Booking.class))).thenReturn(savedBooking);

        BookingDTO result = bookingService.createBooking(bookingDTO);

        assertNotNull(result);
        assertEquals(1, result.getBookingId());
        assertEquals(2, result.getSeatsBooked());
        assertEquals("CONFIRMED", result.getStatus());
        verify(routeRepository).save(route);
        verify(bookingRepository).save(any(Booking.class));
    }

    @Test
    void createBooking_UserNotFound() {
        BookingDTO bookingDTO = new BookingDTO();
        bookingDTO.setUserId(1);
        bookingDTO.setRouteId(1);

        when(userRepository.findById(1)).thenReturn(Optional.empty());

        ResourceNotFoundException exception = assertThrows(ResourceNotFoundException.class, 
                () -> bookingService.createBooking(bookingDTO));

        assertEquals("User with ID 1 not found", exception.getMessage());
    }

    @Test
    void createBooking_NotEnoughSeats() {
        BookingDTO bookingDTO = new BookingDTO();
        bookingDTO.setUserId(1);
        bookingDTO.setRouteId(1);
        bookingDTO.setSeatsBooked(15);

        User user = new User();
        user.setUserId(1);

        Route route = new Route();
        route.setRouteId(1);
        route.setAvailableSeats(10);

        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(routeRepository.findById(1)).thenReturn(Optional.of(route));

        InvalidRequestException exception = assertThrows(InvalidRequestException.class, 
                () -> bookingService.createBooking(bookingDTO));

        assertEquals("Not enough available seats on the route.", exception.getMessage());
    }

    @Test
    void getAllBookings_Success() {
        Booking booking = new Booking();
        booking.setBookingId(1);

        when(bookingRepository.findAll()).thenReturn(List.of(booking));

        List<BookingDTO> result = bookingService.getAllBookings();

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals(1, result.get(0).getBookingId());
    }

    @Test
    void getBookingById_Success() {
        Booking booking = new Booking();
        booking.setBookingId(1);

        when(bookingRepository.findById(1)).thenReturn(Optional.of(booking));

        BookingDTO result = bookingService.getBookingById(1);

        assertNotNull(result);
        assertEquals(1, result.getBookingId());
    }

    @Test
    void getBookingById_NotFound() {
        when(bookingRepository.findById(1)).thenReturn(Optional.empty());

        ResourceNotFoundException exception = assertThrows(ResourceNotFoundException.class, 
                () -> bookingService.getBookingById(1));

        assertEquals("Booking with ID 1 not found", exception.getMessage());
    }

    @Test
    void updateBooking_Success() {
        Booking booking = new Booking();
        booking.setBookingId(1);
        booking.setSeatsBooked(1);

        Route route = new Route();
        route.setRouteId(1);
        route.setAvailableSeats(10);

        BookingDTO bookingDTO = new BookingDTO();
        bookingDTO.setSeatsBooked(2);
        bookingDTO.setRouteId(1);
        bookingDTO.setTotalPrice(600.0);
        bookingDTO.setStatus("CONFIRMED");

        when(bookingRepository.findById(1)).thenReturn(Optional.of(booking));
        when(routeRepository.findById(1)).thenReturn(Optional.of(route));
        when(bookingRepository.save(booking)).thenReturn(booking);

        BookingDTO result = bookingService.updateBooking(1, bookingDTO);

        assertNotNull(result);
        assertEquals(2, result.getSeatsBooked());
        assertEquals(600.0, result.getTotalPrice());
        verify(bookingRepository).save(booking);
    }

    @Test
    void deleteBooking_Success() {
        Booking booking = new Booking();
        booking.setBookingId(1);

        when(bookingRepository.findById(1)).thenReturn(Optional.of(booking));

        bookingService.deleteBooking(1);

        verify(bookingRepository).delete(booking);
    }

    @Test
    void deleteBooking_NotFound() {
        when(bookingRepository.findById(1)).thenReturn(Optional.empty());

        ResourceNotFoundException exception = assertThrows(ResourceNotFoundException.class, 
                () -> bookingService.deleteBooking(1));

        assertEquals("Booking with ID 1 not found", exception.getMessage());
    }
}