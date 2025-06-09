<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Manage Products"/>
</jsp:include>
<jsp:include page="../includes/navigation.jsp"/>

<main class="container mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-bold text-white">Your Products</h1>
        <a href="${pageContext.request.contextPath}/product/manage?action=new" 
           class="bg-primary text-white px-4 py-2 rounded hover:bg-yellow-600 transition">
            Add New Product
        </a>
    </div>

    <c:if test="${not empty message}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
            ${message}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            ${error}
        </div>
    </c:if>

    <div class="overflow-x-auto">
        <table class="min-w-full bg-white rounded-lg overflow-hidden">
            <thead class="bg-gray-800 text-white">
                <tr>
                    <th class="py-3 px-4 text-left">ID</th>
                    <th class="py-3 px-4 text-left">Name</th>
                    <th class="py-3 px-4 text-left">Price</th>
                    <th class="py-3 px-4 text-left">Stock</th>
                    <th class="py-3 px-4 text-left">Actions</th>
                </tr>
            </thead>
            <tbody class="text-gray-700">
                <c:forEach var="product" items="${products}">
                    <tr class="border-b bg-gray-700 hover:bg-gray-600 text-white">
                        <td class="py-3 px-4">${product.productId}</td>
                        <td class="py-3 px-4">${product.name}</td>
                        <td class="py-3 px-4">$${product.price}</td>
                        <td class="py-3 px-4">${product.stockQuantity}</td>
                        <td class="py-3 px-4 flex space-x-2">
                            <a href="${pageContext.request.contextPath}/product/manage?action=edit&id=${product.productId}" 
                               class="text-blue-600 hover:text-blue-800">Edit</a>
                            <a href="${pageContext.request.contextPath}/product/manage?action=delete&id=${product.productId}" 
                               class="text-red-600 hover:text-red-800" 
                               onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</main>

<jsp:include page="../includes/footer.jsp"/>