package dao;

import config.DBConnection;
import exceptions.DAOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Product;

public class ProductDAO {
 
    public Product getProductById(int productId) throws DAOException {
        String sql = "SELECT * FROM products WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractProductFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error retrieving product", e);
        }
        return null;
    }

    public List<Product> getAllProducts() throws DAOException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            throw new DAOException("Error retrieving all products", e);
        }
        return products;
    }

    public List<Product> getProductsByCategory(int categoryId) throws DAOException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(extractProductFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error retrieving products by category", e);
        }
        return products;
    }

    public List<Product> getProductsByOwner(int ownerId) throws DAOException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE owner_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, ownerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(extractProductFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error retrieving products by owner" + ownerId, e);
        }
        return products;
    }

    public int createProduct(Product product) throws DAOException {
        String sql = "INSERT INTO products (name, description, price, stock_quantity, " +
                    "category_id, image_data, image_type, image_size, owner_id) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getStockQuantity());
            stmt.setInt(5, product.getCategoryId());
            
            // Handle image data (BLOB)
            if (product.getImageData() != null) {
                stmt.setBytes(6, product.getImageData());
                stmt.setString(7, product.getImageType());
                stmt.setInt(8, product.getImageSize());
            } else {
                stmt.setNull(6, Types.BLOB);
                stmt.setNull(7, Types.VARCHAR);
                stmt.setNull(8, Types.INTEGER);
            }
            
            stmt.setInt(9, product.getOwnerId());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new DAOException("Creating product failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new DAOException("Creating product failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error creating product", e);
        }
    }

    public boolean updateProduct(Product product) throws DAOException {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, stock_quantity = ?, " +
                    "category_id = ?, image_data = ?, image_type = ?, image_size = ?, updated_at = CURRENT_TIMESTAMP " +
                    "WHERE product_id = ? AND owner_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getStockQuantity());
            stmt.setInt(5, product.getCategoryId());
            
            // Handle image data (BLOB)
            if (product.getImageData() != null) {
                stmt.setBytes(6, product.getImageData());
                stmt.setString(7, product.getImageType());
                stmt.setInt(8, product.getImageSize());
            } else {
                stmt.setNull(6, Types.BLOB);
                stmt.setNull(7, Types.VARCHAR);
                stmt.setNull(8, Types.INTEGER);
            }
            
            stmt.setInt(9, product.getProductId());
            stmt.setInt(10, product.getOwnerId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new DAOException("Error updating product", e);
        }
    }

    public boolean deleteProduct(int productId, int ownerId) throws DAOException {
        String sql = "DELETE FROM products WHERE product_id = ? AND owner_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            stmt.setInt(2, ownerId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new DAOException("Error deleting product", e);
        }
    }

    private Product extractProductFromResultSet(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("product_id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setStockQuantity(rs.getInt("stock_quantity"));
        product.setCategoryId(rs.getInt("category_id"));
        
        // Handle BLOB image data
        product.setImageData(rs.getBytes("image_data"));
        product.setImageType(rs.getString("image_type"));
        product.setImageSize(rs.getInt("image_size"));
        
        product.setOwnerId(rs.getInt("owner_id"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setUpdatedAt(rs.getTimestamp("updated_at"));

        return product;
    }
}