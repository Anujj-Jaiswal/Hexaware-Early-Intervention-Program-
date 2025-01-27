import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { User } from '../models/user.model';
import { Flight } from '../models/flight.model';
import { Route } from '../models/route.model';
import { Booking } from '../models/booking.model';

@Injectable({
  providedIn: 'root'
})
export class AdminService {
  private apiUrl = 'http://localhost:8080/api';

  constructor(private http: HttpClient) {}

  // User API calls
  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(`${this.apiUrl}/users`);
  }

  deleteUser(userId: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/users/${userId}`);
  }

  // Flight API calls
  getFlights(): Observable<Flight[]> {
    return this.http.get<Flight[]>(`${this.apiUrl}/flights`);
  }

  deleteFlight(flightId: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/flights/${flightId}`);
  }

  // Route API calls
  getRoutes(): Observable<Route[]> {
    return this.http.get<Route[]>(`${this.apiUrl}/routes`);
  }

  deleteRoute(routeId: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/routes/${routeId}`);
  }

  // Booking API calls
  getBookings(): Observable<Booking[]> {
    return this.http.get<Booking[]>(`${this.apiUrl}/bookings`);
  }
}
