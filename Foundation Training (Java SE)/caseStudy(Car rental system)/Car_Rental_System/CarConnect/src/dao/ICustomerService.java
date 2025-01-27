package dao;

import entity.Customer;

public interface ICustomerService {
	Customer getCustomerById(int customerId);
	Customer getCustomerByUsername(String username);
	void registerCustomer(Customer customer);
	void updateCustomer(Customer customer);
	void deleteCustomer(int customerId);
}
