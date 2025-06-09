<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Products"/>
</jsp:include>
<jsp:include page="../includes/navigation.jsp"/>

<main class="flex-grow container mx-auto px-4 py-8">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8">
        <h1 class="text-3xl font-bold">Our Products</h1>
        
        <div class="mt-4 md:mt-0 flex items-center space-x-4">
            <div class="relative">
                <select class="bg-gray-800 border border-gray-700 text-white px-4 py-2 pr-8 rounded-md focus:outline-none focus:ring-2 focus:ring-primary appearance-none">
                    <option>All Categories</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}">${category.name}</option>
                    </c:forEach>
                </select>
                <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                    <i class="fas fa-chevron-down text-gray-400"></i>
                </div>
            </div>
            
            <div class="relative">
                <select class="bg-gray-800 border border-gray-700 text-white px-4 py-2 pr-8 rounded-md focus:outline-none focus:ring-2 focus:ring-primary appearance-none">
                    <option>Sort by: Featured</option>
                    <option>Price: Low to High</option>
                    <option>Price: High to Low</option>
                    <option>Newest Arrivals</option>
                </select>
                <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                    <i class="fas fa-chevron-down text-gray-400"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        <c:forEach var="product" items="${products}">
            <div class="bg-gray-800 rounded-lg overflow-hidden shadow-lg hover:shadow-xl transition transform hover:-translate-y-1">
                <div class="relative">
                    <a href="${pageContext.request.contextPath}/products/${product.productId}">
                        <!-- Display image from BLOB data using a servlet -->
                        <img src="${pageContext.request.contextPath}/product/image?id=${product.productId}" 
                             alt="${product.name}" 
                             class="w-full h-48 object-cover">
                    </a>
                    <c:if test="${product.stockQuantity == 0}">
                        <span class="absolute top-2 right-2 bg-red-600 text-white text-xs font-bold px-2 py-1 rounded">Out of Stock</span>
                    </c:if>
                </div>
                <div class="p-4">
                    <a href="${pageContext.request.contextPath}/products/${product.productId}" class="hover:text-primary transition">
                        <h3 class="text-lg font-semibold mb-1 truncate">${product.name}</h3>
                    </a>
                    <p class="text-gray-400 text-sm mb-3 line-clamp-2">${product.description}</p>
                    <div class="flex justify-between items-center">
                        <span class="text-primary font-bold">$${product.price}</span>
                        <c:choose>
                            <c:when test="${product.stockQuantity > 0}">
                                <form action="${pageContext.request.contextPath}/cart?action=add&productId=${product.productId}&quantity=1" method="post">
                                    <button type="submit" class="bg-primary text-gray-900 px-3 py-1 rounded text-sm font-medium hover:bg-yellow-300 transition">
                                        <i class="fas fa-cart-plus"></i> Add
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button class="bg-gray-600 text-gray-300 px-3 py-1 rounded text-sm font-medium cursor-not-allowed" disabled>
                                    <i class="fas fa-ban"></i> Unavailable
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <!-- Pagination -->
    <div class="mt-8 flex justify-center">
        <nav class="inline-flex rounded-md shadow">
            <a href="#" class="px-3 py-2 rounded-l-md bg-gray-800 text-gray-400 hover:bg-gray-700">
                <i class="fas fa-chevron-left"></i>
            </a>
            <a href="#" class="px-3 py-2 bg-gray-800 text-gray-400 hover:bg-gray-700">1</a>
            <a href="#" class="px-3 py-2 bg-gray-800 text-gray-400 hover:bg-gray-700">2</a>
            <a href="#" class="px-3 py-2 bg-gray-800 text-gray-400 hover:bg-gray-700">3</a>
            <a href="#" class="px-3 py-2 rounded-r-md bg-gray-800 text-gray-400 hover:bg-gray-700">
                <i class="fas fa-chevron-right"></i>
            </a>
        </nav>
    </div>
</main>

<jsp:include page="../includes/footer.jsp"/>