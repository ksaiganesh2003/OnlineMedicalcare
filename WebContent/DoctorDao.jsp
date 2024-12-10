<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.java.DB"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
</head>
<body>
	<%!
				Connection con, conn;
				PreparedStatement ps, pss;
				ResultSet rs, rss;
				String Name, id, age, email, phone;
				String captchaDB = null;
	%>
	<%
					try {
					Random random = new Random();
					int newRandomCaptcha = random.nextInt(9000) + 10000;
					con = DB.getConnection();
					Name = request.getParameter("Doctor_name");
					id = request.getParameter("did");
					String pass = request.getParameter("Password");
					String vercode = request.getParameter("vercode");
					Statement statement = con.createStatement();
					ResultSet captchResultSet = statement.executeQuery("select * from tblcaptcha");
					if (captchResultSet.next()) {
						captchaDB = captchResultSet.getString(1);
					}
					if (captchaDB.equals(vercode)) {
						String sql = "select * from table_doctor where Did='" + id + "' && Pass='" + pass + "' ";
						Statement st = con.createStatement();
						rs = st.executeQuery(sql);
						if (rs.next()) {
						conn = DB.getConnection();
						pss = conn.prepareStatement("select * from table_doctor where Did='" + id + "'");
						rss = pss.executeQuery();
					if (rss.next()) {
						Name = rss.getString("Dname");
						age = rss.getString("age");
						email = rss.getString("email");
						phone = rss.getString("Contact");
					}
						session.setAttribute("did", id);
						session.setAttribute("dname", Name);
						session.setAttribute("dage", age);
						session.setAttribute("demail", email);
						session.setAttribute("dphone", phone);
						int update = DB.insertUpdateFromSqlQuery("update tblcaptcha set captcha='" + newRandomCaptcha + "'");
						response.sendRedirect("DoctorHome.jsp");
					} else {
						String msg = "Invalid Doctor ID or Password";
						session.setAttribute("msg", msg);
						int update = DB.insertUpdateFromSqlQuery("update tblcaptcha set captcha='" + newRandomCaptcha + "'");
						response.sendRedirect("DoctorLogin.jsp");
					}
					} else {
						String message = "You have enter invalid verification code";
						session.setAttribute("verificationCode", message);
						int update = DB.insertUpdateFromSqlQuery("update tblcaptcha set captcha='" + newRandomCaptcha + "'");
						response.sendRedirect("DoctorLogin.jsp");
					}
				} catch (Exception e) {
					out.println(e);
				}
	%>
</body>
</html>
