package controllers.product;

import services.ProductService;
import javax.servlet.*;
import exceptions.DAOException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/product/list")
public class ProductListServlet extends HttpServlet {
    private ProductService productService = new ProductService();

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        request.setAttribute("products", productService.getAllProducts());
        request.getRequestDispatcher("/product/listProducts.jsp").forward(request, response);
    } catch (DAOException e) {
        e.printStackTrace(); // Optional: log error
        request.setAttribute("error", "Failed to load products.");
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}

}