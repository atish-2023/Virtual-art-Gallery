<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Manage Users</title>
<style>

	

body{
text-align:center;}
table {
    width: 70%;
    border-collapse: collapse;
    margin: 20px auto; /* Center the table */
    text-align: center;
}


th, td {
	padding: 10px;
	border: 1px solid black;
	text-align: left;
}

th {
	background-color: #f4f4f4;
}

.delete-btn {
	color: white;
	background-color: red;
	padding: 5px 10px;
	text-decoration: none;
	border-radius: 4px;
}
</style>
</head>
<body>
	<h2>Users List</h2>
	<%
	if (request.getAttribute("message") != null) {
	%>
	<p style="color: green;"><%=request.getAttribute("message")%></p>
	<%
	}
	%>

	<table>
		<tr>
			<th>ID</th>
			<th>Username</th>
			<th>Email</th>
			<th>Role</th>
			<th>Action</th>
		</tr>
		<%
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualart", "root", "Atish@1193");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM users");

			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getInt("user_id")%></td>
			<td><%=rs.getString("username")%></td>
			<td><%=rs.getString("email")%></td>
			<td><%=rs.getString("role")%></td>
			<td><a href="DeleteUserServlet?id=<%=rs.getInt("user_id")%>"
				class="delete-btn"
				onclick="return confirm('Are you sure you want to delete this user?');">
					Delete </a></td>
		</tr>
		<%
		}
		rs.close();
		stmt.close();
		conn.close();
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
	</table>
</body>
</html>
