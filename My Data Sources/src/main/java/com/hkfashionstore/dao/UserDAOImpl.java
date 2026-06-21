package com.hkfashionstore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.hkfashionstore.model.User;
import com.hkfashionstore.util.DBConnection;

public class UserDAOImpl implements UserDAO {

    @Override
    public boolean registerUser(User user) {
        // Table name 'users' is perfectly lowercase!
        String query = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); 
            ps.setString(4, user.getRole());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // NEW: The Login Logic
    @Override
    public User loginUser(String email, String password) {
        // Table name 'users' is perfectly lowercase!
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // We found a match! Build the User object to send back
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if email/password are wrong
    }

    @Override
    public boolean updateUserProfile(int userId, String newAddress, String newPassword) {
        // If they provided a new password, update both. Otherwise, just update the address.
        boolean updatePass = (newPassword != null && !newPassword.trim().isEmpty());
        // Table name 'users' is perfectly lowercase!
        String sql = updatePass ? "UPDATE users SET address = ?, password = ? WHERE user_id = ?" 
                                : "UPDATE users SET address = ? WHERE user_id = ?";
        
        // Cleaned up the long java.sql.Connection names here!
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newAddress);
            
            if (updatePass) {
                pstmt.setString(2, newPassword);
                pstmt.setInt(3, userId);
            } else {
                pstmt.setInt(2, userId);
            }
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}