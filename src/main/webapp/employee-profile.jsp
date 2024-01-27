<%-- 
    Document   : employee-profile
    Created on : 5 Jun 2023, 6:50:06 pm
    Author     : ERMS
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.connection.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="employee-profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <title></title>
  </head>
  <body onload="change()">    
    <div class="my-app">
  <main>
    <!-- Begin content header -->
    <section class="my-app__header">
      <div class="container">
        <div class="my-app__header-inner">
          <div class="my-app__header-text media">
            <svg class="mr-3" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="80" height="80" viewBox="0 0 80 80">
              <defs>
                <style>
                  .a {
                    fill: #9ea0a5;
                  }

                  .b {
                    clip-path: url(#a);
                  }
                </style>
                <clipPath id="a">
                  <circle class="a" cx="40" cy="40" r="40" transform="translate(166 101)" />
                </clipPath>
              </defs>
              <g class="b" transform="translate(-166 -101)">
                <image width="82" height="82" transform="translate(165 100)" xlink:href="https://media.istockphoto.com/photos/female-portrait-icon-as-avatar-or-profile-picture-picture-id477333976?k=6&m=477333976&s=170667a&w=0&h=Hu489jdeRD46pyY-9QMu7Ob2YrRGnphRzbfGV7WPfa8=" />
              </g>
            </svg>
                              <%
String email = (String) session.getAttribute("userEmail");
String name = (String) session.getAttribute("name");
String annual = session.getAttribute("annual")+" Days";
String sick =  session.getAttribute("sick")+" Days";
String role = (String) session.getAttribute("role");

Date joinDate = (Date) session.getAttribute("join");
String effect = null;
if (joinDate != null) {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    effect = dateFormat.format(joinDate);
}
%>
            <div class="media-body">
              <h1 class="my-app__header-title">Welcome Back, <%= name %></h1>
              <div class="my-input input-group mb-4">

              <div class="dropdown">
                <span style="font-size:15px; margin-left:5px;">Account Settings  &#x25BC; </span>
                <div class="dropdown-content">
                    <a href = "reset.jsp" style="padding:10px;"> Reset Password </a>
                    <br>
                <a href="Logout" style="padding:10px;">Log Out</a>
                <br>

                </div>
              </div>
              <!--
                <a href = "login.html"> <button type="button" name="button" style="border-width:thin;">Log Out</button> </a>
                <a href = "login.html"> <button type="button" name="button" style="border-width:thin; margin-left:10px; position:absolute; width:120px;">Reset Password</button> </a>
                -->
              </div>
            </div>
          </div>
          <div class="my-action-buttons my-app__header__buttons">
            <a href = "RequestLeave" ><button class="my-action-button">
              <img class="" width="50px" src="https://cdn0.iconfinder.com/data/icons/flat-designed-circle-icon-2/1000/mail.png" alt>
              <br>
              <span style="color:blue;">Request Leaves</span>
            </button>
            </a>
          </div>
        </div>
      </div>
    </section>
    <!-- End content header -->

    <!-- Begin content body -->
    <section class="my-app__body">
      <div class="container">
        <div class="row">
          <div class="col-4">
            <!-- Begin Payment Balance card -->
            <div class="my-card card">
              <div class="my-card__header card-header">
                <div class="my-card__header-title">
                  <div class="my-text-overline">Total Annual Leave Balance</div>
                  <h3 class="my-text-headline"><%= annual %></h3>
                </div>

              </div>
              <div class="my-card__body card-body">
                <div class="my-text-overline">Leave Breakdown</div>
                <dl class="my-list my-list--definitions my-dl">
                  <dt>Annual Leave Balance</dt>
                  <dd><%= annual %></dd>
                  <dt>Paid Sick Leave Balance</dt>
                  <dd><%= sick %></dd>
                </dl>
                <hr class="my-divider">
                <p style="color:gray;">Every employee is entitled to 14 days annual leave and 60 days paid sick leave</p>
              </div>
            </div>
            <!-- End Payment Balance card -->

            <!-- Begin Bank Accounts card -->
            <div class="my-card card">
              <div class="my-card__body card-body">
                <div class="my-text-overline">Job Information</div>
                <ul class="my-list my-list--simple list-inline mb-0">
                  <li class="my-list-item">
                    <span><%= role %></span>
                  </li>

                  <li class="my-list-item">
                    <span class="my-list-item__text">Effective Employee from <%= effect %></span>
                  </li>

                </ul>
                <hr class="my-divider">
                <span><img src="img/logo.jpg" height="75px;" style="float:right;" alt=""></span>
                <ul class="my-list-inline list-inline mb-0">

                </ul>
              </div>
            </div>
            <!-- End Bank Accounts card -->
          </div>

          <div class="col-8">
            <div class="my-alert alert alert-info">
              <img class="my-alert__icon" src="./images/icon-alert.svg" alt>
              <span class="my-alert__text">
                All of your pending leave requests will show up here.
              </span>
            </div>

              <script>
                  function myFunction() {
                    var input, filter, ul, li, i, txtValue, p;
                    input = document.getElementsByName("dropdownfilter")[0].value; //get the value from the filter
                    filter = input.toUpperCase(); //convert to uppercase
                    ul = document.getElementsByName("myUL2")[0]; 
                    li = ul.getElementsByTagName("li"); //get how many li in the element ul
                    for (i = 0; i < li.length; i++) { 
                        p = li[i].getElementsByTagName("p")[2]; //get the 3rd <p> in the li 
                        txtValue = p.textContent || p.innerText; //get the value of the third <p>
                        if (txtValue.toUpperCase().indexOf(filter) > -1) { //if the value of <p> is = toe filter
                            li[i].style.display = ""; // show the resullt
                        } else {
                            li[i].style.display = "none";//else hide the result
                        }
                    }
                }
                
                //dynamically change color of approve and reject
                function change() {
                    var ul, li, i, txtValue, p;
                    ul = document.getElementsByName("myUL2")[0]; 
                    li = ul.getElementsByTagName("li"); //get how many li in the element ul
                    for (i = 0; i < li.length; i++) { 
                        p = li[i].getElementsByTagName("p")[2]; //get the 3rd <p> in the li 
                        txtValue = p.textContent || p.innerText;
                        if (txtValue === "Reject") {
                        p.style.color='red'; //set reject to red
                    }
                    }
                }
              </script>
            <!-- Begin Pending card -->
            <div class="my-card card">
              <div class="my-card__header card-header">
                <h3 class="my-card__header-title card-title">Pending Leave Requests</h3>
              </div>
                <c:forEach items="${leaveList}" var="leave">
              <ul class="my-list list-group list-group-flush" name="myUL">
                <li class="my-list-item list-group-item">
                        <b><p>#${leave.leaveId}</p></b>
                  <div class="my-list-item__date">

                    <span class="my-list-item__date-day">${leave.dateOfRequest}</span>
                    <span class="my-list-item__date-month">Requested on:</span>
                  </div>
                  <br>
                  <div class="my-list-item__text">
                    <h6 class="">${leave.type} Leave from ${leave.startDate} to ${leave.endDate}</h6>
                    <p style="color:gray;">${leave.reason}</p>
                  </div>

                  <br>
                  <div class="my-list-item__fee">
                    <span><a href="ViewLeaveEmployee?leave_id=${leave.leaveId}"> View Info </a></span>
                  </div>
                </li>
              </ul>
              </c:forEach>
            </div>
            <!-- End Pending card -->

            <!-- Begin Completed card -->
            <div style="display:inline-block;">
            <select class="" name="dropdownfilter" style="border:none; float:right;" onchange="myFunction()">
              <option value="Approve">Filter by Approved</option>
              <option value="Reject">Filter by Rejected</option>
              <option value="" selected="selected">Show All Leaves</option>
            </select>
            </div>
            <br><br>
            <div class="my-card card" style="max-height:350px; overflow-y:scroll">
              <div class="my-card__header card-header">
                <h3 class="my-card__header-title card-title">Completed Leave Requests</h3>
              </div>
                
                  <ul class="my-list list-group list-group-flush" name="myUL2">
                   <c:forEach items="${leaveList1}" var="leave1">
               
                <li class="my-list-item list-group-item"  onload="change()">
                    <b><p>#${leave1.leaveId}</p></b>
                  <div class="my-list-item__date">
                    <span class="my-list-item__date-day">${leave1.dateOfRequest}</span>
                    <span class="my-list-item__date-month">Requested on:</span>
                  </div>
                  <br>
                  <div class="my-list-item__text">
                    <h6 class="">${leave1.type} Leave from ${leave1.startDate} to ${leave1.endDate}</h6>
                    <p style="color:gray;">${leave1.reason}</p>

                  </div>

                  <br>
                
                  <div class="my-list-item__fee">
                    <p name="action-color" style="color:green;">${leave1.action}</p>
                    <span><a href="ViewLeaveEmployee?leave_id=${leave1.leaveId}"> View Info </a></span>
                  </div>
                </li>
                  </c:forEach>
              </ul>
           
            </div>
            <!-- End Completed card -->
          </div>
        </div>
      </div>
    </section>
    <!-- End content body -->
  </main>
</div>
  </body>
</html>
