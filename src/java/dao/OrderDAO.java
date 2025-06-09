package dao;

import models.Order;
import models.OrderItem;
import exceptions.DAOException;
import config.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection connection;

    public OrderDAO() {
        this.connection = DBConnection.getConnection();
    }

    public int createOrder(Order order) throws DAOException {
        String sql = "INSERT INTO orders (user_id, total_amount, status, shipping_address, payment_method) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getUserId());
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setString(3, order.getStatus());
            stmt.setString(4, order.getShippingAddress());
            stmt.setString(5, order.getPaymentMethod());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            
            throw new DAOException("Failed to create order, no ID obtained");
        } catch (SQLException e) {
            throw new DAOException("Error creating order", e);
        }
    }

    public void addOrderItems(int orderId, List<OrderItem> items) throws DAOException {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (OrderItem item : items) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, item.getProductId());
                stmt.setInt(3, item.getQuantity());
                stmt.setDouble(4, item.getPrice());
                stmt.addBatch();
            }
            
            stmt.executeBatch();
        } catch (SQLException e) {
            throw new DAOException("Error adding order items", e);
        }
    }

    public Order getOrderById(int userId, int orderId) throws DAOException {
        String orderSql = "SELECT * FROM orders WHERE order_id = ? AND user_id = ?";
        String itemsSql = "SELECT oi.*, p.name FROM order_items oi " +
                          "JOIN products p ON oi.product_id = p.product_id " +
                          "WHERE oi.order_id = ?";
        
        Order order = null;
        
        try (PreparedStatement orderStmt = connection.prepareStatement(orderSql)) {
            orderStmt.setInt(1, orderId);
            orderStmt.setInt(2, userId);
            
            try (ResultSet rs = orderStmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    
                    // Get order items
                    try (PreparedStatement itemsStmt = connection.prepareStatement(itemsSql)) {
                        itemsStmt.setInt(1, orderId);
                        
                        try (ResultSet itemsRs = itemsStmt.executeQuery()) {
                            List<OrderItem> items = new ArrayList<>();
                            while (itemsRs.next()) {
                                OrderItem item = new OrderItem();
                                item.setOrderItemId(itemsRs.getInt("order_item_id"));
                                item.setProductId(itemsRs.getInt("product_id"));
                                item.setProductName(itemsRs.getString("name"));
                                item.setQuantity(itemsRs.getInt("quantity"));
                                item.setPrice(itemsRs.getDouble("price"));
                                items.add(item);
                            }
                            order.setItems(items);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting order by ID", e);
        }
        
        return order;
    }

    public List<Order> getUserOrders(int userId) throws DAOException {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting user orders", e);
        }
        
        return orders;
    }
}