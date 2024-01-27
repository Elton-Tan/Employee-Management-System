<%-- 
    Document   : leave-request-admin
    Created on : 5 Jun 2023, 7:09:28 pm
    Author     : ERMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
  <link rel="stylesheet" type="text/css" href="leave-request-admin.css">
  <link rel="stylesheet" href="admin-dashboard.css">
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
  <script type="text/javascript" src="gridforms/gridforms.js"></script>
  <link rel="stylesheet" href="modal2.css">

  <!--bootstrap-->
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/reset.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/bootstrap-3.3.7-min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <!--end-->

</head>
<body onload="disable()">
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
            <a href="javascript:void(0);"><span class="fa fa-power-off"></span>Log Out</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
</header>
  <h3 style="text-align:center;">View Employee Leave</h3>
  <div style="float:right; margin-right:50px;" class="back-home">
<img src="https://cdn.iconscout.com/icon/premium/png-512-thumb/home-426-287913.png" height="20px;" alt="">  <span style="margin-left:5px;"> <a href= "AdminDashboard">Back to Dashboard </a></span>
</div>

<br><br>

  <form class="grid-form" action="LeaveRequestAdmin" method="post" style="width:75%; margin-left:13%;" onSubmit="insertHTML()">
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
        <legend>Type Of Leave Taken</legend>
        <div data-row-span="4">
          <div data-field-span="1">
            <label>Current Balance of Annual Leave </label>
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
            <label>Number Of Days</label>
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
            <input type="text" value="${sick_start}" name="sick_start" disabled>
          </div>
          <div data-field-span="1">
            <label>End Date</label>
            <input type="text" value="${sick_end}" disabled >
          </div>
          <div data-field-span="1">
            <label>Number Of Days</label>
            <input type="number" value="${sick_nol}" name="sick_nol" disabled>
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
        <legend style="color:red">For Admin Action</legend>
        <div data-row-span="4">
          <div data-field-span="1">
            <label>Approver </label>
            <span>Admin</span>
          </div>
                <script>
                    //ADMIN CANNOT UPDATE FORM ANYMORE ONCE ITS APPROVED OR REJECTED
                    function disable(){
                   if (String(document.getElementsByName("FormAct")[0].value) !== "Pending") {
                      //update and reject dropdown is disabled hehehee
                      document.getElementsByName("remark")[0].disabled = true; //we disable the remark
                      document.getElementsByName("action")[0].disabled = true;
                      document.getElementsByName("update")[0].style.display = "none"; //we hide the button so admin cannot submit hehe
                   
                   if (document.getElementsByName('FormAct')[0].value === 'Approve') {
                       document.getElementsByName('action')[0].value = "Approve"; //set dropdown default value
                   }
                   
                   else if (document.getElementsByName('FormAct')[0].value === 'Reject') {
                       document.getElementsByName('action')[0].value = "Reject";
                   }
           }
           
                 if (document.getElementsByName("sick_start")[0].value === null ) {
                     document.getElementsByName("sick_nol")[0].value = 0;
                     
                 }
      }           //if admin rejects leave
                    function rejreq() {
                    if(document.getElementsByName("action")[0].value === 'Reject') {
                        document.getElementsByName("remark")[0].required = true; //then remarks become required to fill in
                }
                    }
                    </script>
          <div data-field-span="1">
            <label>Action </label>
            <select class="" name="action" style="border:none;" onchange="rejreq()">
            <option value="Approve">Approve</option>
            <option value="Reject">Reject</option>

            </select>
          </div>
          <div data-field-span="2">
            <label>Date of Action </label>
            <span>${current}</span>
          </div>

        </div>
          
        <div data-row-span="4">
          <div data-field-span="4">
            <label>Remarks (Required if Rejected)</label>
            <input type="text" name="remark" value="${remark}">
          </div>
        </div>
      </fieldset>
    <br>
  </form>

<a style="" href = "ViewAllLeave"> View All Leave Requests </a>
<!-- modal start -->
<input class="pop-up-button"  style="display:block; float:right;" type="submit" name="update" value="Update" >
  
<input name='FormAct' value="${action}" hidden/>

<!-- modal start -->
    <div name="modal-insert">
    </div>
 
        <!--we insert the success pop up when submit is DONEEE -->
    <script>
        function insertHTML(){
document.getElementsByName("modal-insert")[0].innerHTML =
    `<div class="pop-up" style="margin-top:-350px;">
    <!-- <span class="cross">x</span> -->
    <div class="pop-up-text">
      <h1 style="padding-top:30px;">Action Submitted Successfully</h1>
      <p>The leave has been sent successfully. You will be redirected to your dashboard in 3 seconds</p>
      <img style="margin-left:40%;" src="https://tse1.mm.bing.net/th?id=OIP.8WbIrvh6UlckcGsf7-m2JQHaHa&pid=Api&P=0&h=180" width="100px;"/>
    </div>

  </div>`;
    }
  </script>
  
<!-- modal end -->
<br><br><br><br>
</body>

</html>
