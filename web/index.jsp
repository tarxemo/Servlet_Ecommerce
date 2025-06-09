<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Home"/>
</jsp:include>
<jsp:include page="includes/navigation.jsp"/>

<main class="flex-grow">
    <!-- Hero Section -->
    <section class="relative bg-gray-800 py-20 h-[90vh]" style="background: url(${pageContext.request.contextPath}/assets/images/hero-bg.jpg); background-size: cover;">
        <div class="container mx-auto px-4 flex flex-col md:flex-row items-center">
            <div class="md:w-1/2 mb-10 md:mb-0">
                <h1 class="text-4xl md:text-5xl font-bold mb-4 text-black">Welcome to <span class="text-primary">ShopNest</span></h1>
                <p class="text-xl text-black mb-8">Discover amazing products at unbeatable prices. Quality you can trust, service you can rely on.</p>
                <div class="flex space-x-4">
                    <a href="${pageContext.request.contextPath}/product/list" class="bg-primary text-gray-900 px-6 py-3 rounded-md font-bold hover:bg-yellow-300 transition">Shop Now</a>
                    <a href="#" class="border border-primary text-primary px-6 py-3 rounded-md font-bold hover:bg-gray-700 transition">Learn More</a>
                </div>
            </div>
            <div class="md:w-1/2">
                <!--<img src="${pageContext.request.contextPath}/assets/images/hero-bg.jpg" alt="Shopping" class="rounded-lg shadow-2xl w-full max-w-md mx-auto">-->
            </div>
        </div>
        <div class="absolute bottom-0 left-0 right-0 h-16 bg-gradient-to-t from-gray-900 to-transparent"></div>
    </section>

    <!-- Featured Categories -->
    <section class="py-16 bg-gray-900">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold mb-12 text-center">Shop by Category</h2>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                <c:forEach var="category" items="${categories}">
                    <a href="${pageContext.request.contextPath}/product/list?category=${category.categoryId}" class="bg-gray-800 rounded-lg overflow-hidden shadow-lg hover:shadow-xl transition group">
                        <div class="h-40 bg-gray-700 flex items-center justify-center">
                            <i class="fas fa-boxes text-4xl text-primary group-hover:scale-110 transition"></i>
                        </div>
                        <div class="p-4">
                            <h3 class="text-lg font-semibold mb-1">${category.name}</h3>
                            <p class="text-gray-400 text-sm">${category.description}</p>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- Featured Products -->
    <section class="py-16 bg-gray-800">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center mb-12">
                <h2 class="text-3xl font-bold">Featured Products</h2>
                <a href="${pageContext.request.contextPath}/product/list" class="text-primary hover:underline">View All</a>
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                <c:forEach var="product" items="${featuredProducts}">
                    <div class="bg-gray-700 rounded-lg overflow-hidden shadow-lg hover:shadow-xl transition transform hover:-translate-y-1">
                        <div class="relative">
                            <img src="${product.imageUrl}" alt="${product.name}" class="w-full h-48 object-cover">
                            <c:if test="${product.stockQuantity == 0}">
                                <span class="absolute top-2 right-2 bg-red-600 text-white text-xs font-bold px-2 py-1 rounded">Out of Stock</span>
                            </c:if>
                        </div>
                        <div class="p-4">
                            <h3 class="text-lg font-semibold mb-1 truncate">${product.name}</h3>
                            <p class="text-gray-400 text-sm mb-3 line-clamp-2">${product.description}</p>
                            <div class="flex justify-between items-center">
                                <span class="text-primary font-bold">$${product.price}</span>
                                <c:choose>
                                    <c:when test="${product.stockQuantity > 0}">
                                        <a href="${pageContext.request.contextPath}/cart?action=add&productId=${product.productId}" class="bg-primary text-gray-900 px-3 py-1 rounded text-sm font-medium hover:bg-yellow-300 transition">
                                            <i class="fas fa-cart-plus"></i> Add
                                        </a>
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
        </div>
    </section>

    <!-- Call to Action -->
    <section class="py-16 bg-gradient-to-r from-gray-800 to-gray-900">
        <div class="container mx-auto px-4 text-center">
            <h2 class="text-3xl font-bold mb-6">Ready to shop like never before?</h2>
            <p class="text-xl text-gray-300 mb-8 max-w-2xl mx-auto">Join thousands of satisfied customers who trust us for quality products and exceptional service.</p>
            <a href="${pageContext.request.contextPath}/register" class="bg-primary text-gray-900 px-8 py-3 rounded-md font-bold hover:bg-yellow-300 transition inline-block">Create Free Account</a>
        </div>
    </section>
</main>

<jsp:include page="includes/footer.jsp"/>