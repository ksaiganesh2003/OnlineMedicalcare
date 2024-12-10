<%@page import="com.java.DB"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                con = DB.getConnection();
                // Name=request.getParameter("Patient_name");
                Random random = new Random();
				int newRandomCaptcha = random.nextInt(9000) + 10000;
                id = request.getParameter("pid");
                String pass = request.getParameter("Password");
                String vercode = request.getParameter("vercode");
                ResultSet captchResultSet = DB.getResultFromSqlQuery("select * from tblcaptcha");
				if (captchResultSet.next()) {
					captchaDB = captchResultSet.getString(1);
				}
				if (captchaDB.equals(vercode)) {
                String sql = "select * from table_patient where Pid='" + id + "' and Pass='" + pass + "' ";
                Statement st = con.createStatement();
                rs = st.executeQuery(sql);
                if (rs.next()) {
                    conn = DB.getConnection();
                    pss = conn.prepareStatement("select Pname,age from table_patient where pid='" + id + "'");
                    rss = pss.executeQuery();
                    if (rss.next()) {
                        Name = rs.getString("Pname");
                        age = rs.getString("age");
                        phone = rs.getString("Contact");
                        email = rs.getString("Email");
                    }
                    session.setAttribute("pname", Name);
                    session.setAttribute("pid", id);
                    session.setAttribute("age", age);
                    session.setAttribute("pemail", email);
                    session.setAttribute("pphone", phone);
                    int update = DB.insertUpdateFromSqlQuery("update tblcaptcha set captcha='" + newRandomCaptcha + "'");
                    response.sendRedirect("PatientHome.jsp");
                } else {
                    String msg = "Invalid Patient ID or Password...";
                    session.setAttribute("msg", msg);
                    int update = DB.insertUpdateFromSqlQuery("update tblcaptcha set captcha='" + newRandomCaptcha + "'");
                    response.sendRedirect("PatientLogin.jsp");
                }
				}else{
					String message = "You have enter invalid verification code";
					session.setAttribute("verificationCode", message);
					int update = DB.insertUpdateFromSqlQuery("update tblcaptcha set captcha='" + newRandomCaptcha + "'");
					response.sendRedirect("PatientLogin.jsp");
				}
            } catch (Exception e) {
                out.println(e);
            }
        %>
    </body>
</html>
