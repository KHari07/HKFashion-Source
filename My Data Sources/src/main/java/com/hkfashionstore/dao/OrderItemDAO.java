package com.hkfashionstore.dao;

import com.hkfashionstore.model.OrderItem;
import java.util.List;

public interface OrderItemDAO {
    boolean addOrderItems(List<OrderItem> orderItems);
    List<OrderItem> getOrderItemsByOrderId(int orderId);
}