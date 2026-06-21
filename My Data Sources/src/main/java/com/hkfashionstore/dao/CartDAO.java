package com.hkfashionstore.dao;

import java.util.List;
import com.hkfashionstore.model.CartItem;

public interface CartDAO {
    // 1. Find the user's cart (or create one if they are new)
    int getOrCreateCartId(int userId);
    
    // 2. Add a product (or increase quantity if it's already in there)
    boolean addToCart(int cartId, int productId, int quantity);
    
    // 3. Update quantity (+ or - button)
    boolean updateQuantity(int cartItemId, int quantity);
    
    // 4. Remove item completely (Trash can button)
    boolean removeCartItem(int cartItemId);
    
    // 5. Get all items to display on the Cart Page
    List<CartItem> getCartItems(int cartId);
}