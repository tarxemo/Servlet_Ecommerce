package controllers.auth;

import services.AuthService;
import exceptions.AuthException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AuthService authService = new AuthService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            HttpSession session = request.getSession();
            if (authService.authenticateUser(username, password)) {
                session.setAttribute("user", authService.getUserByUsername(username));
                response.sendRedirect("product/list");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            }
        } catch (AuthException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
    }
}