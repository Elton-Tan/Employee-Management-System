<%-- 
    Document   : add-employee-admin
    Created on : 5 Jun 2023, 7:12:58 pm
    Author     : ERMS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en" >
    <head>
  <meta charset="UTF-8">
  <link href="https://fonts.googleapis.com/css?family=Poppins:400,600&display=swap" rel="stylesheet">
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css'>
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/reset.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/bootstrap-3.3.7-min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <link rel="stylesheet" href="add-employee-admin.css">
    <link rel="stylesheet" href="admin-dashboard.css">
     <link rel="stylesheet" href="modal2.css">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
  <script type="text/javascript" src="gridforms/gridforms.js"></script>
    </head>

    
<body>




<header class="header">
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
      <a href="#" id="user-profile" title="Manage"><span class="fa fa-user-circle"></span>Admin Account <span class="fa fa-caret-down"></span></a>
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
                 
  <h1 class="header__title">Add Employee</h1>

  <div style="float:right; margin-right:50px;" class="back-home">
<img src="https://cdn.iconscout.com/icon/premium/png-512-thumb/home-426-287913.png" height="20px;" alt="">  <span style="margin-left:5px;"> <a href= "AdminDashboard">Back to Dashboard </a></span>
</div>
<div class="content">
  <div class="content__inner">
    <div class="container">
    </div>
    <div class="container overflow-hidden">
      <div class="multisteps-form">
        <div class="row">
          <div class="col-12 col-lg-8 ml-auto mr-auto mb-4">
            <div class="multisteps-form__progress">
              <button class="multisteps-form__progress-btn js-active" type="button" title="User Info">Employee Personal Info</button>
              <button class="multisteps-form__progress-btn" type="button" title="Address" onclick="level1()">Employee Address</button>
              <button class="multisteps-form__progress-btn" type="button" title="Order Info" onclick="level2()">Job Info</button>
              <button class="multisteps-form__progress-btn" type="button" title="Message" onclick="level3()">Overview</button>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12 col-lg-8 m-auto">
              
              <div class ="alert alert-success" role="alert" name="success" hidden> success </div>
              <form class="multisteps-form__form" action="AddEmployee" method="post" onsubmit="insertHTML()">
              <div class="multisteps-form__panel shadow p-4 rounded bg-white js-active" data-animation="scaleIn">
                

                  <h3 class="multisteps-form__title">Employee Info</h3>
                  <br>
                  <!--IF EMPLOYEE ALREADY EXIST THEN SHOW ERROR MSG -->
                  <%
String errorMessage = (String) request.getSession().getAttribute("errorMessage");
request.getSession().removeAttribute("errorMessage"); // Remove the error message from the session
if (errorMessage != null && !errorMessage.isEmpty()) {
%>

<h1 style="padding-top:30px; text-align: center;">Something went wrong</h1>
<div class ="alert alert-danger" role="alert" name="danger"> <%= errorMessage %>. Please wait for 5 seconds </div>
<script>
    // Get the current URL
    var currentURL = window.location.href;

    // Check if the current URL is not "AddEmployee"
    if (currentURL.indexOf("AddEmployee") === -1) {
        // Wait for 10 seconds and then redirect to the "AddEmployee" URL
        setTimeout(function() {
            window.location.href = "AddEmployee";
        }, 5000); // 10000 milliseconds = 10 seconds
    }
</script>
<%
request.getSession().removeAttribute("errorMessage"); //remove the message once page reloads

}
%>


<!-- success start SHOW EMPLOYEE ADDED SUCCESS-->

<br>
                  <%
String successMessage = (String) request.getSession().getAttribute("successMessage");
request.getSession().removeAttribute("successMessage"); // Remove the error message from the session
if (successMessage != null && !successMessage.isEmpty()) {
%>


<div class ="alert alert-success" role="alert" name="success"> <%= successMessage %>... Redirecting to admin dashboard in 5 seconds... </div>
<script>
    // Get the current URL
    var currentURL = window.location.href;

    // Check if the current URL is not "AddEmployee"
    if (currentURL.indexOf("AddEmployee") === -1) {
        // Wait for 10 seconds and then redirect to the "AddEmployee" URL
        setTimeout(function() {
            window.location.href = "AdminDashboard";
        }, 5000); // 10000 milliseconds = 10 seconds
    }
</script>
<%
request.getSession().removeAttribute("successMessage"); //remove msg once page reloads
}

