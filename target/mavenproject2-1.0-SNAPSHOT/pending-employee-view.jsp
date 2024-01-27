<%-- 
    Document   : pending-employee-view
    Created on : 5 Jun 2023, 7:00:49 pm
    Author     : ERMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
  <link rel="stylesheet" type="text/css" href="leave-request-admin.css">
  <link rel="stylesheet" href="admin-dashboard.css">
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
  <script type="text/javascript" src="gridforms/gridforms.js"></script>

  <!--bootstrap-->
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/reset.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/bootstrap-3.3.7-min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <!--end-->

</head>
<body>

  <h3 style="text-align:center;">View Your Leave</h3>
  <div style="float:right; margin-right:50px;" class="back-home">
<img src="https://cdn.iconscout.com/icon/premium/png-512-thumb/home-426-287913.png" height="20px;" alt="">  <span style="margin-left:5px;"> <a href= "EmployeeProfile">Back to Dashboard </a></span>
</div>

<br><br>

  <form class="grid-form" style="width:75%; margin-left:13%;">
    <fieldset>
      <legend>Personal Details</legend>

      <div data-row-span="4">
        <div data-field-span="2" value="">
          <label>Full Name</label>
          <span>${name}</span>
        </div>
        <div data-field-span="2">
          <label>Leave ID</label>
          <label>${leaveid}</label>
        </div>
      </div>
      <div data-row-span="4">
        <div data-field-span="4">
          <label>Contact Number: </label>
          <span>${contact}</span>
        </div>


      </div>
      <div data-row-span="2">
        <div data-field-span="2" data-field-error="Please enter a valid email address">
          <label>Job Title</label>
          <span>${role}</span>
        </div>

      </div>

      <br>
      <fieldset>
        <legend>Type Of Leave Taken As Working Days</legend>
        <div data-row-span="4">
          <div data-field-span="1">
            <label>Current Balance of Annnual Leave </label>
            <span>${annual_balance}</span>
          </div>
          <div data-field-span="1">
            <label>Start Date </label>
            <span>${annual_start}</span>
          </div>
          <div data-field-span="1">
            <label>End Date</label>
            <span>${annual_end}</span>
          </div>
          <div data-field-span="1">
            <label>Number Of Working Days</label>
           ${annual_nol}
          </div>
        </div>

        <div data-row-span="4">
          <div data-field-span="1">
            <label>Normal Sick Leave </label>
            <input type="text" value="${sick_balance}" disabled>
          </div>
          <div data-field-span="1">
            <label>Start Date </label>
            <input type="text" value="${sick_start}" disabled>
          </div>
          <div data-field-span="1">
            <label>End Date</label>
            <input type="text" value="${sick_end}" disabled >
          </div>
          <div data-field-span="1">
            <label>Number Of Working Days</label>
            <input type="number" value="${sick_nol}" disabled>
          </div>
        </div>



        <div data-row-span="4">
          <div data-field-span="4">
            <label>Reason for Leave</label>
            ${reason}
          </div>


        </div>
      </fieldset>

      <br><br>
      <fieldset>
        <legend style="color:red">Status</legend>
        <div data-row-span="4">
          <div data-field-span="1">
            <label>Approver </label>
            <span>Admin</span>
          </div>
          <div data-field-span="1">
            <label>Status </label>
          <label>${action}</label>


          </div>
          <div data-field-span="2">
            <label>Date of Approval </label>
            <label>${doa}</label>
          </div>

        </div>

        <div data-row-span="4">
          <div data-field-span="4">
            <label>Remarks (fill in if leave is rejected)</label>
            <label>${remark}</label>
          </div>

        </div>




      </fieldset>


    <br>


  </form>



<br><br><br><br>
</body>

</html>
