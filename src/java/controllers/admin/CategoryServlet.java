package controllers.admin;

import dao.CategoryDAO;
import exceptions.DAOException;
import models.Category;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CategoryServlet", value = "/admin/categories")
public class CategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        categoryDAO = new CategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.isEmpty()) {
                listCategories(request, response);
            } else {
                switch (action) {
                    case "new":
                        showNewForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteCategory(request, response);
                        break;
                    default:
                        listCategories(request, response);
                        break;
                }
            }
        } catch (DAOException e) {
            throw new ServletException("Database error occurred", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("create".equals(action)) {
                createCategory(request, response);
            } else if ("update".equals(action)) {
                updateCategory(request, response);
            } else {
                listCategories(request, response);
            }
        } catch (DAOException e) {
            throw new ServletException("Database error occurred", e);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, DAOException {
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.getRequestDispatcher("/admin/categories/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/categories/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, DAOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Category category = categoryDAO.getCategoryById(id);
        request.setAttribute("category", category);
        request.getRequestDispatcher("/admin/categories/form.jsp").forward(request, response);
    }

    private void createCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, DAOException {
        Category category = new Category();
        category.setName(request.getParameter("name"));
        category.setDescription(request.getParameter("description"));
        
        categoryDAO.createCategory(category);
        response.sendRedirect(request.getContextPath() + "/admin/categories?success=created");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, DAOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Category category = new Category();
        category.setCategoryId(id);
        category.setName(request.getParameter("name"));
        category.setDescription(request.getParameter("description"));
        
        categoryDAO.updateCategory(category);
        response.sendRedirect(request.getContextPath() + "/admin/categories?success=updated");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, DAOException {
        int id = Integer.parseInt(request.getParameter("id"));
        categoryDAO.deleteCategory(id);
        response.sendRedirect(request.getContextPath() + "/admin/categories?success=deleted");
    }
}