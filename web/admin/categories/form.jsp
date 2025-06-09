<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../includes/header.jsp">
    <jsp:param name="title" value="${category == null ? 'Add New Category' : 'Edit Category'}"/>
</jsp:include>
<jsp:include page="../../includes/navigation.jsp"/>

<main class="flex-grow container mx-auto px-4 py-8">
    <div class="max-w-2xl mx-auto bg-gray-800 rounded-lg shadow-lg p-8">
        <h1 class="text-2xl font-bold mb-6">
            <c:choose>
                <c:when test="${category == null}">Add New Category</c:when>
                <c:otherwise>Edit Category</c:otherwise>
            </c:choose>
        </h1>
        
        <form action="${pageContext.request.contextPath}/admin/categories" method="post">
            <c:if test="${category != null}">
                <input type="hidden" name="id" value="${category.categoryId}">
                <input type="hidden" name="action" value="update">
            </c:if>
            <c:if test="${category == null}">
                <input type="hidden" name="action" value="create">
            </c:if>
            
            <div class="mb-6">
                <label for="name" class="block text-sm font-medium text-gray-400 mb-2">Category Name</label>
                <input type="text" id="name" name="name" value="${category.name}" required
                    class="bg-gray-700 text-white px-4 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
            </div>
            
            <div class="mb-6">
                <label for="description" class="block text-sm font-medium text-gray-400 mb-2">Description</label>
                <textarea id="description" name="description" rows="4"
                    class="bg-gray-700 text-white px-4 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">${category.description}</textarea>
            </div>
            
            <div class="flex justify-end space-x-4">
                <a href="${pageContext.request.contextPath}/admin/categories" 
                   class="border border-gray-600 text-white px-4 py-2 rounded-md font-medium hover:bg-gray-700 transition">
                    Cancel
                </a>
                <button type="submit" 
                    class="bg-primary text-gray-900 px-6 py-2 rounded-md font-bold hover:bg-yellow-300 transition">
                    <c:choose>
                        <c:when test="${category == null}">Create Category</c:when>
                        <c:otherwise>Update Category</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>
    </div>
</main>

<jsp:include page="../../includes/footer.jsp"/>