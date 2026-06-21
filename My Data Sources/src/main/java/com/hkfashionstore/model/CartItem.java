package com.hkfashionstore.model;

public class CartItem {
    private int cartItemId;
    private int cartId;
    private int productId;
    private int quantity;
    
    // Extra fields joined from the Products table to make our JSP easy!
    private String productName;
    private double basePrice;
    private String imageUrl;

    public CartItem() {}

    // Getters and Setters
    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }

    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public double getBasePrice() { return basePrice; }
    public void setBasePrice(double basePrice) { this.basePrice = basePrice; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    // A helpful method to automatically calculate the total for this specific item row
    public double getTotalPrice() {
        return this.basePrice * this.quantity;
    }
}