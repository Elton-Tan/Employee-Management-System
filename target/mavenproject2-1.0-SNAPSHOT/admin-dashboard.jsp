<%-- 
    Document   : admin-dashboard
    Created on : 5 Jun 2023, 7:04:40 pm
    Author     : ERMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="admin-dashboard.css">

    <!--bootstrap-->
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/reset.min.css">
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/bootstrap-3.3.7-min.css">
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
    <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
    <!--end-->
    <style media="screen">
      * {
        overflow-x: hidden;
      }
    </style>

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
        <a href="javascript:void(0);" id="user-profile" title="Manage"><span class="fa fa-user-circle"></span>Admin Account  <span class="fa fa-caret-down"></span></a>
      </div>



  </div>
</header>
<div class="col-xs-6 col-md-12 text-right" id="account">
    <a href="Logout"<button type="button" name="button" style="width:75px; margin-right:20px;"> <img src="http://freevector.co/wp-content/uploads/2014/07/16076-logout-sign1.png" style="margin-right:5px;" height="20px;" alt="">Log Out </button>
</div>
<div class="container">
  <div class="visible-xs visible-sm" id="project-details">
    <a class="home-link" href="" title="BMIC Identity Server Home"><span class="fa fa-home"></span></a>
    <div class="project">
      Manage Employees
    </div>
    <div class="clearfix"></div>
  </div>

  <div class="row">
    <div class="col-md-3">
      <div class="panel panel-default" id="employee-update">
        <div class="panel-body text-center">
          <span class="fa fa-id-card-o"><img src="http://endlessicons.com/wp-content/uploads/2012/12/email-icon.png" height="100px;"alt=""></span>
          <h3>
            View All Leave Requests
          </h3>
        </div>
        <div class="panel-footer text-center">
          <a class="btn btn-primary" href="ViewAllLeave">View Requests</a>
        </div>
      </div>
    </div>
    <div class="col-md-9">
  <h3>
    Outstanding Leave Requests
  </h3>
  <table class="table-responsive">
    <tr>
      <th>Leave ID</th>
      <th>Name</th>
      <th>Leave Period</th>
      <th>Status</th>
      <th>Date of Request</th>
      <th></th>
    </tr>
    <c:forEach items="${leaveList}" var="leave">
      <tr>
        <td>${leave.leaveId}</td>
        <td><a href="ReadEmployeeAdmin?emp_id=${leave.empId}">${leave.empName}</a></td>
        <td>${leave.startDate} to ${leave.endDate}</td>
        <td>${leave.action}</td>
        <td>${leave.dateOfRequest}</td>
        <td><a href="LeaveRequestAdmin?leave_id=${leave.leaveId}">View Info</a></td>
      </tr>
    </c:forEach>
  </table>
