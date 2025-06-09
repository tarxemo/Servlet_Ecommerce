<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Checkout"/>
</jsp:include>
<jsp:include page="../includes/navigation.jsp"/>

<main class="flex-grow container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-8">Checkout</h1>
    
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
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <div>
                    <div class="bg-gray-800 rounded-lg shadow-lg p-6 mb-6">
                        <h2 class="text-xl font-bold mb-4">Shipping Information</h2>
                        <form id="shippingForm">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label for="firstName" class="block text-sm font-medium text-gray-400 mb-1">First Name</label>
                                    <input type="text" id="firstName" name="firstName" value="${user.firstName}" 
                                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                                </div>
                                <div>
                                    <label for="lastName" class="block text-sm font-medium text-gray-400 mb-1">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" value="${user.lastName}" 
                                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                                </div>
                            </div>
                            <div class="mt-4">
                                <label for="address" class="block text-sm font-medium text-gray-400 mb-1">Address</label>
                                <input type="text" id="address" name="address" value="${user.address}" 
                                    class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-4">
                                <div>
                                    <label for="city" class="block text-sm font-medium text-gray-400 mb-1">City</label>
                                    <input type="text" id="city" name="city" value="${user.city}" 
                                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                                </div>
                                <div>
                                    <label for="state" class="block text-sm font-medium text-gray-400 mb-1">State</label>
                                    <input type="text" id="state" name="state" value="${user.state}" 
                                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                                </div>
                                <div>
                                    <label for="zipCode" class="block text-sm font-medium text-gray-400 mb-1">ZIP Code</label>
                                    <input type="text" id="zipCode" name="zipCode" value="${user.zipCode}" 
                                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                        <h2 class="text-xl font-bold mb-4">Payment Method</h2>
                        <div class="space-y-4">
                            <div class="flex items-center">
                                <input id="credit-card" name="paymentMethod" type="radio" value="credit_card" checked 
                                    class="h-4 w-4 text-primary focus:ring-primary border-gray-600 bg-gray-700">
                                <label for="credit-card" class="ml-3 block text-sm font-medium text-gray-300">
                                    Credit Card
                                </label>
                            </div>
                            <div class="flex items-center">
                                <input id="paypal" name="paymentMethod" type="radio" value="paypal" 
                                    class="h-4 w-4 text-primary focus:ring-primary border-gray-600 bg-gray-700">
                                <label for="paypal" class="ml-3 block text-sm font-medium text-gray-300">
                                    PayPal
                                </label>
                            </div>
                            <div class="flex items-center">
                                <input id="bank-transfer" name="paymentMethod" type="radio" value="bank_transfer" 
                                    class="h-4 w-4 text-primary focus:ring-primary border-gray-600 bg-gray-700">
                                <label for="bank-transfer" class="ml-3 block text-sm font-medium text-gray-300">
                                    Bank Transfer
                                </label>
                            </div>
                        </div>
                        
                        <div id="creditCardForm" class="mt-6">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label for="cardNumber" class="block text-sm font-medium text-gray-400 mb-1">Card Number</label>
                                    <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" 
                                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                                </div>
                                <div>
                                    <label for="cardName" class="block text-sm font-medium text-gray-400 mb-1">Name on Card</label>
                                    <input type="text" id="cardName" name="cardName" placeholder="John Doe" 
                                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                                </div>
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-4">
                                <div>
                                    <label for="expiryDate" class="block text-sm font-medium text-gray-400 mb-1">Expiry Date</label>
                                    <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" 
                                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                                </div>
                                <div>
                                    <label for="cvv" class="block text-sm font-medium text-gray-400 mb-1">CVV</label>
                                    <input type="text" id="cvv" name="cvv" placeholder="123" 
                                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div>
                    <div class="bg-gray-800 rounded-lg shadow-lg p-6 sticky top-4">
                        <h2 class="text-xl font-bold mb-4">Order Summary</h2>
                        <div class="divide-y divide-gray-700 mb-6">
                            <c:forEach var="item" items="${cart.items}">
                                <div class="py-3 flex justify-between">
                                    <div class="flex items-center">
                                        <span class="text-gray-400 mr-2">${item.quantity}x</span>
                                        <span>${item.productName}</span>
                                    </div>
                                    <span>$${item.price * item.quantity}</span>
                                </div>
                            </c:forEach>
                        </div>
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
                        <form action="${pageContext.request.contextPath}/checkout" method="POST">
                            <input type="hidden" name="shippingAddress" id="shippingAddressField">
                            <button type="submit" 
                                class="w-full bg-primary text-gray-900 text-center py-3 rounded-md font-bold hover:bg-yellow-300 transition">
                                Place Order
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Combine shipping info into a single string for submission
    const shippingForm = document.getElementById('shippingForm');
    const shippingAddressField = document.getElementById('shippingAddressField');
    
    shippingForm.addEventListener('input', function() {
        const formData = new FormData(shippingForm);
        const addressParts = [
            formData.get('firstName') + ' ' + formData.get('lastName'),
            formData.get('address'),
            formData.get('city') + ', ' + formData.get('state') + ' ' + formData.get('zipCode')
        ].filter(Boolean).join(' | ');
        
        shippingAddressField.value = addressParts;
    });
    
    // Trigger initial update
    shippingForm.dispatchEvent(new Event('input'));
    
    // Payment method toggle
    const paymentMethods = document.querySelectorAll('input[name="paymentMethod"]');
    const creditCardForm = document.getElementById('creditCardForm');
    
    paymentMethods.forEach(method => {
        method.addEventListener('change', function() {
            creditCardForm.style.display = this.value === 'credit_card' ? 'block' : 'none';
        });
    });
});
</script>

<jsp:include page="../includes/footer.jsp"/>