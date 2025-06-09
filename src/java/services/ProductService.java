package services;

import dao.ProductDAO;
import dao.CategoryDAO;
import models.User;
import models.Product;
import models.Category;
import exceptions.DAOException;
import java.util.List;

public class ProductService {
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    public List<Product> getAllProducts() throws DAOException {
        return productDAO.getAllProducts();
    }
    
    public List<Product> getProductsByCategory(int categoryId) throws DAOException {
        return productDAO.getProductsByCategory(categoryId);
    }
    
    public List<Product> getProductsByOwner(int ownerId) throws DAOException {
        return productDAO.getProductsByOwner(ownerId);
    }
    
    public Product getProductById(int productId) throws DAOException {
        return productDAO.getProductById(productId);
    }
    
    public int createProduct(Product product, User owner) throws DAOException {
        if (owner == null) {
            throw new DAOException("Product must have an owner");
        }
        product.setOwnerId(owner.getUserId());
        return productDAO.createProduct(product);
    }
    
    public boolean updateProduct(Product product, User requester) throws DAOException {
        Product existingProduct = productDAO.getProductById(product.getProductId());
        if (existingProduct == null) {
            throw new DAOException("Product not found");
        }
        
        if (existingProduct.getOwnerId() != requester.getUserId()) {
            throw new DAOException("You don't have permission to update this product");
        }
        
        return productDAO.updateProduct(product);
    }
    
    public boolean deleteProduct(int productId, User requester) throws DAOException {
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            throw new DAOException("Product not found");
        }
        
        if (product.getOwnerId() != requester.getUserId()) {
            throw new DAOException("You don't have permission to delete this product");
        }
        
        return productDAO.deleteProduct(productId, requester.getUserId());
    }
}