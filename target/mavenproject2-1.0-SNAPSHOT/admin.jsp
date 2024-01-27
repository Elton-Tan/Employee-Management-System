<%-- 
    Document   : admin
    Created on : 5 Jun 2023, 7:02:54 pm
    Author     : Elton
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <header class="header">Admin Login</header>
                <br>
                <header class="subHeader" style="color:red;">Please note that this login page is for Admins only</header>

                <form action="AdminLogin" method="post">
                           <%
                                    //Connecting to the database
                                    Connection connection = DatabaseConnection.getConnection();
                                    Statement statement = connection.createStatement();
                                    String credential = (String) session.getAttribute("credential");
                                    //Checking creditionals whether there are null or not
                                    if (credential != null) {
                                        session.removeAttribute("credential");
                                %>
                                <div class="alert alert-danger" id="danger">You have enter wrong credentials.</div>
                                <%
                                    }
                                %>
                    <div class="inputContainer">
                        <label class="label" for="emailAddress"><img src="https://tse3.mm.bing.net/th?id=OIP.otGG6FwCkS5_nGk8AvRnXwHaHr&pid=Api&P=0&h=180" class="labelIcon"><span>Email*</span></label>
                        <input type="email" class="input" name="email" id="emailAddress" placeholder="Enter Email Address">
                    </div>
                    <div class="inputContainer">
                        <label class="label" for="emailAddress"><img src="https://i.imgur.com/g5SvdfG.png"
                                class="labelIcon"><span>Password*</span></label>
                                <input type="password" class="input" name="password" id="emailAddress" placeholder="Enter Password">
                    </div>
                    <div class="OptionsContainer">
                        <div class="checkboxContainer">
                          <!--  <input type="checkbox" id="RememberMe" class="checkbox"> <label for="RememberMe">Remember
                                me</label> -->
                        </div>
                        <a href="#" class="ForgotPasswordLink"><!-- SHOULD ADMIN EVEN HAVE A FORGET PASSWORD? --></a>
                    </div>

                <button class="LoginButton" style="margin-bottom:30px;">Login</button>
                    <a class="back-home" href="home.jsp" > &#8592; return home </a>

                </form>

            </div>

        </div>
    </div>
</div>

  </body>
</html>
