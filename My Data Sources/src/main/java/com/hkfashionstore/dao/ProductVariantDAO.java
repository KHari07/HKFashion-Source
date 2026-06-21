package com.hkfashionstore.dao;

import com.hkfashionstore.model.ProductVariant;
import java.util.List;

public interface ProductVariantDAO {
    boolean addVariant(ProductVariant variant);
    ProductVariant getVariantById(int variantId);
    List<ProductVariant> getVariantsByProductId(int productId);
    boolean updateVariantStock(int variantId, int newStockQuantity);
    boolean deleteVariant(int variantId);
}