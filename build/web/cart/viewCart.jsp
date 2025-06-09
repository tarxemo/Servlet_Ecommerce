<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="My Cart"/>
</jsp:include>
<jsp:include page="../includes/navigation.jsp"/>

<main class="flex-grow container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-8">Shopping Cart</h1>
    
    <c:choose>
        <c:when test="${empty cart.items || cart.items.size() == 0}">
            <div class="bg-gray-800 rounded-lg p-8 text-center">
                <i class="fas fa-shopping-cart text-5xl text-primary mb-4"></i>
                <h2 class="text-2xl font-bold mb-2">Your cart is empty</h2>
                <p class="text-gray-400 mb-6">Looks like you haven't added any items to your cart yet.</p>
                <a href="${pageContext.request.contextPath}/product/list" class="bg-primary text-gray-900 px-6 py-3 rounded-md font-bold hover:bg-yellow-300 transition inline-block">
                    <i class="fas fa-arrow-left mr-2"></i> Continue Shopping
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <div class="lg:col-span-2">
                    <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden">
                        <div class="divide-y divide-gray-700">
                            <c:forEach var="item" items="${cart.items}">
                                <div class="p-4 flex flex-col sm:flex-row">
                                    <div class="flex-shrink-0 mb-4 sm:mb-0">
                                        <img  src="${pageContext.request.contextPath}/product/image?id=${item.productId}" 
                                              alt="${item.productName}" class="w-24 h-24 object-cover rounded-md">
                                    </div>
                                    <div class="flex-grow sm:ml-4">
                                        <div class="flex justify-between">
                                            <h3 class="text-lg font-semibold">${item.productName}</h3>
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" value="${item.productId}" name="productId">
                                                <input type="hidden" value="${item.quantity}" name="quantity">
                                                <button type="submit" class="text-gray-400 hover:text-primary">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </form>
                                        </div>
                                        <p class="text-primary font-bold mt-1">$${item.price}</p>
                                        <div class="flex items-center mt-4">
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" value="${item.quantity - 1}" name="quantity">
                                                <input type="hidden" value="${item.productId}" name="productId">
                                                <button type="submit" 
                                                    class="bg-gray-700 text-white px-3 py-1 rounded-l-md hover:bg-gray-600">
                                                    <i class="fas fa-minus"></i>
                                                </button>
                                            </form>
                                            <span class="bg-gray-700 px-4 py-1">${item.quantity}</span>
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" value="${item.quantity + 1}" name="quantity">
                                                <input type="hidden" value="${item.productId}" name="productId">
                                                <button type="submit" 
                                                    class="bg-gray-700 text-white px-3 py-1 rounded-r-md hover:bg-gray-600">
                                                    <i class="fas fa-plus"></i>
                                                </button>
                                            </form>
                                            <span class="ml-auto font-bold">$${item.price * item.quantity}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                
                <div>
                    <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                        <h2 class="text-xl font-bold mb-4">Order Summary</h2>
                        <div class="space-y-3 mb-6">
                            <div class="flex justify-between">
                                <span class="text-gray-400">Subtotal</span>
                                <span>$${cart.total}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-400">Shipping</span>
                                <span class="text-primary">Free</span>
                            </div>
                            <div class="flex justify-between border-t border-gray-700 pt-3">
                                <span class="font-bold">Total</span>
                                <span class="font-bold text-primary">$${cart.total}</span>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/checkout" class="block w-full bg-primary text-gray-900 text-center py-3 rounded-md font-bold hover:bg-yellow-300 transition">
                            Proceed to Checkout
                        </a>
                    </div>
                    
                    <div class="mt-6 bg-gray-800 rounded-lg shadow-lg p-6">
                        <h3 class="font-bold mb-3">Promo Code</h3>
                        <div class="flex">
                            <input type="text" placeholder="Enter promo code" class="bg-gray-700 text-white px-3 py-2 rounded-l-md focus:outline-none focus:ring-2 focus:ring-primary flex-grow">
                            <button class="bg-primary text-gray-900 px-4 py-2 rounded-r-md font-medium hover:bg-yellow-300 transition">
                                Apply
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<script>
function updateQuantity(productId, newQuantity) {
    if (newQuantity > 0) {
        window.location.href = `${pageContext.request.contextPath}/cart?action=update&productId=${'${productId}'}&quantity=${'${newQuantity}'}`;
    }
}

function removeItem(productId) {
    if (confirm('Are you sure you want to remove this item from your cart?')) {
        window.location.href = `${pageContext.request.contextPath}/cart?action=remove&productId=${'${productId}'}`;
    }
}
</script>

<jsp:include page="../includes/footer.jsp"/>