%>


                <div class="multisteps-form__content">

                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-2">
                      <input class="multisteps-form__input form-control" type="text" name="empId" value="${newEmpId}" disabled/>

                    </div>
                  </div>

                    <span style="color:red; font-size:13px;">*Employee ID is self generated</span>
                  <div class="form-row mt-4">

                    <div class="col-12 col-sm-6">
                      <span>First Name: </span>
                      <input class="multisteps-form__input form-control" id="first-name" name="first" type="text" placeholder="Enter Employee's First Name"/>
                    </div>

                    <div class="col-12 col-sm-6 mt-4 mt-sm-0">
                        <span>Last Name: </span>
                        <input class="multisteps-form__input form-control" id="last-name" name="last" type="text" placeholder="Enter Employee's Last Name"/>
                    </div>

                  </div>
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Date of Birth: </span>
                        <input class="multisteps-form__input form-control" id="dob " name="dob" type="date" placeholder="Date of Birth"/>
                    </div>

                    <div class="col-12 col-sm-6 mt-4 mt-sm-0">

                      <p>Select Gender:</p>
                      <input type="radio" id="html" name="gender" value="Male">
                      <label for="html">Male</label>
                     <input type="radio" id="css" name="gender" value="Female" style="margin-left:30px;">
                    <label for="html">Female</label>


                    </div>
                      <script>
                          //this script is to save all data for overview!
                          function level1()
                          {
                               var firstName = document.getElementsByName("first")[0].value;
  var lastName = document.getElementsByName("last")[0].value;

  // Concatenate the first name and last name
  var fullName = firstName + " " + lastName;

  // Set the concatenated value in another field
  var fullNameInput = document.getElementsByName("fullname")[0];
  fullNameInput.value = fullName;
    var dobb = document.getElementsByName("dob")[0].value;
  document.getElementsByName("fulldob")[0].value = dobb;
var genderInputs = document.getElementsByName("gender");
  var selectedGender = "";

  for (var i = 0; i < genderInputs.length; i++) {
    if (genderInputs[i].checked) {
      selectedGender = genderInputs[i].value;
      break;
    }
  }
  document.getElementsByName("fullgender")[0].value = selectedGender;
  console.log(selectedGender);
  
  var em = document.getElementsByName("email")[0].value;
  document.getElementsByName("fullemail")[0].value = em;
  console.log(selectedGender);
}

function level2(){
    var add = document.getElementsByName("address")[0].value;
    var add1 = document.getElementsByName("address2")[0].value;
    var city = document.getElementsByName("city")[0].value;
    var state = document.getElementsByName("state")[0].value;
    var zip = document.getElementsByName("postal")[0].value;
    
    var ad = add + " "+ add1+" "+ city + " "+state+" "+zip;
    
  document.getElementsByName("fulladdress")[0].value = ad;
}
function level3(){
     var em1 = document.getElementsByName("doj")[0].value;
  document.getElementsByName("fulldoj")[0].value = em1;
   var em2 = document.getElementsByName("role")[0].value;
  document.getElementsByName("fullposition")[0].value = em2;
   var em3 = document.getElementsByName("salary")[0].value;
  document.getElementsByName("fullsalary")[0].value = "$"+em3;
   var em4 = document.getElementsByName("term")[0].value;
  document.getElementsByName("fullterm")[0].value = em4+"Years";
  saveAll();
}
                      </script>


                  </div>

                  <div class="form-row mt-4">

                    <div class="col-12 col-sm-12 mt-4 mt-sm-0">
                      <span>Email: </span>
                      <input class="multisteps-form__input form-control" id="email" name="email" type="email" placeholder="Enter Employee Email"/>
                    </div>
                  </div>

                  <br>
                  <span style="color:red; font-size:13px;"> *Employee Password will be auto-generated and sent to them in the email </span>

                  <div class="button-row d-flex mt-4">
                      <button class="btn btn-primary ml-auto js-btn-next" type="button" onclick="level1()" title="Next">Next</button>
                  </div>
                </div>
              </div>

              <div class="multisteps-form__panel shadow p-4 rounded bg-white" data-animation="scaleIn">
                <h3 class="multisteps-form__title">Employee Address</h3>
                <div class="multisteps-form__content">
                  <div class="form-row mt-4">
                    <div class="col">
                        <input class="multisteps-form__input form-control" id="address1" type="text" name="address" placeholder="Address 1"/>
                    </div>
                  </div>
                  <div class="form-row mt-4">
                    <div class="col">
                        <input class="multisteps-form__input form-control" id="address2" type="text" name="address2"  placeholder="Address 2"/>
                    </div>
                  </div>
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <input class="multisteps-form__input form-control" id="city" type="text" name="city" placeholder="City"/>
                    </div>
                    <div class="col-6 col-sm-3 mt-4 mt-sm-0">
                        <input class="multisteps-form__select form-control" id="state" name="state" placeholder="Province"/>
                    
                    </div>
                    <div class="col-6 col-sm-3 mt-4 mt-sm-0">
                        <input class="multisteps-form__input form-control" type="text" id="postal" name="postal" placeholder="Zip"/>
                    </div>
                  </div>
                  <div class="button-row d-flex mt-4">
                    <button class="btn btn-primary js-btn-prev" type="button" title="Prev">Prev</button>
                    <button class="btn btn-primary ml-auto js-btn-next" type="button" onclick="level2()" title="Next">Next</button>
                  </div>
                </div>
              </div>

                <!--look here -->

              <div class="multisteps-form__panel shadow p-4 rounded bg-white" data-animation="scaleIn">
                <h3 class="multisteps-form__title">Employee Job Info</h3>
                <div class="multisteps-form__content">

                    <div class="form-row mt-4">
                      <div class="col-12 col-sm-6">
                          <span>Effective Date: </span>
                          <input class="multisteps-form__input form-control" id="doj" name="doj" type="date" placeholder="Date of Birth"/>
                      </div>
                      <div class="col-12 col-sm-6">
                          <span>Job Position </span>
                          <select class="multisteps-form__input form-control" id="job-position" name="role" type="dropdown" placeholder="Date of Birth"/>
                        <option value="HR"> HR Manager</option>
                          <option value="CFO"> CFO</option>
                            <option value="Accountant"> Accountant</option>
                      </select>
                      </div>

                    </div>
                    <div class="form-row mt-4">
                      <div class="col-12 col-sm-6">
                          <span>Annual Salary ($): </span>
                          <input class="multisteps-form__input form-control" id="annual-salary" name="salary" type="Numbers" placeholder="Enter Annual Salary"/>
                      </div>
                      <div class="col-12 col-sm-6">
                          <span>Contract Term </span>
                          <select class="multisteps-form__input form-control" id="contract-term" name="term" type="dropdown" placeholder="Date of Birth"/>
                        <option value="5"> 5 Years</option>
                          <option value="10"> 10 Years</option>
                            <option value="15"> 15 Years</option>
                      </select>
                      </div>

                    </div>
