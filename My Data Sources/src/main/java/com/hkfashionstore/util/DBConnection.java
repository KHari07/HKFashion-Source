package com.hkfashionstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    // Cloud Database Credentials (Aiven)
    private static final String DB_URL = "";
    private static final String DB_USER = ""; 
    private static final String DB_PASSWORD = ""; // <-- PASTE YOUR ACTUAL AIVEN PASSWORD HERE

    /**
     * Establishes and returns a connection to the database.
     */
    public static Connection getConnection() {
        Connection connection = null;
        
        try {
            // 1. Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 2. Establish the Connection
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Successfully connected to the HK Fashion Store Cloud database!");
            
        } catch (ClassNotFoundException e) {
            System.err.println("Critical Error: MySQL JDBC Driver not found. Ensure Maven has downloaded the dependencies.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Database Connection Failed. Please verify your Aiven password and ensure the cloud server is running.");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("An unexpected error occurred during database connection.");
            e.printStackTrace();
        }
        
        return connection;
    }

    // --- MAIN METHOD FOR QUICK TESTING ---
    public static void main(String[] args) {
        System.out.println("Testing Cloud Database Connection...");
        Connection conn = DBConnection.getConnection();
        
        if (conn != null) {
            try {
                conn.close(); // Close it cleanly after testing
                System.out.println("Connection closed successfully after test.");
            } catch (SQLException e) {
                System.err.println("Error closing the connection.");
                e.printStackTrace();
            }
        } else {
            System.err.println("Test failed. Connection object is null.");
        }
    }
}