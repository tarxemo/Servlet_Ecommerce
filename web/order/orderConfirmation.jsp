<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Order Confirmation"/>
</jsp:include>
<jsp:include page="../includes/navigation.jsp"/>

<main class="flex-grow flex items-center justify-center bg-gray-900 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-2xl w-full bg-gray-800 p-8 rounded-xl shadow-2xl text-center">
        <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-green-100 mb-4">
            <i class="fas fa-check text-green-600 text-xl"></i>
        </div>
        <h1 class="text-3xl font-bold text-gray-100 mb-2">Order Confirmed!</h1>
        <p class="text-gray-400 mb-6">Thank you for your purchase. Your order has been received and is being processed.</p>
        
        <div class="bg-gray-700 rounded-lg p-6 mb-8 text-left">
            <h2 class="text-xl font-bold mb-4">Order Details</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <h3 class="font-medium text-gray-400 mb-2">Order Information</h3>
                    <p class="text-gray-300"><span class="text-gray-400">Order #:</span> ${order.orderId}</p>
                    <p class="text-gray-300"><span class="text-gray-400">Date:</span> ${order.orderDate}</p>
                    <p class="text-gray-300"><span class="text-gray-400">Total:</span> $${order.totalAmount}</p>
                    <p class="text-gray-300"><span class="text-gray-400">Payment Method:</span> ${order.paymentMethod}</p>
                </div>
                <div>
                    <h3 class="font-medium text-gray-400 mb-2">Shipping Address</h3>
                    <p class="text-gray-300">${order.shippingAddress}</p>
                </div>
            </div>
        </div>
        
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 text-left">Order Items</h2>
            <div class="bg-gray-700 rounded-lg divide-y divide-gray-600">
                <c:forEach var="item" items="${order.items}">
                    <div class="p-4 flex items-center">
                        <div class="flex-shrink-0 h-16 w-16 bg-gray-600 rounded-md overflow-hidden">
                            <img  src="${pageContext.request.contextPath}/product/image?id=${item.productId}"  
                                  alt="${item.productName}" class="h-full w-full object-cover">
                        </div>
                        <div class="ml-4 flex-grow">
                            <h3 class="text-gray-300 font-medium">${item.productName}</h3>
                            <p class="text-gray-400 text-sm">Qty: ${item.quantity}</p>
                        </div>
                        <div class="ml-4">
                            <p class="text-primary font-bold">$${item.price * item.quantity}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <div class="flex flex-col sm:flex-row justify-center space-y-3 sm:space-y-0 sm:space-x-4">
            <a href="${pageContext.request.contextPath}/product/list" class="bg-gray-700 text-white px-6 py-3 rounded-md font-medium hover:bg-gray-600 transition inline-block">
                <i class="fas fa-shopping-bag mr-2"></i> Continue Shopping
            </a>
            <a href="${pageContext.request.contextPath}/order/history" class="bg-primary text-gray-900 px-6 py-3 rounded-md font-bold hover:bg-yellow-300 transition inline-block">
                <i class="fas fa-list-alt mr-2"></i> View Order History
            </a>
        </div>
    </div>
</main>

<jsp:include page="../includes/footer.jsp"/>