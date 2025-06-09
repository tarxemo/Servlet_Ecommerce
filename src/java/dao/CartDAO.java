package dao;

import models.Cart;
import models.CartItem;
import config.DBConnection;
import exceptions.DAOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    private Connection connection;

    public CartDAO() {
        this.connection = DBConnection.getConnection();
    }

    public Cart getUserCart(int userId) throws DAOException {
        String sql = "SELECT c.cart_id, ci.product_id, p.name, p.price, ci.quantity " +
                     "FROM carts c " +
                     "LEFT JOIN cart_items ci ON c.cart_id = ci.cart_id " +
                     "LEFT JOIN products p ON ci.product_id = p.product_id " +
                     "WHERE c.user_id = ?";
        
        Cart cart = new Cart();
        cart.setUserId(userId);
        List<CartItem> items = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    if (cart.getCartId() == 0) {
                        cart.setCartId(rs.getInt("cart_id"));
                    }
                    
                    if (rs.getInt("product_id") != 0) {
                        CartItem item = new CartItem();
                        item.setProductId(rs.getInt("product_id"));
                        item.setProductName(rs.getString("name"));
                        item.setPrice(rs.getDouble("price"));
                        item.setQuantity(rs.getInt("quantity"));
                        items.add(item);
                    }
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting user cart", e);
        }
        
        cart.setItems(items);
        return cart;
    }

    public void addToCart(int userId, int productId, int quantity) throws DAOException {
        try {
            // Check if user has a cart
            int cartId = getOrCreateCartId(userId);
            
            // Check if product already in cart
            String checkSql = "SELECT quantity FROM cart_items WHERE cart_id = ? AND product_id = ?";
            int existingQuantity = 0;
            
            try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
                checkStmt.setInt(1, cartId);
                checkStmt.setInt(2, productId);
                
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        existingQuantity = rs.getInt("quantity");
                    }
                }
            }
            
            if (existingQuantity > 0) {
                // Update quantity
                String updateSql = "UPDATE cart_items SET quantity = ? WHERE cart_id = ? AND product_id = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, existingQuantity + quantity);
                    updateStmt.setInt(2, cartId);
                    updateStmt.setInt(3, productId);
                    updateStmt.executeUpdate();
                }
            } else {
                // Add new item
                String insertSql = "INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, cartId);
                    insertStmt.setInt(2, productId);
                    insertStmt.setInt(3, quantity);
                    insertStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error adding to cart", e);
        }
    }

    public void removeFromCart(int userId, int productId) throws DAOException {
        String sql = "DELETE ci FROM cart_items ci " +
                     "JOIN carts c ON ci.cart_id = c.cart_id " +
                     "WHERE c.user_id = ? AND ci.product_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error removing from cart", e);
        }
    }

    public boolean updateCartItem(int userId, int productId, int quantity) throws DAOException {
        if (quantity <= 0) {
            throw new DAOException("Quantity must be positive");
        }

        String sql = "UPDATE cart_items ci " +
                     "JOIN carts c ON ci.cart_id = c.cart_id " +
                     "SET ci.quantity = ? " +
                     "WHERE c.user_id = ? AND ci.product_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, userId);
            stmt.setInt(3, productId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            throw new DAOException("Error updating cart item", e);
        }
    }

    private int getOrCreateCartId(int userId) throws SQLException {
        String checkSql = "SELECT cart_id FROM carts WHERE user_id = ?";
        int cartId = 0;
        
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    cartId = rs.getInt("cart_id");
                }
            }
        }
        
        if (cartId == 0) {
            String insertSql = "INSERT INTO carts (user_id) VALUES (?)";
            try (PreparedStatement insertStmt = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                insertStmt.setInt(1, userId);
                insertStmt.executeUpdate();
                
                try (ResultSet rs = insertStmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        cartId = rs.getInt(1);
                    }
                }
            }
        }
        
        return cartId;
    }
}