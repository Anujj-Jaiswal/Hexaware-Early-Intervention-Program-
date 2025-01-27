package dao;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import entity.Customer;
import exception.AuthenticationException;
import java.util.Date;

class TestCustomerService {
    private CustomerService customerService;

    @BeforeEach
    void setUp() {
        customerService = new CustomerService();
    }

    @Test
    void testAuthenticateCustomerWithInvalidCredentials() {
        String invalidUsername = "invalidUser";
        String invalidPassword = "wrongPassword";
        try {
            customerService.authenticateCustomer(invalidUsername, invalidPassword);
            fail("Expected an AuthenticationException to be thrown");
        } catch (AuthenticationException e) {
            assertEquals("Invalid username or password!", e.getMessage());
        }
    }

    @Test
    void testRegisterCustomer() {
        Customer customer = new Customer(0, "Jane", "Doe", "jane.doe@example.com", "0987654321", 
                                         "456 Park Ave", "janedoe", "password456", new Date());
        customerService.registerCustomer(customer);
        Customer fetchedCustomer = customerService.getCustomerByUsername("janedoe");
        assertNotNull(fetchedCustomer);
    }
}
