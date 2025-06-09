package controllers.product;

import models.Product;
import models.User;
import services.ProductService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;

@WebServlet(name = "ProductServlet", urlPatterns = {"/product/manage"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class ProductServlet extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.isEmpty()) {
                // Show product management page
                request.setAttribute("products", productService.getProductsByOwner(user.getUserId()));
                request.getRequestDispatcher("/product/manageProducts.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                // Show edit form
                int productId = Integer.parseInt(request.getParameter("id"));
                Product product = productService.getProductById(productId);
                
                if (product.getOwnerId() != user.getUserId()) {
                    request.setAttribute("error", "You don't have permission to edit this product");
                    response.sendRedirect(request.getContextPath() + "/product/manage");
                    return;
                }
                
                request.setAttribute("product", product);
                request.getRequestDispatcher("/product/editProduct.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                // Handle delete
                int productId = Integer.parseInt(request.getParameter("id"));
                boolean deleted = productService.deleteProduct(productId, user);
                
                if (deleted) {
                    session.setAttribute("message", "Product deleted successfully");
                } else {
                    session.setAttribute("error", "Failed to delete product");
                }
                response.sendRedirect(request.getContextPath() + "/product/manage");
            } else if ("new".equals(action)) {
                // Show create form
                request.getRequestDispatcher("/product/addProduct.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/product/manageProducts.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        
        try {
            if ("create".equals(action)) {
                // Create new product
                Product product = new Product();
                
                Part imagePart = request.getPart("image");
                
                // Handle image upload as BLOB
                if (imagePart != null && imagePart.getSize() > 0) {
                    try (InputStream imageContent = imagePart.getInputStream()) {
                        byte[] imageData = imageContent.readAllBytes();
                        product.setImageData(imageData);
                        product.setImageType(imagePart.getContentType());
                        product.setImageSize((int) imagePart.getSize());
                    }
                }
                
                product.setName(request.getParameter("name"));
                product.setDescription(request.getParameter("description"));
                
                // Handle price parsing
                String priceParam = request.getParameter("price");
                if (priceParam != null && !priceParam.trim().isEmpty()) {
                    try {
                        double price = Double.parseDouble(priceParam.trim());
                        product.setPrice(price);
                    } catch (NumberFormatException e) {
                        session.setAttribute("error", "Invalid price format");
                        response.sendRedirect(request.getContextPath() + "/product/manage?action=new");
                        return;
                    }
                } else {
                    session.setAttribute("error", "Price is required");
                    response.sendRedirect(request.getContextPath() + "/product/manage?action=new");
                    return;
                }

                product.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                product.setOwnerId(user.getUserId());
                
                int productId = productService.createProduct(product, user);
                
                session.setAttribute("message", "Product created successfully with ID: " + productId);
                response.sendRedirect(request.getContextPath() + "/product/manage");
                
            } else if ("update".equals(action)) {
                // Update existing product
                Product product = new Product();
                product.setProductId(Integer.parseInt(request.getParameter("productId")));
                product.setName(request.getParameter("name"));
                product.setDescription(request.getParameter("description"));
                product.setPrice(Double.parseDouble(request.getParameter("price")));
                product.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                product.setOwnerId(user.getUserId());
                
                // Handle image update
                Part imagePart = request.getPart("image");
                if (imagePart != null && imagePart.getSize() > 0) {
                    try (InputStream imageContent = imagePart.getInputStream()) {
                        byte[] imageData = imageContent.readAllBytes();
                        product.setImageData(imageData);
                        product.setImageType(imagePart.getContentType());
                        product.setImageSize((int) imagePart.getSize());
                    }
                } else {
                    // Keep existing image if no new image was uploaded
                    Product existingProduct = productService.getProductById(product.getProductId());
                    if (existingProduct != null) {
                        product.setImageData(existingProduct.getImageData());
                        product.setImageType(existingProduct.getImageType());
                        product.setImageSize(existingProduct.getImageSize());
                    }
                }
                
                boolean updated = productService.updateProduct(product, user);
                if (updated) {
                    session.setAttribute("message", "Product updated successfully");
                } else {
                    session.setAttribute("error", "Failed to update product");
                }
                response.sendRedirect(request.getContextPath() + "/product/manage");
            }
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/product/manage");
        }
    }
}