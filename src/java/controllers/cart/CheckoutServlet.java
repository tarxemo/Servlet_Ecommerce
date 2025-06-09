package controllers.cart;

import services.CartService;
import services.OrderService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import models.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private CartService cartService = new CartService();
    private OrderService orderService = new OrderService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();


        User user = (User) session.getAttribute("user");
        Integer userId = user.getUserId();
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.setAttribute("cart", cartService.getUserCart(userId));
        request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();


        User user = (User) session.getAttribute("user");
        Integer userId = user.getUserId();
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String paymentMethod = request.getParameter("paymentMethod");
        String shippingAddress = request.getParameter("shippingAddress");
        
        try {
            int orderId = orderService.createOrderFromCart(userId, paymentMethod, shippingAddress);
            response.sendRedirect(request.getContextPath() + "/order/confirmation?id=" + orderId);
        } catch (Exception e) {
            request.setAttribute("error", "Checkout failed: " + e.getMessage());
            request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
        }
    }
}