<script>

 function saveAll() { 
    var length = 10; //set password randomised length
    var charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()";
    var password = "";

    for (var i = 0; i < length; i++) {
      var randomIndex = Math.floor(Math.random() * charset.length);
      password += charset[randomIndex];
    }

    var passwordInput = document.getElementsByName("fullpassword")[0];
    passwordInput.value = password; 
    console.log(password);
  }

</script>
                    
                  <div class="row">
                    <div class="button-row d-flex mt-4 col-12">
                      <button class="btn btn-primary js-btn-prev" type="button" title="Prev">Prev</button>
                      <button class="btn btn-primary ml-auto js-btn-next" type="button" onclick="level3()" title="Next">Next</button>
                    </div>
                  </div>
                </div>
              </div>

              <div class="multisteps-form__panel shadow p-4 rounded bg-white" data-animation="scaleIn">
                <h3 class="multisteps-form__title">Overview</h3>
                <div class="multisteps-form__content">
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-2">
                        <span>Employee ID </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="${newEmpId}" disabled/>
                    </div>
                  </div>
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
  <span>Employee Full Name </span>
  <input class="multisteps-form__input form-control" type="text" name="fullname" required readonly />
</div>
<div class="col-12 col-sm-6">
  <span>Email: </span>
  <input class="multisteps-form__input form-control" type="email" name="fullemail" required readonly/>
</div>
</div>
<div class="form-row mt-4">
<div class="col-12 col-sm-6">
  <span>Date of Birth: </span>
  <input class="multisteps-form__input form-control" type="date" name="fulldob" required readonly/>
</div>
<div class="col-12 col-sm-6">
  <span>Gender: </span>
  <input class="multisteps-form__input form-control" type="text" name="fullgender" required readonly/>
</div>
</div>
<div class="form-row mt-4">
<div class="col-12 col-sm-12">
  <span>Address </span>
  <input class="multisteps-form__input form-control" type="Numbers" name="fulladdress" required readonly />
</div>
</div>
<div class="form-row mt-4">
<div class="col-12 col-sm-6">
  <span>Effective Date: </span>
  <input class="multisteps-form__input form-control" type="date" name="fulldoj" required readonly/>
</div>
<div class="col-12 col-sm-6">
  <span>Job Position: </span>
  <input class="multisteps-form__input form-control" type="text" name="fullposition" required readonly/>
</div>
</div>
<div class="form-row mt-4">
<div class="col-12 col-sm-6">
  <span>Annual Salary: </span>
  <input class="multisteps-form__input form-control" type="Numbers" name="fullsalary" required readonly />
</div>
<div class="col-12 col-sm-6">
  <span>Contract Term: </span>
  <input class="multisteps-form__input form-control" type="text" name="fullterm"  required readonly/>
</div>
</div>
<div class="form-row mt-4">
<div class="col-12 col-sm-12">
  <span>Password </span>
  <input class="multisteps-form__input form-control" name="fullpassword" type="password" placeholder="Auto-generated password" readonly/>
  <span style= "color:red; font-size:12px;"> *Password is computer-generated </span>
</div>
</div>


                  </div>

                  <div class="button-row d-flex mt-4">
                    <button class="btn btn-primary js-btn-prev" type="button" title="Prev">Prev</button>
                    <button class="btn btn-success ml-auto" type="submit" title="Send" onclick="Success()">Add Employee</button>

                  </div>
                </div>
              </div>
            </form>
                  
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


    <div name="modal-insert">
    </div>
 
    <script>

  </script>
 

<script src="add-employee-admin.js"></script>


</body>
</html>
