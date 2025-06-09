package controllers.cart;

import services.CartService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import models.User;
import java.net.URLEncoder;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartService cartService = new CartService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        User user = (User) session.getAttribute("user");
        Integer userId = user.getUserId();
        
        if (userId == null) {
            String errorMessage = "login first to add items to cart";
            response.sendRedirect(request.getContextPath() + "/login?error=" + URLEncoder.encode(errorMessage, "UTF-8"));
            return;
        }

        
        request.setAttribute("cart", cartService.getUserCart(userId));
        request.getRequestDispatcher("/cart/viewCart.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        User user = (User) session.getAttribute("user");
        Integer userId = (user != null) ? user.getUserId() : null;
        
        String action = request.getParameter("action");
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if ("add".equals(action)) {
                cartService.addToCart(userId, productId, quantity);
            } else if ("remove".equals(action)) {
                cartService.removeFromCart(userId, productId);
            } else if ("update".equals(action)) {
                cartService.updateCartItem(userId, productId, quantity);
            }
            
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
} 