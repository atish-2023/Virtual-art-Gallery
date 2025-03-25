<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Form</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #000000;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            width: 400px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 30px;
        }

        h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        .textbox {
            margin-bottom: 15px;
        }

        .textbox input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .toggle-form {
            text-align: center;
            margin-top: 15px;
            color: #555;
            cursor: pointer;
        }

        .toggle-form:hover {
            color: #4CAF50;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Register</h2>

        <!-- Display Error Message (If exists) -->
        <%
            String errorMessage = request.getParameter("error");
            if (errorMessage != null) {
        %>
            <p style="color: red; text-align: center;"><%= errorMessage %></p>
        <% } %>

        <!-- Form to submit data to RegisterServlet -->
        <form action="RegisterServlet" method="POST">
            <div class="textbox">
                <input type="text" placeholder="Username" name="username" required>
            </div>
            <div class="textbox">
                <input type="email" placeholder="Email" name="email" required>
            </div>
            <div class="textbox">
                <input type="password" placeholder="Password" name="password" required>
            </div>
            <div class="textbox">
                <input type="password" placeholder="Confirm Password" name="confirm_password" required>
            </div>
            <input type="submit" value="Register">

            <!-- Link to Login Page -->
            <p class="toggle-form">Already have an account? 
                <a href="login.jsp">Login</a>
            </p>
        </form>
    </div>

</body>
</html>
