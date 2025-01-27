package entity;

import java.util.Date;

public class Customer {
	private int customerId;
	private String firstName;
	private String lastName;
	private String email;
	private String phoneNumber;
	private String address;
	private String username;
	private String password;
	private Date registrationDate;

	// Constructors
	public Customer() {}

	public Customer(int customerId, String firstName, String lastName, String email, String phoneNumber,
			String address, String username, String password, Date registrationDate) {
		this.customerId = customerId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.username = username;
		this.password = password;
		this.registrationDate = registrationDate;
	}

	// Getters and Setters
	public int getCustomerId() { return customerId; }
	public void setCustomerId(int customerId) { this.customerId = customerId; }
	public String getFirstName() { return firstName; }
	public void setFirstName(String firstName) { this.firstName = firstName; }
	public String getLastName() { return lastName; }
	public void setLastName(String lastName) { this.lastName = lastName; }
	public String getEmail() { return email; }
	public void setEmail(String email) { this.email = email; }
	public String getPhoneNumber() { return phoneNumber; }
	public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
	public String getAddress() { return address; }
	public void setAddress(String address) { this.address = address; }
	public String getUsername() { return username; }
	public void setUsername(String username) { this.username = username; }
	public String getPassword() { return password; }
	public void setPassword(String password) { this.password = password; }
	public Date getRegistrationDate() { return registrationDate; }
	public void setRegistrationDate(Date registrationDate) { this.registrationDate = registrationDate; }

	// Method to authenticate customer
	public boolean authenticate(String password) {
		return this.password.equals(password);
	}
}
