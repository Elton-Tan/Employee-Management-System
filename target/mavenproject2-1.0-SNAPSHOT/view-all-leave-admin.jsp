<%-- 
    Document   : view-all-leave-admin
    Created on : 5 Jun 2023, 7:21:33 pm
    Author     : ERMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/reset.min.css">
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/bootstrap-3.3.7-min.css">
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">

    <link rel="stylesheet" href="admin-dashboard.css">
  </head>
  <body>
    <header>
  <div class="container">
    <div class="row">
      <div class="col-xs-6 col-md-8">
        <div class="row">
          
          <div class="col-sm-9 hidden-sm hidden-xs" id="project-details">
            <a class="home-link" href="javascript:void(0);" title="BMIC Identity Server Home"><span class="fa fa-home"></span></a>
            <div class="project">
              ERMS
            </div>
          </div>
        </div>
      </div>
      <div class="col-xs-6 col-md-4 text-right" id="account">
        <a href="javascript:void(0);" id="user-profile" title="Manage"><span class="fa fa-user-circle"></span>Admin Account <span class="fa fa-caret-down"></span></a>
        <div id="account-options">
          <ul>
            <li>
              <a href="https://codepen.io/bmico/live/ZZZBGx"><span class="fa fa-user"></span>View Profile</a>
            </li>
            <li>
              <a href="javascript:void(0);"><span class="fa fa-cog"></span>Settings</a>
            </li>
            <li>
              <a href="javascript:void(0);"><span class="fa fa-bug"></span>Report a Bug </a>
            </li>
            <li>
              <a href="Logout"><span class="fa fa-power-off"></span>Log Out</a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</header>
<div style="float:right; margin-right:50px;" class="back-home">
<img src="https://cdn.iconscout.com/icon/premium/png-512-thumb/home-426-287913.png" height="20px;" alt="">  <span style="margin-left:5px;"> <a href= "AdminDashboard">Back to Dashboard </a></span>
</div>


    <div class="col-md-9">
      <h3>
        View All Leaves
      </h3>
        <script>
          function myFilter() {
          var input, filter, table, tr, td, i, txtValue;
          input = document.getElementsByName("filterinput");
          filter = input[0].value.toUpperCase();
          table = document.getElementsByName("table")[0];
          tr = table.getElementsByTagName("tr");

          for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[1];

            if (td) {
              txtValue = td.textContent || td.innerText;
              if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
              } else {
                tr[i].style.display = "none";
              }
            }       
          }
        }
        
             function myDropDownFilter() {
          var input, filter, table, tr, td, i, txtValue;
          input = document.getElementsByName("DropDown")[0].value;
          filter = input.toUpperCase();
          table = document.getElementsByName("table")[0];
          tr = table.getElementsByTagName("tr");

          for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[3];

            if (td) {
              txtValue = td.textContent || td.innerText;
              if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
              } else {
                tr[i].style.display = "none";
              }
            }       
          }
        }
        </script>
      <div style="width:130%;">
      <select class="" name="DropDown" style="border:none; float:right; margin-left:50px;" onchange="myDropDownFilter()">
      <option value="Approve">Filter by Approved</option>
      <option value="Reject">Filter by Rejected</option>
      <option value="Pending">Filter by Pending</option>
      <option value="" selected="selected">Show All Status</option>
      </select>
      </div>
      <input type="text" name="filterinput" value=""  onkeyup="myFilter()" style="width:300px;height:25px; border-radius:5px; border-width:1px; padding-left:2px;" placeholder="Search Name...">
      <br>

      <table class="table-responsive" name="table" style="width:130%; max-height:400px; overflow-y:scroll;">
        <tr>
          <th>
            Leave ID
          </th>
          <th>
            Name
          </th>
          <th>
            Leave Period
          </th>
          <th>
            Status
          </th>
          <th>
            Date of Request
            </th>

            <th>
              Reason
              </th>
              <th>
              Contact Number
              </th>
              <th>
              Leave Detail
              </th>
            <th>

          <th>

          </th>
        </tr>
        <c:forEach items="${leaveList}" var="leave">
        <tr>
           <td>${leave.leaveId}</td>
           <td> <a href = "ReadEmployeeAdmin?emp_id=${leave.empId}">${leave.empName} </a></td>
            <td>${leave.startDate} to ${leave.endDate}</td>
            <td>${leave.action}</td>
            <td>${leave.dateOfRequest}</td>
            <td>${leave.reason}</td>
            <td>${leave.contact}</td>
            <td> <a href="LeaveRequestAdmin?leave_id=${leave.leaveId}"> View Info </a> </td>
        </tr>
</c:forEach>
       
      </table>
  </body>
</html>

