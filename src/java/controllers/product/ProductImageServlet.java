package controllers.product;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Product;
import services.ProductService;
import exceptions.DAOException;

@WebServlet("/product/image")
public class ProductImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            ProductService productService = new ProductService();
            
            Product product = productService.getProductById(productId);
            
            if (product != null && product.getImageData() != null) {
                response.setContentType(product.getImageType());
                response.setContentLength(product.getImageSize());
                response.getOutputStream().write(product.getImageData());
            } else {
                // Return a default image or 404 if no image exists
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
        } catch (DAOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving product image");
        }
    }
}