<%@page import="com.java.DB"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Profile</title>
        <link rel="icon" href="images/log.png" type="image/png" sizes="16x16">
        <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css"></style>
    <script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <style>
        tr, td, th {
            background-color: white;
        }
    </style>
    <script>
        $(document).ready(function() {
            $('#myTable').dataTable();
        });
    </script>
</head>
<jsp:include page="PHeader.jsp"></jsp:include>
<body id="page-top" data-spy="scroll" data-target=".navbar-custom" style="background:url('images/bg1.jpg') repeat left top;">
<%!
    Connection con;
    PreparedStatement ps;
    Statement st;
    ResultSet rs;
    String pname, email, gender, age, contact, dob, status, pid, address, photoPath;
%>
<center><h2>Your Profile</h2></center>
<%
    String update = (String) session.getAttribute("updates");
    if (update != null) {
        session.removeAttribute("updates");
        out.println("<center><div class='alert alert-success'>Your detail has been updated successfully...</div></center>");
    }
%>
<%
    try {
        String id = (String) session.getAttribute("pid");
        con = DB.getConnection();
        st = con.createStatement();
        rs = st.executeQuery("select * from table_patient where Pid='" + id + "'");
        if (rs.next()) {
            pid = rs.getString("Pid");
            pname = rs.getString("Pname");
            email = rs.getString("Email");
            contact = rs.getString("Contact");
            dob = rs.getString("Dob");
            gender = rs.getString("Gender");
            age = rs.getString("age");
            status = rs.getString("Pstatus");
            address = rs.getString("Address");
            photoPath = rs.getString("Photo"); // Retrieve photo path
        }
    } catch (Exception e) {
        out.println(e);
    }
%>
<table id="myTable" class="table table-striped table-bordered">
    <tr>
        <th>ID</th>
        <td><%=pid%></td>
    </tr>
    <tr>
        <th>Name</th>
        <td><%=pname%></td>
    </tr>
    <tr>
        <th>Gender</th>
        <td><%=gender%></td>
    </tr>
    <tr>
        <th>DOB</th>
        <td><%=dob%></td>
    </tr>
    <tr>
        <th>Age</th>
        <td><%=age%></td>
    </tr>
    <tr>
        <th>Status</th>
        <td><%=status%></td>
    </tr>
    <tr>
        <th>Contact Number</th>
        <td><%=contact%></td>
    </tr>
    <tr>
        <th>Email</th>
        <td><%=email%></td>
    </tr>
    <tr>
        <th>Address</th>
        <td><%=address%></td>
    </tr>
    <tr>
        <th>Photo</th>
        <td>
            <% if (photoPath != null && !photoPath.isEmpty()) { %>
                <img src="<%=request.getContextPath() + "/" + photoPath%>" alt="Profile Photo" width="150" height="150">
            <% } else { %>
                No photo uploaded
            <% } %>
        </td>
    </tr>
    <tr>
        <th>Upload Photo</th>
        <td>
            <form action="Photoservlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="pid" value="<%=pid%>">
                <input type="file" name="photo" required>
                <button type="submit" class="btn btn-success">Upload Photo</button>
            </form>
        </td>
    </tr>
    <tr>
        <th>Action</th>
        <td><a href="EditProfile.jsp?id=<%=pid%>" class="btn btn-danger">Edit Profile</a></td>
    </tr>
</table>
</body>
</html>
