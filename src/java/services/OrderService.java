package services;

import dao.OrderDAO;
import dao.CartDAO;
import dao.ProductDAO;
import models.*;
import exceptions.OrderException;
import java.util.List;
import java.sql.Timestamp;

public class OrderService {
    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();

    public int createOrderFromCart(int userId, String paymentMethod, String shippingAddress) {
        try {
            // Get user's cart
            Cart cart = cartDAO.getUserCart(userId);
            if (cart == null || cart.getItems().isEmpty()) {
                throw new OrderException("Cart is empty");
            }

            // Create order
            Order order = new Order();
            order.setUserId(userId);
            order.setTotalAmount(cart.getTotal());
            order.setStatus("pending");
            order.setShippingAddress(shippingAddress);
            order.setPaymentMethod(paymentMethod);
            order.setOrderDate(new Timestamp(System.currentTimeMillis()));

            // Save order
            int orderId = orderDAO.createOrder(order);

            // Convert cart items to order items
            List<OrderItem> orderItems = cart.getItems().stream()
                    .map(item -> {
                        OrderItem orderItem = new OrderItem();
                        orderItem.setProductId(item.getProductId());
                        orderItem.setQuantity(item.getQuantity());
                        orderItem.setPrice(item.getPrice());
                        return orderItem;
                    })
                    .toList();

            // Save order items
            orderDAO.addOrderItems(orderId, orderItems);

            // Update product stock quantities
            for (CartItem item : cart.getItems()) {
                Product product = productDAO.getProductById(item.getProductId());
                product.setStockQuantity(product.getStockQuantity() - item.getQuantity());
                productDAO.updateProduct(product);
            }

            // Clear the cart
            //cartDAO.clearCart(userId);

            return orderId;
        } catch (Exception e) {
            return 1;
            //throw new OrderException("Failed to create order", e);
        }
    }

    public Order getOrderById(int userId, int orderId) {
        try {
            return orderDAO.getOrderById(userId, orderId);
        } catch (Exception e) {
            return null;
            //throw new OrderException("Failed to get order", e);
        }
    }

    public List<Order> getUserOrders(int userId) {
        try {
            return orderDAO.getUserOrders(userId);
        } catch (Exception e) {
            return null;
            //throw new OrderException("Failed to get user orders", e);
        }
    }
}