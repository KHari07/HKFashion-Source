package com.hkfashionstore.dao;

import com.hkfashionstore.model.User;

public interface UserDAO {
    boolean registerUser(User user);
    
    // NEW: Method to check login credentials
    User loginUser(String email, String password);
    boolean updateUserProfile(int userId, String newAddress, String newPassword);
}