<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Order History"/>
</jsp:include>
<jsp:include page="../includes/navigation.jsp"/>

<main class="flex-grow container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-8">Order History</h1>
    
    <c:choose>
        <c:when test="${empty orders || orders.size() == 0}">
            <div class="bg-gray-800 rounded-lg p-8 text-center">
                <i class="fas fa-box-open text-5xl text-primary mb-4"></i>
                <h2 class="text-2xl font-bold mb-2">No orders yet</h2>
                <p class="text-gray-400 mb-6">You haven't placed any orders with us yet.</p>
                <a href="${pageContext.request.contextPath}/product/list" class="bg-primary text-gray-900 px-6 py-3 rounded-md font-bold hover:bg-yellow-300 transition inline-block">
                    <i class="fas fa-shopping-bag mr-2"></i> Start Shopping
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-700">
                        <thead class="bg-gray-700">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Order #</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Date</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Status</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Total</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-400 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-gray-800 divide-y divide-gray-700">
                            <c:forEach var="order" items="${orders}">
                                <tr class="hover:bg-gray-700 transition">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-300">#${order.orderId}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-400">
                                        <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy hh:mm a"/>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <c:choose>
                                            <c:when test="${order.status == 'pending'}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">Pending</span>
                                            </c:when>
                                            <c:when test="${order.status == 'processing'}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">Processing</span>
                                            </c:when>
                                            <c:when test="${order.status == 'shipped'}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-indigo-100 text-indigo-800">Shipped</span>
                                            </c:when>
                                            <c:when test="${order.status == 'delivered'}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Delivered</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">${order.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-primary font-bold">$${order.totalAmount}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <a href="${pageContext.request.contextPath}/order/confirmation?id=${order.orderId}" class="text-primary hover:text-yellow-300 mr-3">View</a>
                                        <a href="#" class="text-gray-400 hover:text-gray-300">Invoice</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Pagination -->
            <div class="mt-8 flex justify-between items-center">
                <div class="text-sm text-gray-400">
                    Showing <span class="font-medium">1</span> to <span class="font-medium">10</span> of <span class="font-medium">${orders.size()}</span> orders
                </div>
                <nav class="inline-flex rounded-md shadow">
                    <a href="#" class="px-3 py-2 rounded-l-md bg-gray-800 text-gray-400 hover:bg-gray-700">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                    <a href="#" class="px-3 py-2 bg-gray-800 text-gray-400 hover:bg-gray-700">1</a>
                    <a href="#" class="px-3 py-2 bg-gray-800 text-gray-400 hover:bg-gray-700">2</a>
                    <a href="#" class="px-3 py-2 rounded-r-md bg-gray-800 text-gray-400 hover:bg-gray-700">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </nav>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="../includes/footer.jsp"/>