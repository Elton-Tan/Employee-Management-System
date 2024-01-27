<%-- 
    Document   : login
    Created on : 5 Jun 2023, 6:45:27 pm
    Author     : ERMS
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.connection.*"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="login.css">
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css'>
    <title></title>
  </head>
  <body>
    <div class="LoginPageContainer">
    <div class="LoginPageInnerContainer">
        <div class="ImageContianer">
            <img src="https://i.imgur.com/MYZd7of.png" class="GroupImage">
        </div>
        <div class="LoginFormContainer">
            <div class="LoginFormInnerContainer">

                <div class="LogoContainer">

                  <!-- insert logo here dahlins <3-->

                </div>




                <header class="header">Employee Login</header>
                <header class="subHeader"></header>
                <form action="EmployeeLogin" method="post">
                                               <%
                                    //Connecting to the database
                                    Connection connection = DatabaseConnection.getConnection();
                                    Statement statement = connection.createStatement();
                                    String credential = (String) session.getAttribute("credential");
                                    //Checking creditionals whether there are null or not
                                    if (credential != null) {
                                        session.removeAttribute("credential");
                                %>
                                <div class="alert alert-danger" id="danger">Your email or password is incorrect</div>
                                <%
                                    }
                                %>
                    <div class="inputContainer">
                        <label class="label" for="emailAddress"><img src="https://i.imgur.com/Hn13wvm.png" class="labelIcon"><span>Email
                                Address*</span></label>
                        <input type="email" class="input" name="email" id="emailAddress" placeholder="Enter your Email Address">
                    </div>
                    <div class="inputContainer">
                        <label class="label" for="emailAddress"><img src="https://i.imgur.com/g5SvdfG.png"
                                class="labelIcon"><span>Password*</span></label>
                                <input type="password" class="input" name="password" id="emailAddress" placeholder="Enter your Password">
                    </div>
                    <div class="OptionsContainer">

                        <div class="checkboxContainer">
                          <!--
                            <input type="checkbox" id="RememberMe" class="checkbox"> <label for="RememberMe">Remember
                                me</label>
                              -->
                        </div>

                        <a href="forgot.jsp" class="ForgotPasswordLink" style="right: 0;">Forgot Password?</a>
                    </div>

                  <input type="submit" style="margin-bottom:30px;" value="Login" class="LoginButton">
                    <a class="back-home" href="home.jsp" > &#8592; return home </a>

                </form>

            </div>

        </div>
    </div>
</div>

  </body>
</html>