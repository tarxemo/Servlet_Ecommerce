<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="bg-gray-800 mt-auto">
    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
                <h3 class="text-primary text-lg font-bold mb-4">ShopNest</h3>
                <p class="text-gray-400">Your one-stop shop for all your needs. Quality products at affordable prices.</p>
            </div>
            <div>
                <h4 class="text-primary text-lg font-bold mb-4">Quick Links</h4>
                <ul class="space-y-2">
                    <li><a href="${pageContext.request.contextPath}/" class="text-gray-400 hover:text-primary transition">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/product/list" class="text-gray-400 hover:text-primary transition">Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/about" class="text-gray-400 hover:text-primary transition">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact" class="text-gray-400 hover:text-primary transition">Contact</a></li>
                </ul>
            </div>
            <div>
                <h4 class="text-primary text-lg font-bold mb-4">Customer Service</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="text-gray-400 hover:text-primary transition">FAQs</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-primary transition">Shipping Policy</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-primary transition">Returns & Refunds</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-primary transition">Privacy Policy</a></li>
                </ul>
            </div>
            <div>
                <h4 class="text-primary text-lg font-bold mb-4">Connect With Us</h4>
                <div class="flex space-x-4">
                    <a href="#" class="text-gray-400 hover:text-primary transition text-xl"><i class="fab fa-facebook"></i></a>
                    <a href="#" class="text-gray-400 hover:text-primary transition text-xl"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-gray-400 hover:text-primary transition text-xl"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-gray-400 hover:text-primary transition text-xl"><i class="fab fa-linkedin"></i></a>
                </div>
                <div class="mt-4">
                    <p class="text-gray-400">Subscribe to our newsletter</p>
                    <div class="flex mt-2">
                        <input type="email" placeholder="Your email" class="bg-gray-700 text-white px-3 py-2 rounded-l-md focus:outline-none focus:ring-2 focus:ring-primary w-full">
                        <button class="bg-primary text-gray-900 px-4 py-2 rounded-r-md font-medium hover:bg-yellow-300 transition">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="border-t border-gray-700 mt-8 pt-6 text-center text-gray-400">
            <p>&copy; 2023 ShopNest. All rights reserved.</p>
        </div>
    </div>
</footer>
</body>
</html>