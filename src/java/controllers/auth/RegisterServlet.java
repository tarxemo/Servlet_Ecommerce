package controllers.auth;

import models.User;
import services.AuthService;
import exceptions.AuthException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private AuthService authService = new AuthService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        
        try {
            authService.registerUser(user);
            request.setAttribute("success", "Registration successful! Please login.");
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        } catch (AuthException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
    }
}