</div>

  </div>
  <div class="row">
    <div class="col-md-3">

      <div class="panel panel-default" id="employee-new">
        <div class="panel-body text-center">
          <span class="fa fa-plus-square-o"><img src="http://cdn.onlinewebfonts.com/svg/img_206976.png" height="50px;" alt=""></span>
          <h3>
            Add Employee
          </h3>
        </div>
        <div class="panel-footer text-center">
          <a class="btn btn-primary" href="AddEmployee">Add Employee</a>
        </div>
      </div>
    </div>

    <div class="col-md-9">
      <h3>
        Employees List
      </h3>
        <!-- start filter -->
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
        
          function sortTable() {
          //sorting by alphabetical order start
          var table, rows, switching, i, x, y, shouldSwitch;
          if(document.getElementsByName("sorting")[0].value === "Sort by Alphabetical Order"){
          table = document.getElementsByName("table")[0];
          switching = true;
          /*Make a loop that will continue until
          no switching has been done:*/
          while (switching) {
            //start by saying: no switching is done:
            switching = false;
            rows = table.rows;
            /*Loop through all table rows (except the
            first, which contains table headers):*/
            for (i = 1; i < (rows.length - 1); i++) {
              //start by saying there should be no switching:
              shouldSwitch = false;
              /*Get the two elements you want to compare,
              one from current row and one from the next:*/
              x = rows[i].getElementsByTagName("td")[1];
              y = rows[i + 1].getElementsByTagName("td")[1];
              //check if the two rows should switch place:
              if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                //if so, mark as a switch and break the loop:
                shouldSwitch = true;
                break;
              }
            }
            if (shouldSwitch) {
              /*If a switch has been marked, make the switch
              and mark that a switch has been done:*/
              rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
              switching = true;
            }
          }
        }
       //end sort by alphabetical order
       
       //sort by ID start
        else if (document.getElementsByName("sorting")[0].value === "Sort by Employee ID")     
        {
                    var table, rows, switching, i, x, y, shouldSwitch;
                    table = document.getElementsByName("table")[0];
                    switching = true;
                    /*Make a loop that will continue until
                    no switching has been done:*/
                    while (switching) {
                    //start by saying: no switching is done:
                    switching = false;
                    rows = table.rows;
                    /*Loop through all table rows (except the
                    first, which contains table headers):*/
            for (i = 1; i < (rows.length - 1); i++) {
              //start by saying there should be no switching:
              shouldSwitch = false;
              /*Get the two elements you want to compare,
              one from current row and one from the next:*/
              x = rows[i].getElementsByTagName("td")[0];
              y = rows[i + 1].getElementsByTagName("td")[0];
              //check if the two rows should switch place:
              if (Number(x.innerHTML) > Number(y.innerHTML)) {
                //if so, mark as a switch and break the loop:
                shouldSwitch = true;
                break;
              }
            }
            if (shouldSwitch) {
              /*If a switch has been marked, make the switch
              and mark that a switch has been done:*/
              rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
              switching = true;
            }
          }
                }
        //end sort by Employee ID
        
        //start sort by OLDEST Employee
        else if (document.getElementsByName("sorting")[0].value === "Sort by Oldest Employee"){
            var table, rows, switching, i, x, y, shouldSwitch;
            table = document.getElementsByName("table")[0];
            switching = true;
            /*Make a loop that will continue until
            no switching has been done:*/
            while (switching) {
            //start by saying: no switching is done:
            switching = false;
            rows = table.rows;
                    /*Loop through all table rows (except the
                    first, which contains table headers):*/
            for (i = 1; i < (rows.length - 1); i++) {
              //start by saying there should be no switching:
              shouldSwitch = false;
              /*Get the two elements you want to compare,
              one from current row and one from the next:*/
              x = rows[i].getElementsByTagName("td")[2];
              y = rows[i + 1].getElementsByTagName("td")[2];
              //check if the two rows should switch place:
              if (new Date(x.innerHTML) > new Date(y.innerHTML)) {
                //if so, mark as a switch and break the loop:
                shouldSwitch = true;
                break;
              }
            }
            if (shouldSwitch) {
              /*If a switch has been marked, make the switch
              and mark that a switch has been done:*/
              rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
              switching = true;
            }
          }
        }
        //end sort by OLDEST employee
        
        //start sort by newest employee
            else if (document.getElementsByName("sorting")[0].value === "Sort by Newest Employee"){
            var table, rows, switching, i, x, y, shouldSwitch;
            table = document.getElementsByName("table")[0];
            switching = true;
            /*Make a loop that will continue until
            no switching has been done:*/
            while (switching) {
            //start by saying: no switching is done:
            switching = false;
            rows = table.rows;
                    /*Loop through all table rows (except the
                    first, which contains table headers):*/
            for (i = 1; i < (rows.length - 1); i++) {
              //start by saying there should be no switching:
              shouldSwitch = false;
              /*Get the two elements you want to compare,
              one from current row and one from the next:*/
              x = rows[i].getElementsByTagName("td")[2];
              y = rows[i + 1].getElementsByTagName("td")[2];
              //check if the two rows should switch place:
              if (new Date(x.innerHTML) < new Date(y.innerHTML)) {
                //if so, mark as a switch and break the loop:
                shouldSwitch = true;
                break;
              }
            }
            if (shouldSwitch) {
              /*If a switch has been marked, make the switch
              and mark that a switch has been done:*/
              rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
              switching = true;
            }
          }
        }
        
        //end all sort
    }
        </script>
<!-- end filter & sort -->

      <div class = "hq">
            <input type="text" name="filterinput" value="" placeholder = "Search Name.." onkeyup="myFilter()" width="150%;">
            <select class="" name="sorting" style="float:right;margin-right:20px; border:none;" onchange="sortTable();">
              <option> Sort by Employee ID</option>
                <option> Sort by Alphabetical Order</option>
                <option> Sort by Newest Employee</option>
                  <option> Sort by Oldest Employee</option>
            </select>
      <table class="table-responsive" id="table" name="table" style="height:10px;">
    <tr>
        <th>Employee ID</th>
        <th>Name</th>
        <th>Effective Date</th>
        <th>Position</th>
        <th colspan="2"></th>
    </tr>
    <c:forEach var="employee" items="${employeeList}">
        <tr>
            <td>${employee.employeeID}</td>
            <td>${employee.name}</td>
            <td>${employee.effectiveDate}</td>
            <td>${employee.position}</td>
            <td><a href="ReadEmployeeAdmin?emp_id=${employee.employeeID}">View & Edit</a></td>
            <td><a href="DeleteAdminEmployee?emp_id=${employee.employeeID}" style="color:red;">Terminate</a></td>
        </tr>
    </c:forEach>
</table>

      </div>
    </div>
  </div>
  <div class="row">


  </div>
</div>

  </body>
</html>
