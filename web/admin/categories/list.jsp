<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../includes/header.jsp">
    <jsp:param name="title" value="Manage Categories"/>
</jsp:include>
<jsp:include page="../../includes/navigation.jsp"/>

<main class="flex-grow container mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold">Manage Categories</h1>
        <a href="${pageContext.request.contextPath}/admin/categories?action=new" 
           class="bg-primary text-gray-900 px-4 py-2 rounded-md font-bold hover:bg-yellow-300 transition">
            <i class="fas fa-plus mr-2"></i> Add New Category
        </a>
    </div>

    <c:if test="${not empty param.success}">
        <div class="mb-6 p-4 bg-green-600 text-white rounded-md">
            <c:choose>
                <c:when test="${param.success == 'created'}">Category created successfully!</c:when>
                <c:when test="${param.success == 'updated'}">Category updated successfully!</c:when>
                <c:when test="${param.success == 'deleted'}">Category deleted successfully!</c:when>
            </c:choose>
        </div>
    </c:if>

    <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden">
        <table class="min-w-full divide-y divide-gray-700">
            <thead class="bg-gray-700">
                <tr>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">ID</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Name</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Description</th>
                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-400 uppercase tracking-wider">Actions</th>
                </tr>
            </thead>
            <tbody class="bg-gray-800 divide-y divide-gray-700">
                <c:forEach var="category" items="${categories}">
                    <tr class="hover:bg-gray-700 transition">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-300">${category.categoryId}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-300">${category.name}</td>
                        <td class="px-6 py-4 text-sm text-gray-400">${category.description}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                            <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${category.categoryId}" 
                               class="text-primary hover:text-yellow-300 mr-3">
                                <i class="fas fa-edit mr-1"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${category.categoryId}" 
                               class="text-red-500 hover:text-red-400" 
                               onclick="return confirm('Are you sure you want to delete this category?')">
                                <i class="fas fa-trash-alt mr-1"></i> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</main>

<jsp:include page="../../includes/footer.jsp"/>