package com.hkfashionstore.dao;

import com.hkfashionstore.model.Product;
import java.util.List;

public interface ProductDAO {
    boolean addProduct(Product product);
    Product getProductById(int productId);
    List<Product> getAllProducts();
    List<Product> getProductsByCategoryId(int categoryId);
    boolean updateProduct(Product product);
    boolean deleteProduct(int productId);
    int getTotalProductCount();
}