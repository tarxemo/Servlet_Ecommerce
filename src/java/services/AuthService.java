package services;

import dao.UserDAO;
import models.User;
import exceptions.AuthException;
import utils.AuthUtil;
import java.security.NoSuchAlgorithmException;

public class AuthService {
    private UserDAO userDAO = new UserDAO();

    public boolean authenticateUser(String username, String password) throws AuthException {
        try {
            User user = userDAO.getUserByUsername(username);
            if (user != null) {
                String hashedPassword = AuthUtil.hashPassword(password);
                return hashedPassword.equals(user.getPassword());
            }
            return false;
        } catch (Exception e) {
            throw new AuthException("Authentication failed", e);
        }
    }

    public void registerUser(User user) throws AuthException {
        try {
            // Check if username or email already exists
            if (userDAO.getUserByUsername(user.getUsername()) != null) {
                throw new AuthException("Username already exists");
            }
            
            // Hash password before storing
            user.setPassword(AuthUtil.hashPassword(user.getPassword()));
            
            // Save user
            userDAO.addUser(user);
        } catch (NoSuchAlgorithmException e) {
            throw new AuthException("Password hashing failed", e);
        } catch (Exception e) {
            throw new AuthException("Registration failed", e);
        }
    }

    public User getUserByUsername(String username) throws AuthException {
        try {
            return userDAO.getUserByUsername(username);
        } catch (Exception e) {
            throw new AuthException("Failed to get user", e);
        }
    }
}