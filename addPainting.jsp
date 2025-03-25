<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Painting</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .textbox {
            margin-bottom: 15px;
        }

        .textbox input, .textbox textarea, .textbox select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="file"] {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 8px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .message {
            text-align: center;
            margin-top: 15px;
            color: green;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add New Painting</h2>

    <!-- Display Success/Error Messages -->
    <% 
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if (success != null) {
    %>
        <div class="message"><%= success %></div>
    <% 
        } else if (error != null) {
    %>
        <div class="message error"><%= error %></div>
    <% } %>

    <form action="AddPaintingServlet" method="POST" enctype="multipart/form-data">
        <div class="textbox">
            <input type="text" name="title" placeholder="Title" required>
        </div>

        <div class="textbox">
            <input type="text" name="artist_name" placeholder="Artist Name" required>
        </div>

        <div class="textbox">
            <input type="number" step="0.01" name="price" placeholder="Price (₹)" required>
        </div>

        <div class="textbox">
            <input type="number" name="stock" placeholder="Stock" min="0" required>
        </div>

        <div class="textbox">
            <select name="category" required>
                <option value="">Select Category</option>
                <option value="Abstract">Abstract</option>
                <option value="Portrait">Portrait</option>
                <option value="Landscape">Landscape</option>
                <option value="Still Life">Still Life</option>
            </select>
        </div>

        <div class="textbox">
            <input type="file" name="image" required>
        </div>

        <div class="textbox">
            <textarea name="description" placeholder="Description" rows="4"></textarea>
        </div>

        <input type="submit" value="Add Painting">
    </form>
</div>

</body>
</html>
