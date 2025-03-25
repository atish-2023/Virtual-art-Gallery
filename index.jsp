<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Virtual Art Gallery</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
/* General Reset */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body, html {
	font-family: Arial, Helvetica, sans-serif;
	background-color: #f8f9fa;
	height: 100%;
	width: 100%;
}

/* Navbar */
.nav {
	background-color: #000;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 20px;
	height: 60px;
	width: 100%;
}

.main-nav ul {
	display: flex;
	gap: 30px;
	list-style: none;
}

.main-nav ul li a {
	color: white;
	text-decoration: none;
	padding: 8px 12px;
	border-radius: 4px;
	transition: background 0.3s ease;
}

.main-nav ul li a:hover {
	color: gold;
	background-color: #333;
}

/* Auth Buttons */
.auth-buttons {
	display: flex;
	gap: 20px;
}

.login-dropdown {
	position: relative;
}

.login-dropdown-btn {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px 15px;
	cursor: pointer;
	border-radius: 5px;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: white;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
	border-radius: 5px;
	width: 150px;
}

.dropdown-content a {
	display: block;
	padding: 10px;
	text-decoration: none;
	color: black;
}

.dropdown-content a:hover {
	background-color: #f1f1f1;
}

.login-dropdown.active .dropdown-content {
	display: block;
}

.register-btn {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 5px;
	text-decoration: none;
	cursor: pointer;
}

/* Hero Section */
.hero {
	background: url("https://via.placeholder.com/1920x600") no-repeat center
		center/cover;
	height: 400px;
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	color: white;
	padding: 20px;
}

.hero-text {
	background: rgba(0, 0, 0, 0.7);
	padding: 30px 50px;
	border-radius: 15px;
	max-width: 80%;
}

.hero h1 {
	font-size: 3rem;
}

.hero p {
	font-size: 1.25rem;
	margin-bottom: 20px;
}

.hero-btn {
	background-color: gold;
	color: black;
	padding: 10px 20px;
	text-decoration: none;
	border-radius: 5px;
}

.hero-btn:hover {
	background-color: #f1c40f;
}

/* Card Container */
.cards-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	padding: 40px 20px;
	justify-content: center;
}

.card {
	background: #e8e0ff;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	width: 300px;
	text-align: center;
	padding: 20px;
	transition: transform 0.3s, background 0.3s;
}

.card:hover {
	transform: translateY(-5px);
	background: #d1c0ff;
}

.card img {
	width: 100%;
	border-radius: 8px;
	height: 200px;
	object-fit: cover;
}

.card-title {
	font-size: 1.25rem;
	font-weight: bold;
	color: #333;
	margin: 10px 0;
}

.price {
	font-weight: bold;
	color: #27ae60;
	margin-bottom: 10px;
}

.card-btn {
	background-color: #3498db;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	width: 100%;
	margin-top: 10px;
	transition: background 0.3s;
}

.card-btn:hover {
	background-color: #2980b9;
}

.buy-btn {
	background-color: #e74c3c;
}

.buy-btn:hover {
	background-color: #c0392b;
}

/* Footer */
.footer {
	background-color: #333;
	color: white;
	text-align: center;
	padding: 20px 0;
}

.footer-content {
	margin-bottom: 10px;
}

.socials {
	margin: 10px 0;
}

.socials a {
	margin: 0 10px;
	color: white;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.hero h1 {
		font-size: 2.5rem;
	}
	.hero p {
		font-size: 1rem;
	}
	.cards-container {
		flex-direction: column;
		align-items: center;
	}
	.card {
		width: 90%;
	}
}
</style>
</head>

<body>
	<!-- Navbar -->
	<div class="nav">
		<nav class="main-nav">
			<ul>
				<li><a href="#home">Home</a></li>
				<li><a href="#gallery">Gallery</a></li>
				<li><a href="#artists">Artists</a></li>
				<li><a href="#contact">Contact</a></li>
			</ul>
		</nav>

		<div class="auth-buttons">
			<div class="login-dropdown">
				<button class="login-dropdown-btn">Login</button>
				<div class="dropdown-content">
					<a href="login.jsp">User Login</a> 
					<a href="adminlogin.jsp">Admin Login</a>
				</div>
			</div>

			<a href="register.jsp">
				<button class="register-btn">Register</button>
			</a>
		</div>
	</div>

	<!-- Hero Section -->
	<header class="hero">
		<div class="hero-text">
			<h1>Welcome to the Virtual Art Gallery</h1>
			<p>Explore a curated collection of stunning artworks from talented artists around the world.</p>
			<a href="#gallery" class="hero-btn">Explore the Gallery</a>
		</div>
	</header>

	<!-- Gallery Section - Display Paintings from Database -->
	<div class="cards-container" id="gallery">
		<%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/virtualart", "root", "Atish@1193");

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM paintings");

                while (rs.next()) {
        %>
                <div class="card">
                    <img src="<%= rs.getString("image_path") %>" alt="Painting Image">
                    <h3 class="card-title"><%= rs.getString("title") %></h3>
                    <p>Artist: <%= rs.getString("artist_name") %></p>
                    <p class="price">₹<%= rs.getDouble("price") %></p>
                    <button class="card-btn">View Details</button>
                    <button class="buy-btn card-btn">Buy</button>
                </div>
        <%
                }
                con.close();
            } catch (Exception e) {
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            }
        %>
	</div>

	<!-- Footer -->
	<footer class="footer">
		<h3>Virtual Art Gallery</h3>
		<p>&copy; 2025 Virtual Art Gallery. All rights reserved.</p>
	</footer>

	<script>
		document.querySelector(".login-dropdown-btn").addEventListener("click", function() {
			document.querySelector(".login-dropdown").classList.toggle("active");
		});
	</script>
</body>
</html>
