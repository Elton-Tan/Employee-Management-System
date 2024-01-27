<%-- 
    Document   : read-employee-admin
    Created on : 5 Jun 2023, 7:12:03 pm
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
</head>
<body>
<header class="header">
<div class="container">
  <div class="row">
    <div class="col-xs-6 col-md-8">
      <div class="row">
        <div class="col-sm-3">
          <a class="branding" href="javascript:void(0);">LOGO<br />HERE</a>
        </div>
        <div class="col-sm-9 hidden-sm hidden-xs" id="project-details">
          <a class="home-link" href="javascript:void(0);" title="BMIC Identity Server Home"><span class="fa fa-home"></span></a>
          <div class="project">
            GIMME WEBSITE NAME
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
  <h1 class="header__title">Employee Detail</h1>
  <div style="float:right; margin-right:50px;" class="back-home">
<img src="https://cdn.iconscout.com/icon/premium/png-512-thumb/home-426-287913.png" height="20px;" alt=""> <a href = "AdminDashboard"><span style="margin-left:5px;">back to home</span> </a>
</div>
<div class="content">
  <div class="content__inner">


      <div class="multisteps-form">

        <div class="row">
          <div class="col-12 col-lg-8 m-auto">
            <form class="multisteps-form__form">



                <!--look here -->



              <!-- end-->

                <div style= "margin-left:85px; width:100%; ">
                <h3 class="multisteps-form__title" style="text-align:center;">View Employee Details</h3>
                <div class="multisteps-form__content">
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-2">
                        <span>Employee ID </span>
                        <input class="multisteps-form__input form-control" type="Numbers" placeholder=${id} value=${id} disabled/>
                    </div>
                  </div>
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Employee Full Name </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value=${name} placeholder=${name} disabled/>
                    </div>
                    <div class="col-12 col-sm-6">
                        <span>Email: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" disabled value=${userEmail} />
                    </div>
                  </div>
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Date of Birth: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value=${dob} disabled/>
                    </div>
                    <div class="col-12 col-sm-6">
                        <span>Gender: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value=${gender} disabled />
                    </div>
                  </div>
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-12">
                        <span>Address </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value=${address} disabled />
                    </div>

                  </div>

                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Effective Date: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value=${effective} placeholder=${effective} disabled/>
                    </div>
                    <div class="col-12 col-sm-6">
                        <span>Job Position: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value=${role} disabled/>
                    </div>
                  </div>

                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Annual Salary: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value=${salary} placeholder=${salary} disabled />
                    </div>
                    <div class="col-12 col-sm-6">
                        <span>Contract Term: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value=${term} disabled />
                    </div>
                  </div>

                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Annual Leave Balance: </span>
                      <input class="multisteps-form__input form-control" type="text" value=${annual} disabled />
                    </div>
                    <div class="col-12 col-sm-6">
                        <span>Paid Sick Leave Balance: </span>
                      <input class="multisteps-form__input form-control" type="text" value=${sick} disabled />
                    </div>
                  </div>





                  <div class="button-row d-flex mt-4">

                    <a href = "UpdateEmployee?emp_id=${id}" > <button class="btn btn-success ml-auto" type="button" title="Send">Edit Details</button> </a>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>

  </div>
</div>



</body>
</html>
