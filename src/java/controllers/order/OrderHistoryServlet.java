package controllers.order;

import services.OrderService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import models.User;

@WebServlet("/order/history")
public class OrderHistoryServlet extends HttpServlet {
    private OrderService orderService = new OrderService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        
        User user = (User) session.getAttribute("user");
        Integer userId = user.getUserId();
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.setAttribute("orders", orderService.getUserOrders(userId));
        request.getRequestDispatcher("/order/orderHistory.jsp").forward(request, response);
    }
}