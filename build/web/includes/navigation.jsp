<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="bg-gray-800 shadow-lg sticky top-0 z-50">
    <nav class="container mx-auto px-4 py-3 flex items-center justify-between">
        <!-- Logo/Brand -->
        <a href="${pageContext.request.contextPath}/" class="flex items-center space-x-2">
            <i class="fas fa-shopping-bag text-primary text-2xl"></i>
            <span class="text-xl font-bold text-primary">ShopNest</span>
        </a>

        <!-- Mobile menu button -->
        <div class="md:hidden">
            <button id="mobile-menu-button" class="text-gray-300 hover:text-primary focus:outline-none">
                <i class="fas fa-bars text-2xl"></i>
            </button>
        </div>

        <!-- Desktop Navigation -->
        <div class="hidden md:flex items-center space-x-6">
            <a href="${pageContext.request.contextPath}/" class="text-gray-300 hover:text-primary transition">Home</a>
            <a href="${pageContext.request.contextPath}/product/list" class="text-gray-300 hover:text-primary transition">Products</a>
            
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="relative group">
                        <button class="flex items-center space-x-1 text-gray-300 hover:text-primary transition">
                            <span>${sessionScope.user.username}</span>
                            <i class="fas fa-chevron-down text-xs"></i>
                        </button>
                        <div class="absolute right-0 mt-0 w-48 bg-gray-800 rounded-md shadow-lg py-1 hidden group-hover:block z-50">
                            <a href="${pageContext.request.contextPath}/order/history" class="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-700 hover:text-primary">Orders</a>
                            <a href="${pageContext.request.contextPath}/product/manage" class="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-700 hover:text-primary">My Products</a>
                            <c:if test="${not empty sessionScope.user}">
                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/admin/categories" class="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-700 hover:text-primary">Categories</a>
                                </c:if>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/logout" class="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-700 hover:text-primary">Logout</a>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/cart" class="relative text-gray-300 hover:text-primary transition">
                        <i class="fas fa-shopping-cart text-xl"></i>
                        <c:if test="${cartCount > 0}">
                            <span class="absolute -top-2 -right-2 bg-primary text-gray-900 text-xs font-bold rounded-full h-5 w-5 flex items-center justify-center">${cartCount}</span>
                        </c:if>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="text-gray-300 hover:text-primary transition">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="bg-primary text-gray-900 px-4 py-2 rounded-md font-medium hover:bg-yellow-300 transition">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <!-- Mobile Navigation -->
    <div id="mobile-menu" class="md:hidden hidden bg-gray-800 px-4 py-2">
        <a href="${pageContext.request.contextPath}/" class="block py-2 text-gray-300 hover:text-primary transition">Home</a>
        <a href="${pageContext.request.contextPath}/product/list" class="block py-2 text-gray-300 hover:text-primary transition">Products</a>
        
        <!-- Admin/Management Links (only visible to logged in users) -->
        <c:if test="${not empty sessionScope.user}">
            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/categories" class="block py-2 text-gray-300 hover:text-primary transition">Categories</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/product/manage" class="block py-2 text-gray-300 hover:text-primary transition">My Products</a>
        </c:if>
        
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/order/history" class="block py-2 text-gray-300 hover:text-primary transition">Orders</a>
                <a href="${pageContext.request.contextPath}/cart" class="block py-2 text-gray-300 hover:text-primary transition flex items-center">
                    Cart
                    <c:if test="${cartCount > 0}">
                        <span class="ml-2 bg-primary text-gray-900 text-xs font-bold rounded-full h-5 w-5 flex items-center justify-center">${cartCount}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="block py-2 text-gray-300 hover:text-primary transition">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="block py-2 text-gray-300 hover:text-primary transition">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="block py-2 text-primary font-medium transition">Register</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<script>
    // Mobile menu toggle
    document.getElementById('mobile-menu-button').addEventListener('click', function() {
        const menu = document.getElementById('mobile-menu');
        menu.classList.toggle('hidden');
    });
</script>