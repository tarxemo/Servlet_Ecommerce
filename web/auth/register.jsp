<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Register"/>
</jsp:include>
<jsp:include page="../includes/navigation.jsp"/>

<main class="flex-grow flex items-center justify-center bg-gray-900 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8 bg-gray-800 p-8 rounded-xl shadow-2xl">
        <div class="text-center">
            <i class="fas fa-user-plus text-primary text-5xl mb-4"></i>
            <h2 class="text-3xl font-extrabold text-gray-100">Create your account</h2>
            <p class="mt-2 text-sm text-gray-400">
                Already have an account? <a href="${pageContext.request.contextPath}/login" class="text-primary hover:underline">Sign in</a>
            </p>
        </div>
        
        <c:if test="${not empty error}">
            <div class="bg-red-600 text-white p-3 rounded-md text-sm">
                <i class="fas fa-exclamation-circle mr-2"></i> ${error}
            </div>
        </c:if>
        
        <form class="mt-8 space-y-6" action="${pageContext.request.contextPath}/register" method="POST">
            <div class="rounded-md shadow-sm space-y-4">
                <div>
                    <label for="username" class="sr-only">Username</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-user text-gray-400"></i>
                        </div>
                        <input id="username" name="username" type="text" required 
                            class="bg-gray-700 text-white pl-10 pr-3 py-3 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary"
                            placeholder="Username">
                    </div>
                </div>
                <div>
                    <label for="email" class="sr-only">Email</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-envelope text-gray-400"></i>
                        </div>
                        <input id="email" name="email" type="email" required 
                            class="bg-gray-700 text-white pl-10 pr-3 py-3 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary"
                            placeholder="Email">
                    </div>
                </div>
                <div>
                    <label for="password" class="sr-only">Password</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-lock text-gray-400"></i>
                        </div>
                        <input id="password" name="password" type="password" required 
                            class="bg-gray-700 text-white pl-10 pr-3 py-3 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary"
                            placeholder="Password">
                    </div>
                </div>
                <div>
                    <label for="firstName" class="sr-only">First Name</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-id-card text-gray-400"></i>
                        </div>
                        <input id="firstName" name="firstName" type="text" 
                            class="bg-gray-700 text-white pl-10 pr-3 py-3 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary"
                            placeholder="First Name (optional)">
                    </div>
                </div>
                <div>
                    <label for="lastName" class="sr-only">Last Name</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-id-card text-gray-400"></i>
                        </div>
                        <input id="lastName" name="lastName" type="text" 
                            class="bg-gray-700 text-white pl-10 pr-3 py-3 rounded-md block w-full focus:outline-none focus:ring-2 focus:ring-primary"
                            placeholder="Last Name (optional)">
                    </div>
                </div>
            </div>

            <div class="flex items-center">
                <input id="terms" name="terms" type="checkbox" required
                    class="h-4 w-4 text-primary focus:ring-primary border-gray-600 rounded bg-gray-700">
                <label for="terms" class="ml-2 block text-sm text-gray-400">
                    I agree to the <a href="#" class="text-primary hover:underline">Terms of Service</a> and <a href="#" class="text-primary hover:underline">Privacy Policy</a>
                </label>
            </div>

            <div>
                <button type="submit" 
                    class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-md text-gray-900 bg-primary hover:bg-yellow-300 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition">
                    <span class="absolute left-0 inset-y-0 flex items-center pl-3">
                        <i class="fas fa-user-plus text-gray-900"></i>
                    </span>
                    Register
                </button>
            </div>
        </form>
    </div>
</main>

<jsp:include page="../includes/footer.jsp"/>