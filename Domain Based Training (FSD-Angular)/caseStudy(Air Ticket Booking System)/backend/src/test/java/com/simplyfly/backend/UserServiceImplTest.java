package com.simplyfly.backend;


import com.simplyfly.dto.UserDTO;
import com.simplyfly.entity.User;
import com.simplyfly.exception.ResourceNotFoundException;
import com.simplyfly.exception.DuplicateResourceException;
import com.simplyfly.repository.UserRepository;
import com.simplyfly.service.AuthenticationService;
import com.simplyfly.service.impl.UserServiceImpl;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class UserServiceImplTest {

    @InjectMocks
    private UserServiceImpl userService;

    @Mock
    private UserRepository userRepository;

    @Mock
    private AuthenticationService authenticationService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void createUser_Success() {
        User user = new User();
        user.setEmail("test@example.com");
        user.setUsername("testuser");

        when(userRepository.existsByEmail("test@example.com")).thenReturn(false);
        when(userRepository.save(user)).thenReturn(user);

        User result = userService.createUser(user);

        assertNotNull(result);
        assertEquals("test@example.com", result.getEmail());
        verify(userRepository).save(user);
    }

    @Test
    void createUser_DuplicateEmail() {
        User user = new User();
        user.setEmail("test@example.com");

        when(userRepository.existsByEmail("test@example.com")).thenReturn(true);

        DuplicateResourceException exception = assertThrows(DuplicateResourceException.class, 
                () -> userService.createUser(user));

        assertEquals("Email test@example.com is already registered.", exception.getMessage());
    }

    @Test
    void getUserById_Success() {
        User user = new User();
        user.setUserId(1);
        user.setEmail("test@example.com");

        when(userRepository.findById(1)).thenReturn(Optional.of(user));

        User result = userService.getUserById(1);

        assertNotNull(result);
        assertEquals(1, result.getUserId());
        assertEquals("test@example.com", result.getEmail());
    }

    @Test
    void getUserById_NotFound() {
        when(userRepository.findById(1)).thenReturn(Optional.empty());

        ResourceNotFoundException exception = assertThrows(ResourceNotFoundException.class, 
                () -> userService.getUserById(1));

        assertEquals("User with ID 1 not found.", exception.getMessage());
    }

    @Test
    void getAllUsers_Success() {
        User user = new User();
        user.setUsername("testuser");
        user.setEmail("test@example.com");
        user.setRole(User.Role.PASSENGER);

        when(userRepository.findAll()).thenReturn(List.of(user));

        List<UserDTO> result = userService.getAllUsers();

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("testuser", result.get(0).getUsername());
        assertEquals("test@example.com", result.get(0).getEmail());
        assertEquals("USER", result.get(0).getRole());
    }

    @Test
    void updateUser_Success() {
        User user = new User();
        user.setUserId(1);
        user.setEmail("old@example.com");

        User updatedUser = new User();
        updatedUser.setEmail("new@example.com");
        updatedUser.setUsername("newuser");
        updatedUser.setRole(User.Role.ADMIN);

        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(userRepository.existsByEmail("new@example.com")).thenReturn(false);
        when(userRepository.save(user)).thenReturn(user);

        User result = userService.updateUser(1, updatedUser);

        assertNotNull(result);
        assertEquals("new@example.com", result.getEmail());
        assertEquals("newuser", result.getUsername());
        assertEquals(User.Role.ADMIN, result.getRole());
        verify(userRepository).save(user);
    }

    @Test
    void updateUser_DuplicateEmail() {
        User user = new User();
        user.setUserId(1);
        user.setEmail("old@example.com");

        User updatedUser = new User();
        updatedUser.setEmail("duplicate@example.com");

        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(userRepository.existsByEmail("duplicate@example.com")).thenReturn(true);

        DuplicateResourceException exception = assertThrows(DuplicateResourceException.class, 
                () -> userService.updateUser(1, updatedUser));

        assertEquals("Email duplicate@example.com is already registered.", exception.getMessage());
    }

    @Test
    void deleteUser_Success() {
        User user = new User();
        user.setUserId(1);

        when(userRepository.findById(1)).thenReturn(Optional.of(user));

        userService.deleteUser(1);

        verify(userRepository).deleteById(1);
    }

    @Test
    void deleteUser_NotFound() {
        when(userRepository.findById(1)).thenReturn(Optional.empty());

        ResourceNotFoundException exception = assertThrows(ResourceNotFoundException.class, 
                () -> userService.deleteUser(1));

        assertEquals("User with ID 1 not found.", exception.getMessage());
    }

    @Test
    void authenticateUser_Success() {
        User user = new User();
        user.setEmail("test@example.com");

        when(authenticationService.authenticateUser("test@example.com", "password"))
                .thenReturn(user);

        User result = userService.authenticateUser("test@example.com", "password");

        assertNotNull(result);
        assertEquals("test@example.com", result.getEmail());
    }
}