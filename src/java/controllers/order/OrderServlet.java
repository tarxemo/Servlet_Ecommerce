package controllers.order;

import services.OrderService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import models.User;

@WebServlet("/order/confirmation")
public class OrderServlet extends HttpServlet {
    private OrderService orderService = new OrderService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        
        User user = (User) session.getAttribute("user");
        Integer userId = user.getUserId();
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("order", orderService.getOrderById(userId, orderId));
            request.getRequestDispatcher("/order/orderConfirmation.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}