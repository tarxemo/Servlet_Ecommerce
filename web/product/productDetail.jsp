<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="${product.name}"/>
</jsp:include>
<jsp:include page="../includes/navigation.jsp"/>

<main class="flex-grow container mx-auto px-4 py-8">
    <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 p-6">
            <div>
                <div class="mb-4">
                    <img  src="${pageContext.request.contextPath}/product/image?id=${product.productId}" 
                          alt="${product.name}" class="w-full rounded-lg">
                </div>
                <div class="grid grid-cols-4 gap-2">
                    <div class="border-2 border-primary rounded-lg overflow-hidden">
                        <img   src="${pageContext.request.contextPath}/product/image?id=${product.productId}" 
                               alt="${product.name}" class="w-full h-16 object-cover">
                    </div>
                    <div class="border-2 border-transparent rounded-lg overflow-hidden hover:border-primary">
                        <img   src="${pageContext.request.contextPath}/product/image?id=${product.productId}" 
                               alt="${product.name}" class="w-full h-16 object-cover">
                    </div>
                    <div class="border-2 border-transparent rounded-lg overflow-hidden hover:border-primary">
                        <img   src="${pageContext.request.contextPath}/product/image?id=${product.productId}" 
                               alt="${product.name}" class="w-full h-16 object-cover">
                    </div>
                    <div class="border-2 border-transparent rounded-lg overflow-hidden hover:border-primary">
                        <img   src="${pageContext.request.contextPath}/product/image?id=${product.productId}" 
                               alt="${product.name}" class="w-full h-16 object-cover">
                    </div>
                </div>
            </div>
            
            <div>
                <h1 class="text-2xl font-bold mb-2">${product.name}</h1>
                <div class="flex items-center mb-4">
                    <div class="flex text-yellow-400 mr-2">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="text-gray-400 text-sm">(24 reviews)</span>
                </div>
                
                <div class="mb-6">
                    <span class="text-3xl font-bold text-primary">$${product.price}</span>
                    <c:if test="${product.stockQuantity > 0}">
                        <span class="ml-2 text-green-500 text-sm"><i class="fas fa-check-circle"></i> In Stock (${product.stockQuantity} available)</span>
                    </c:if>
                    <c:if test="${product.stockQuantity <= 0}">
                        <span class="ml-2 text-red-500 text-sm"><i class="fas fa-times-circle"></i> Out of Stock</span>
                    </c:if>
                </div>
                
                <p class="text-gray-300 mb-6">${product.description}</p>
                
                <div class="mb-6">
                    <h3 class="font-bold mb-2">Specifications</h3>
                    <ul class="text-gray-400 text-sm space-y-1">
                        <li><span class="text-gray-300">Category:</span> ${category.name}</li>
                        <li><span class="text-gray-300">Weight:</span> 1.2 kg</li>
                        <li><span class="text-gray-300">Dimensions:</span> 10 x 15 x 5 cm</li>
                        <li><span class="text-gray-300">Material:</span> Plastic</li>
                    </ul>
                </div>
                
                <div class="flex items-center space-x-4">
                    <div class="flex items-center border border-gray-700 rounded-md">
                        <button type="button" class="bg-gray-700 text-white px-3 py-2 rounded-l-md hover:bg-gray-600 quantity-minus">
                            <i class="fas fa-minus"></i>
                        </button>
                        <span class="bg-gray-800 px-4 py-2 quantity-display">1</span>
                        <button type="button" class="bg-gray-700 text-white px-3 py-2 rounded-r-md hover:bg-gray-600 quantity-plus">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>

                    <c:choose>
                        <c:when test="${product.stockQuantity > 0}">
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" value="${product.productId}" name="productId">
                                <input type="hidden" value="1" name="quantity" id="quantity-input">
                                <button type="submit" class="bg-primary text-gray-900 px-3 py-1 rounded text-sm font-medium hover:bg-yellow-300 transition">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <button class="bg-gray-600 text-gray-300 px-6 py-2 rounded-md font-bold cursor-not-allowed flex-grow" disabled>
                                <i class="fas fa-ban mr-2"></i> Out of Stock
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>

                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        const minusBtn = document.querySelector('.quantity-minus');
                        const plusBtn = document.querySelector('.quantity-plus');
                        const quantityDisplay = document.querySelector('.quantity-display');
                        const quantityInput = document.getElementById('quantity-input');
                        const maxStock = ${product.stockQuantity}; // Get the actual stock quantity from JSP

                        let quantity = 1;

                        // Update display and hidden input
                        function updateQuantity() {
                            quantityDisplay.textContent = quantity;
                            quantityInput.value = quantity;
                        }

                        // Minus button click handler
                        minusBtn.addEventListener('click', function() {
                            if (quantity > 1) {
                                quantity--;
                                updateQuantity();
                            }
                        });

                        // Plus button click handler
                        plusBtn.addEventListener('click', function() {
                            if (quantity < maxStock) {
                                quantity++;
                                updateQuantity();
                            } else {
                                alert('Cannot add more than available stock');
                            }
                        });
                    });
                </script>
                
                <div class="mt-6 flex space-x-4">
                    <button class="text-gray-400 hover:text-primary transition">
                        <i class="far fa-heart mr-2"></i> Add to Wishlist
                    </button>
                    <button class="text-gray-400 hover:text-primary transition">
                        <i class="fas fa-share-alt mr-2"></i> Share
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Product tabs -->
        <div class="border-t border-gray-700">
            <div class="flex border-b border-gray-700">
                <button class="px-6 py-3 font-medium border-b-2 border-primary text-primary">Description</button>
                <button class="px-6 py-3 font-medium text-gray-400 hover:text-primary">Specifications</button>
                <button class="px-6 py-3 font-medium text-gray-400 hover:text-primary">Reviews (24)</button>
            </div>
            <div class="p-6">
                <p class="text-gray-300">${product.description}</p>
                <p class="text-gray-300 mt-4">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
            </div>
        </div>
    </div>
    
    <!-- Related products -->
    <div class="mt-12">
        <h2 class="text-2xl font-bold mb-6">You may also like</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <c:forEach var="relatedProduct" items="${relatedProducts}">
                <div class="bg-gray-800 rounded-lg overflow-hidden shadow-lg hover:shadow-xl transition transform hover:-translate-y-1">
                    <div class="relative">
                        <a href="${pageContext.request.contextPath}/product/${relatedProduct.productId}">
                            <img src="${relatedProduct.imageUrl}" alt="${relatedProduct.name}" class="w-full h-48 object-cover">
                        </a>
                    </div>
                    <div class="p-4">
                        <a href="${pageContext.request.contextPath}/product/${relatedProduct.productId}" class="hover:text-primary transition">
                            <h3 class="text-lg font-semibold mb-1 truncate">${relatedProduct.name}</h3>
                        </a>
                        <p class="text-gray-400 text-sm mb-3 line-clamp-2">${relatedProduct.description}</p>
                        <div class="flex justify-between items-center">
                            <span class="text-primary font-bold">$${relatedProduct.price}</span>
                            <a href="${pageContext.request.contextPath}/cart?action=add&productId=${relatedProduct.productId}" class="bg-primary text-gray-900 px-3 py-1 rounded text-sm font-medium hover:bg-yellow-300 transition">
                                <i class="fas fa-cart-plus"></i> Add
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</main>

<jsp:include page="../includes/footer.jsp"/>