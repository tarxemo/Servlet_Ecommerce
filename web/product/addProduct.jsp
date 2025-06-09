<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Add Product"/>
</jsp:include>
<jsp:include page="../includes/navigation.jsp"/>

<main class="flex-grow container mx-auto px-4 py-8">
    <div class="max-w-3xl mx-auto bg-gray-800 rounded-lg shadow-lg p-8">
        <h1 class="text-2xl font-bold mb-6">Add New Product</h1>
        
        <form action="${pageContext.request.contextPath}/product/manage?action=create" method="POST" enctype="multipart/form-data" class="space-y-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-400 mb-1">Product Name</label>
                    <input type="text" id="name" name="name" required 
                        class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                </div>
                
                <div>
                    <label for="price" class="block text-sm font-medium text-gray-400 mb-1">Price</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <span class="text-gray-400">$</span>
                        </div>
                        <input type="number" id="price" name="price" step="0.01" min="0" required 
                            class="bg-gray-700 text-white pl-8 pr-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                    </div>
                </div>
            </div>
            
            <div>
                <label for="category" class="block text-sm font-medium text-gray-400 mb-1">Category</label>
                <select id="category" name="categoryId" required 
                    class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
                    <option value="">Select a category</option>
                    <option value="1">Electronics</option>
                    <option value="2">Clothing</option>
                    <option value="3">Home & Garden</option>
                    <option value="4">Books</option>
                </select>
            </div>
            
            <div>
                <label for="stockQuantity" class="block text-sm font-medium text-gray-400 mb-1">Stock Quantity</label>
                <input type="number" id="stockQuantity" name="stockQuantity" min="0" required 
                    class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary">
            </div>
            
            <div>
                <label for="description" class="block text-sm font-medium text-gray-400 mb-1">Description</label>
                <textarea id="description" name="description" rows="4" 
                    class="bg-gray-700 text-white px-3 py-2 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary"></textarea>
            </div>
            
            <div>
                <label for="image" class="block text-sm font-medium text-gray-400 mb-1">Product Image</label>
                <div class="mt-1 flex items-center">
                    <span class="inline-block h-24 w-24 rounded-md overflow-hidden bg-gray-700">
                        <svg class="h-full w-full text-gray-600" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
                        </svg>
                    </span>
                    <label for="image" class="ml-5 bg-gray-700 py-2 px-3 border border-gray-600 rounded-md text-sm font-medium text-gray-300 hover:bg-gray-600 cursor-pointer">
                        <span>Upload Image</span>
                        <input id="image" name="image" type="file" class="sr-only" accept="image/*">
                    </label>
                </div>
            </div>
            
            <div class="flex justify-end space-x-4 pt-4">
                <button type="button" class="border border-gray-600 text-white px-4 py-2 rounded-md font-medium hover:bg-gray-700 transition">
                    Cancel
                </button>
                <button type="submit" class="bg-primary text-gray-900 px-6 py-2 rounded-md font-bold hover:bg-yellow-300 transition">
                    Add Product
                </button>
            </div>
        </form>
    </div>
</main>

<jsp:include page="../includes/footer.jsp"/>