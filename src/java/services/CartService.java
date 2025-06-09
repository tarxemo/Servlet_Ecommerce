package services;

import dao.CartDAO;
import dao.ProductDAO;
import models.Cart;
import models.CartItem;
import exceptions.CartException;
import java.util.List;

public class CartService {
    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();
    public Cart getUserCart(int userId) {
        try {
            return cartDAO.getUserCart(userId);
        } catch (Exception e) {
            // handle gracefully, maybe return null or a default cart
            e.printStackTrace();
            return null; // or new Cart();
        }
    }


    public void addToCart(int userId, int productId, int quantity) {
        try {
            // Verify product exists and has sufficient stock
            if (productDAO.getProductById(productId) == null) {
                throw new CartException("Product not found");
            }
            
            cartDAO.addToCart(userId, productId, quantity);
        } catch (Exception e) {
            //throw new CartException("Failed to add to cart", e);
        }
    }

    public void removeFromCart(int userId, int productId) {
        try {
            cartDAO.removeFromCart(userId, productId);
        } catch (Exception e) {
            //throw new CartException("Failed to remove from cart", e);
        }
    }

    public void updateCartItem(int userId, int productId, int quantity) {
        try {
            if (quantity <= 0) {
                removeFromCart(userId, productId);
            } else {
                boolean success = cartDAO.updateCartItem(userId, productId, quantity);
            }
        } catch (Exception e) {
            //throw new CartException("Failed to update cart item", e);
        }
    }

    public void clearCart(int userId) {
        try {
            Cart cart = getUserCart(userId);
            for (CartItem item : cart.getItems()) {
                removeFromCart(userId, item.getProductId());
            }
        } catch (Exception e) {
            //throw new CartException("Failed to clear cart", e);
        }
    }
}