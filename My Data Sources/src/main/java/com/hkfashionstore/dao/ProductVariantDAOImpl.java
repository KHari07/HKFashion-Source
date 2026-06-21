package com.hkfashionstore.dao;

import com.hkfashionstore.model.ProductVariant;
import com.hkfashionstore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAOImpl implements ProductVariantDAO {

    @Override
    public boolean addVariant(ProductVariant variant) {
        String sql = "INSERT INTO Product_Variants (product_id, size, color, stock_quantity) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, variant.getProductId());
            pstmt.setString(2, variant.getSize());
            pstmt.setString(3, variant.getColor());
            pstmt.setInt(4, variant.getStockQuantity());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public ProductVariant getVariantById(int variantId) {
        String sql = "SELECT * FROM Product_Variants WHERE variant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, variantId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return new ProductVariant(
                    rs.getInt("variant_id"),
                    rs.getInt("product_id"),
                    rs.getString("size"),
                    rs.getString("color"),
                    rs.getInt("stock_quantity")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> variants = new ArrayList<>();
        String sql = "SELECT * FROM Product_Variants WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                variants.add(new ProductVariant(
                    rs.getInt("variant_id"),
                    rs.getInt("product_id"),
                    rs.getString("size"),
                    rs.getString("color"),
                    rs.getInt("stock_quantity")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }

    @Override
    public boolean updateVariantStock(int variantId, int newStockQuantity) {
        String sql = "UPDATE Product_Variants SET stock_quantity = ? WHERE variant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, newStockQuantity);
            pstmt.setInt(2, variantId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteVariant(int variantId) {
        String sql = "DELETE FROM Product_Variants WHERE variant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, variantId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}