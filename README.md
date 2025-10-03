# ECommerce Web Application

## Overview
This is a Java-based ECommerce web application that provides a platform for users to browse, manage, and purchase products online. It supports user authentication, product management, shopping cart functionality, and order processing.

## Features
- User registration, login, and logout
- Product listing with pagination
- Product categories
- Shopping cart management (add, update, remove items)
- Order history and management
- Product image upload and display
- Role-based access control for product management

## Technologies Used
- **Java Servlet API**
- **JSP** for views
- **MySQL** for database
- **JDBC** for database connectivity
- **Apache Tomcat** (assumed) as the servlet container

## Setup Instructions

### Prerequisites
- Java JDK 8 or higher  
- Apache Tomcat server  
- MySQL database  
- Maven (optional)  

### Database Setup
1. Create a MySQL database named `ecommerce_db`.
2. Create the required tables (`users`, `products`, `categories`, `orders`, `order_items`, `cart`, etc.) according to your schema.
3. Update database connection credentials in  
   `src/java/config/DBConnection.java` as needed.

### Running the Application
1. Build the project using your IDE or Maven.  
2. Deploy the WAR file (or project directory) to your Apache Tomcat server.  
3. Start the Tomcat server.  
4. Access the app at:  
```

[http://localhost:8080/](http://localhost:8080/)<context-path>

```

## Project Structure
```

src/java/
config/          # Configuration classes (DB connection, constants)
controllers/     # Servlet controllers (auth, product, cart, order)
dao/             # Data Access Objects for DB operations
exceptions/      # Custom exceptions
models/          # JavaBeans (User, Product, etc.)
services/        # Business logic
utils/           # Utility classes

web/               # JSP files & static resources
nbproject/         # NetBeans project files

```

## Usage
- Register or log in as a user  
- Browse products by category or search  
- Add products to your cart and checkout  
- View your order history  
- Product owners can manage products (add, update, delete)  

## Contributing
Contributions are welcome!  
Fork the repository and create a pull request with your improvements.  

## License
This project is licensed under the **MIT License** – see the LICENSE file for details.

---
