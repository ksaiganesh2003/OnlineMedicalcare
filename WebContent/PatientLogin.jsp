<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.java.DB"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>Hospital Management System</title>
<link rel="icon" href="images/log.png" type="image/png" sizes="16x16">
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="icon" href="images/log.png" type="image/png" sizes="16x16">
<link id="t-colors" href="css/default.css" rel="stylesheet">
</head>

<body id="page-top" data-spy="scroll" data-target=".navbar-custom"
	style="background: url('images/bg1.jpg') no-repeat;">
	<div id="wrapper">
		<jsp:include page="Eheader.jsp"></jsp:include>
		<!-- Section: intro -->
		<section id="intro" class="intro" style="margin-top: -130px;">
			<div class="intro-content">
				<div class="container">
					<div class="row">
						<div class="col-lg-6">
							<div class="wow fadeInUp" data-wow-duration="2s"
								data-wow-delay="0.2s">
								<img src="images/img-1.png" class="img img-responsive" alt="" />
							</div>
						</div>
						<br>
						<div class="col-lg-6">
							<div class="panel-body">
								<%
									String msg = (String) session.getAttribute("msg");
									String verificationCode = (String) session.getAttribute("verificationCode");

									if (msg != null) {
										session.removeAttribute("msg");
										out.println("<center><h4 class='alert alert-danger'>" + msg + "</h4></center>");
									} else {
	
									}

									if (verificationCode != null) {
										session.removeAttribute("verificationCode");
										out.println("<center><h4 class='alert alert-danger'>" + verificationCode + "</h4></center>");
									} else {
	
									}
								%>
								<center>
									<h3>Patient Login</h3>
								</center>
								<hr>
								<div class="col-lg-6">
									<div class="wow fadeInUp" data-wow-duration="2s"
										data-wow-delay="0.2s">
										<img src="images/Patienticon.jpg"
											style="width: 190px; height: 200px; margin-bottom: 9px;"
											class="img img-responsive" alt="" />
									</div>
								</div>
								<form action="PatientDao.jsp" method="post" role="form"
									class="contactForm lead">
									<div class="row">
										<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
											<div class="form-group">
												<label>Patient ID</label> <input type="text" name="pid"
													required="" placeholder="Patient ID" id="first_name"
													class="form-control input-md" data-rule="minlen:3"
													data-msg="Please enter at least 3 chars">
												<div class="validation"></div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
											<div class="form-group">
												<label>Password</label> <input type="password" required=""
													placeholder="Password" name="Password" id="last_name"
													class="form-control input-md" data-rule="minlen:3"
													data-msg="Please enter at least 3 chars">
												<div class="validation"></div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
											<div class="form-group">
												<label>Enter Verification Code</label> <input type="text"
													placeholder="Verification Code" name="vercode" required=""
													id="first_name" class="form-control input-md"
													data-rule="minlen:3">
												<div class="validation"></div>
											</div>
										</div>
										<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
											<div class="form-group">&nbsp;</div>
										</div>
										<%
											String captcha = null;
											Connection con = DB.getConnection();
											Statement st = con.createStatement();

											ResultSet resultset = st.executeQuery("select captcha from tblcaptcha");
											if (resultset.next()) {
												captcha = resultset.getString(1);
											}
										%>
										<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
											<div class="form-group">
												<label>Verification Code</label> <input type="text"
													value="<%=captcha%>" class="form-control input-md"
													data-rule="minlen:3" readonly>
												<div class="validation"></div>
											</div>
										</div>
									</div>
									<input type="submit" value="Submit"
										class="btn btn-skin btn-block btn-lg">
								</form>
								<!--  <center><a href="ForgotPass.jsp">Forgot Password?</a> -->
								<center>
									<a href="PatientForm.jsp">Sign Up Here</a>
								</center>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</body>

</html>
