package main;

import dao.CustomerService;  
import dao.VehicleService;
import dao.AdminService;
import entity.Customer;
import entity.Vehicle;
import entity.Admin;
import java.util.Scanner;
import java.util.Date;

public class MainModule {
	public static void main(String[] args) {
		CustomerService customerService = new CustomerService();
		VehicleService vehicleService = new VehicleService();
		AdminService adminService = new AdminService();

		Scanner scanner = new Scanner(System.in);
		boolean exit = false;

		while (!exit) {
			System.out.println("\nCarConnect Menu:");
			System.out.println("1. Register Customer");
			System.out.println("2. Login Customer");
			System.out.println("3. Update Customer by ID");
			System.out.println("4. Delete Customer by ID");
			System.out.println("5. Add Vehicle");
			System.out.println("6. Update Vehicle by ID");
			System.out.println("7. Delete Vehicle by ID");
			System.out.println("8. Admin Login");
			System.out.println("9. Add Admin");
			System.out.println("10. Update Admin by ID");
			System.out.println("11. Delete Admin by ID");
			System.out.println("12. Exit");
			System.out.print("Choose an option: ");
			int option = scanner.nextInt();
			scanner.nextLine(); // Consume newline

			switch (option) {
			case 1: // Register new customer
				System.out.print("Enter first name: ");
				String firstName = scanner.nextLine();
				System.out.print("Enter last name: ");
				String lastName = scanner.nextLine();
				System.out.print("Enter email: ");
				String email = scanner.nextLine();
				System.out.print("Enter phone number: ");
				String phoneNumber = scanner.nextLine();
				System.out.print("Enter address: ");
				String address = scanner.nextLine();
				System.out.print("Enter username: ");
				String username = scanner.nextLine();
				System.out.print("Enter password: ");
				String password = scanner.nextLine();

				Customer customer = new Customer(0, firstName, lastName, email, phoneNumber, address, username, password, new Date());
				customerService.registerCustomer(customer);
				System.out.println("Customer registered successfully!");
				break;

			case 2: // Login existing customer
				System.out.print("Enter username: ");
				String loginUsername = scanner.nextLine();
				System.out.print("Enter password: ");
				String loginPassword = scanner.nextLine();

				Customer loginCustomer = customerService.getCustomerByUsername(loginUsername);
				if (loginCustomer != null && loginCustomer.authenticate(loginPassword)) {
					System.out.println("Login successful! Welcome, " + loginCustomer.getFirstName());
				} else {
					System.out.println("Invalid username or password!");
				}
				break;

			case 3: // Update customer by ID
				System.out.print("Enter customer ID to update: ");
				int updateId = scanner.nextInt();
				scanner.nextLine(); // Consume newline

				Customer existingCustomer = customerService.getCustomerById(updateId);
				if (existingCustomer != null) {
					System.out.println("Customer found! Enter new details:");

					System.out.print("Enter first name (" + existingCustomer.getFirstName() + "): ");
					String newFirstName = scanner.nextLine();
					if (!newFirstName.isEmpty()) {
						existingCustomer.setFirstName(newFirstName);
					}

					System.out.print("Enter last name (" + existingCustomer.getLastName() + "): ");
					String newLastName = scanner.nextLine();
					if (!newLastName.isEmpty()) {
						existingCustomer.setLastName(newLastName);
					}

					System.out.print("Enter email (" + existingCustomer.getEmail() + "): ");
					String newEmail = scanner.nextLine();
					if (!newEmail.isEmpty()) {
						existingCustomer.setEmail(newEmail);
					}

					System.out.print("Enter phone number (" + existingCustomer.getPhoneNumber() + "): ");
					String newPhoneNumber = scanner.nextLine();
					if (!newPhoneNumber.isEmpty()) {
						existingCustomer.setPhoneNumber(newPhoneNumber);
					}

					System.out.print("Enter address (" + existingCustomer.getAddress() + "): ");
					String newAddress = scanner.nextLine();
					if (!newAddress.isEmpty()) {
						existingCustomer.setAddress(newAddress);
					}

					customerService.updateCustomer(existingCustomer);
					System.out.println("Customer updated successfully!");
				} else {
					System.out.println("Customer not found!");
				}
				break;

			case 4: // Delete customer by ID
				System.out.print("Enter customer ID to delete: ");
				int deleteId = scanner.nextInt();

				Customer customerToDelete = customerService.getCustomerById(deleteId);
				if (customerToDelete != null) {
					customerService.deleteCustomer(deleteId);
					System.out.println("Customer deleted successfully!");
				} else {
					System.out.println("Customer not found!");
				}
				break;

			case 5: // Add Vehicle
				System.out.print("Enter vehicle model: ");
				String model = scanner.nextLine();
				System.out.print("Enter vehicle maker: ");
				String make = scanner.nextLine();
				System.out.print("Enter vehicle year: ");
				int year = scanner.nextInt();
				scanner.nextLine(); // Consume newline
				System.out.print("Enter vehicle color: ");
				String color = scanner.nextLine();
				System.out.print("Enter registration number: ");
				String registrationNumber = scanner.nextLine();
				System.out.print("Enter availability (true/false): ");
				boolean availability = scanner.nextBoolean();
				System.out.print("Enter daily rate: ");
				double dailyRate = scanner.nextDouble();
				scanner.nextLine(); // Consume newline

				Vehicle vehicle = new Vehicle(0, model, make, year, color, registrationNumber, availability, dailyRate);
				vehicleService.addVehicle(vehicle);
				System.out.println("Vehicle added successfully!");
				break;

			case 6: // Update Vehicle by ID
				System.out.print("Enter vehicle ID to update: ");
				int vehicleId = scanner.nextInt();
				scanner.nextLine(); // Consume newline

				Vehicle existingVehicle = vehicleService.getVehicleById(vehicleId);
				if (existingVehicle != null) {
					System.out.println("Vehicle found! Enter new details:");

					System.out.print("Enter model (" + existingVehicle.getModel() + "): ");
					String newModel = scanner.nextLine();
					if (!newModel.isEmpty()) {
						existingVehicle.setModel(newModel);
					}

					System.out.print("Enter make (" + existingVehicle.getMake() + "): ");
					String newMake = scanner.nextLine();
					if (!newMake.isEmpty()) {
						existingVehicle.setMake(newMake);
					}

					System.out.print("Enter year (" + existingVehicle.getYear() + "): ");
					int newYear = scanner.nextInt();
					scanner.nextLine(); // Consume newline
					if (newYear != 0) {
						existingVehicle.setYear(newYear);
					}

					System.out.print("Enter color (" + existingVehicle.getColor() + "): ");
					String newColor = scanner.nextLine();
					if (!newColor.isEmpty()) {
						existingVehicle.setColor(newColor);
					}

					System.out.print("Enter registration number (" + existingVehicle.getRegistrationNumber() + "): ");
					String newRegNum = scanner.nextLine();
					if (!newRegNum.isEmpty()) {
						existingVehicle.setRegistrationNumber(newRegNum);
					}

					System.out.print("Enter availability (" + existingVehicle.isAvailability() + "): ");
					boolean newAvailability = scanner.nextBoolean();
					existingVehicle.setAvailability(newAvailability);

					System.out.print("Enter daily rate (" + existingVehicle.getDailyRate() + "): ");
					double newDailyRate = scanner.nextDouble();
					if (newDailyRate != 0) {
						existingVehicle.setDailyRate(newDailyRate);
					}

					vehicleService.updateVehicle(existingVehicle);
					System.out.println("Vehicle updated successfully!");
				} else {
					System.out.println("Vehicle not found!");
				}
				break;

			case 7: // Delete Vehicle by ID
				System.out.print("Enter vehicle ID to delete: ");
				int vehicleToDelete = scanner.nextInt();

				Vehicle vehicleDelete = vehicleService.getVehicleById(vehicleToDelete);
				if (vehicleDelete != null) {
					vehicleService.removeVehicle(vehicleToDelete);
					System.out.println("Vehicle deleted successfully!");
				} else {
					System.out.println("Vehicle not found!");
				}
				break;

			case 8: // Admin login
				System.out.print("Enter admin username: ");
				String adminUname = scanner.nextLine();
				System.out.print("Enter admin password: ");
				String adminPass = scanner.nextLine();

				Admin adminLogin = adminService.getAdminByUsername(adminUname);
				if (adminLogin != null && adminLogin.authenticate(adminPass)) {
					System.out.println("Admin login successful! Welcome, " + adminLogin.getFirstName());
				} else {
					System.out.println("Invalid admin username or password!");
				}
				break;

			case 9: // Add Admin
				System.out.print("Enter admin first name: ");
				String adminFirstName = scanner.nextLine();
				System.out.print("Enter admin last name: ");
				String adminLastName = scanner.nextLine();
				System.out.print("Enter admin email: ");
				String adminEmail = scanner.nextLine();
				System.out.print("Enter admin phone number: ");
				String adminPhoneNumber = scanner.nextLine();
				System.out.print("Enter admin username: ");
				String adminUsername = scanner.nextLine();
				System.out.print("Enter admin password: ");
				String adminPassword = scanner.nextLine();
				System.out.print("Enter admin role: ");
				String adminRole = scanner.nextLine();

				Admin newAdmin = new Admin(0, adminFirstName, adminLastName, adminEmail, adminPhoneNumber,
						adminUsername, adminPassword, adminRole, new Date());
				adminService.registerAdmin(newAdmin);
				System.out.println("Admin added successfully!");
				break;

			case 10: // Update Admin by ID
				System.out.print("Enter admin ID to update: ");
				int updateAdminId = scanner.nextInt();
				scanner.nextLine(); // Consume newline

				Admin existingAdmin = adminService.getAdminById(updateAdminId);
				if (existingAdmin != null) {
					System.out.println("Admin found! Enter new details:");

					System.out.print("Enter first name (" + existingAdmin.getFirstName() + "): ");
					String newAdminFirstName = scanner.nextLine();
					if (!newAdminFirstName.isEmpty()) {
						existingAdmin.setFirstName(newAdminFirstName);
					}

					System.out.print("Enter last name (" + existingAdmin.getLastName() + "): ");
					String newAdminLastName = scanner.nextLine();
					if (!newAdminLastName.isEmpty()) {
						existingAdmin.setLastName(newAdminLastName);
					}

					System.out.print("Enter email (" + existingAdmin.getEmail() + "): ");
					String newAdminEmail = scanner.nextLine();
					if (!newAdminEmail.isEmpty()) {
						existingAdmin.setEmail(newAdminEmail);
					}

					System.out.print("Enter phone number (" + existingAdmin.getPhoneNumber() + "): ");
					String newAdminPhoneNumber = scanner.nextLine();
					if (!newAdminPhoneNumber.isEmpty()) {
						existingAdmin.setPhoneNumber(newAdminPhoneNumber);
					}

					System.out.print("Enter username (" + existingAdmin.getUsername() + "): ");
					String newAdminUsername = scanner.nextLine();
					if (!newAdminUsername.isEmpty()) {
						existingAdmin.setUsername(newAdminUsername);
					}

					System.out.print("Enter password: ");
					String newAdminPassword = scanner.nextLine();
					if (!newAdminPassword.isEmpty()) {
						existingAdmin.setPassword(newAdminPassword);
					}

					System.out.print("Enter role (" + existingAdmin.getRole() + "): ");
					String newAdminRole = scanner.nextLine();
					if (!newAdminRole.isEmpty()) {
						existingAdmin.setRole(newAdminRole);
					}

					adminService.updateAdmin(existingAdmin);
					System.out.println("Admin updated successfully!");
				} else {
					System.out.println("Admin not found!");
				}
				break;

			case 11: // Delete Admin by ID
				System.out.print("Enter admin ID to delete: ");
				int deleteAdminId = scanner.nextInt();

				Admin adminToDelete = adminService.getAdminById(deleteAdminId);
				if (adminToDelete != null) {
					adminService.deleteAdmin(deleteAdminId);
					System.out.println("Admin deleted successfully!");
				} else {
					System.out.println("Admin not found!");
				}
				break;

			case 12: // Exit
				exit = true;
				System.out.println("Exiting...");
				break;

			default:
				System.out.println("Invalid option. Please try again.");
			}
		}
		scanner.close();
	}
}