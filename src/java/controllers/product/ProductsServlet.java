package controllers.product;

import models.Product;
import exceptions.DAOException;
import services.ProductService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/products/*")
public class ProductsServlet extends HttpServlet {
    private ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/product/list");
            return;
        }
        
        String[] parts = pathInfo.split("/");
        if (parts.length > 1) {
            try {
                int productId = Integer.parseInt(parts[1]);
                Product product = productService.getProductById(productId);  // This can throw DAOException
                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/product/productDetail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);  // Invalid number format
            } catch (DAOException e) {
                // Handle the DAOException gracefully
                e.printStackTrace();  // Optional: log the error
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
            }
        }
    }
}