package com.hkfashionstore.dao;

import com.hkfashionstore.model.Order;
import java.util.List;

public interface OrderDAO {
    int createOrder(Order order); // Returns the generated order ID
    Order getOrderById(int orderId);
    List<Order> getOrdersByUserId(int userId);
    boolean updateOrderStatus(int orderId, String status);
    List<Order> getAllOrders();
    int getTotalOrderCount();
    double getTotalRevenue();
}