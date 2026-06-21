package com.hkfashionstore.util;

import com.hkfashionstore.dao.CategoryDAO;
import com.hkfashionstore.dao.CategoryDAOImpl;
import com.hkfashionstore.dao.ProductDAO;
import com.hkfashionstore.dao.ProductDAOImpl;
import com.hkfashionstore.model.Category;
import com.hkfashionstore.model.Product;

import java.util.List;

public class TestApp {

    public static void main(String[] args) {
        System.out.println("--- STARTING HK FASHION STORE DATABASE TEST ---\n");

        // 1. Test Fetching Categories
        System.out.println("1. Fetching All Categories:");
        CategoryDAO categoryDAO = new CategoryDAOImpl();
        List<Category> categories = categoryDAO.getAllCategories();
        
        if (categories.isEmpty()) {
            System.out.println("No categories found. Check your database!");
        } else {
            for (Category cat : categories) {
                System.out.println(" - ID: " + cat.getCategoryId() + " | Name: " + cat.getCategoryName());
            }
        }
        
        System.out.println("\n-------------------------------------------------\n");

        // 2. Test Fetching Products
        System.out.println("2. Fetching All Products:");
        ProductDAO productDAO = new ProductDAOImpl();
        List<Product> products = productDAO.getAllProducts();
        
        if (products.isEmpty()) {
            System.out.println("No products found. Check your database!");
        } else {
            for (Product prod : products) {
                System.out.println(" - " + prod.getName() + " | Price: $" + prod.getBasePrice());
            }
        }

        System.out.println("\n--- TEST COMPLETE ---");
    }
}