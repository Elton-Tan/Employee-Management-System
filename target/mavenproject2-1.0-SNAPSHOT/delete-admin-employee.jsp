<%-- 
    Document   : delete-admin-employee
    Created on : 5 Jun 2023, 7:19:19 pm
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

      <a href="#" id="user-profile" title="Manage"><span class="fa fa-user-circle"></span>Admin Account</a>


    </div>
  </div>
</div>


</header>

  <div style="float:right; margin-right:50px;" class="back-home">
<img src="https://cdn.iconscout.com/icon/premium/png-512-thumb/home-426-287913.png" height="20px;" alt=""> <a href = "AdminDashboard"><span style="margin-left:5px;">back to home</span></a>
</div>
<div class="content">
  <div class="content__inner">


      <div class="multisteps-form">

        <div class="row">
          <div class="col-12 col-lg-8 m-auto">
            <form class="multisteps-form__form" action="DeleteAdminEmployee" method="post" onsubmit="insertHTML()"  autoComplete= "off">



                <!--look here -->



              <!-- end-->

                <div style= "margin-left:85px; width:100%; ">
                <h3 class="multisteps-form__title" style="text-align:center;">Terminate Employee</h3>
                <div class="multisteps-form__content">
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-2">
                        <span>Employee ID </span>
                        <input class="multisteps-form__input form-control" type="number" value="${id}" name="empId" placeholder="${id}" disabled/>
                    </div>
                  </div>
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Employee Full Name </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="${name}" placeholder="${name}" disabled/>
                    </div>
                    <div class="col-12 col-sm-6">
                        <span>Email: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="${userEmail}" disabled />
                    </div>
                  </div>
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Date of Birth: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="${dob}" disabled/>
                    </div>
                    <div class="col-12 col-sm-6">
                        <span>Gender: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="${gender}" disabled />
                    </div>
                  </div>
                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-12">
                        <span>Address </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="${address}" disabled />
                    </div>

                  </div>

                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Effective Date: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="${effective}"placeholder="${effective}" disabled/>
                    </div>
                    <div class="col-12 col-sm-6">
                        <span>Job Position: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="${role}" disabled/>
                    </div>
                  </div>

                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-6">
                        <span>Annual Salary: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="$${salary}"placeholder="${salary}" disabled />
                    </div>
                    <div class="col-12 col-sm-6">
                        <span>Contract Term: </span>
                      <input class="multisteps-form__input form-control" type="Numbers" value="${term} Years" disabled />
                    </div>
                  </div>

                  <div class="form-row mt-4">
                    <div class="col-12 col-sm-12">
                        <span>Please Input Reason for Termination </span>
                      <textarea class="multisteps-form__input form-control" type="text" required></textarea>
                      <br>
                      <div class ="alert alert-danger" style="font-size:14px;" role="alert" name="conf" hidden> Please ensure you have entered 'CONFIRM'</div>
                      <span> Please Type in 'CONFIRM' before Deleting</span> 
                      <input class="multisteps-form__input form-control" onkeyup="confirmTerm()" name='confdel' type="text" required />
                      <span style='color:red; font-size:12px;'> *Make sure the word is in CAPS</span>
                    </div>
                    </div>
                    
                    <!-- start to validate whether user enter 'CONFIRM'-->
                    <script>
                        function confirmTerm() {
                            if (document.getElementsByName('confdel')[0].value !== "CONFIRM") {
                               
                                //disable button so user cannot submit
                                document.getElementsByName('termemp')[0].disabled = true;
                                //show error msg when input is not CONFIRM 
                                document.getElementsByName('conf')[0].hidden = false;
                            }
                            
                            else {
                                //hide back error msg
                                document.getElementsByName('conf')[0].hidden = true;
                                //now allow user to submit
                                document.getElementsByName('termemp')[0].disabled = false;
                            }
                           
                            
                        }
                    </script>
                    <!-- End validate -->
                    
                  <div class="button-row d-flex mt-4">
                      <input class="btn btn-success ml-auto" type="submit" name="termemp" onclick="confirmTerm()" value="Terminate" style="background-color:red; margin-left:500px;" >
                  </div>
                </div>
              </div>
            </form>
    <div name="modal-insert">
    </div>
 
    <script>
        function insertHTML(){
document.getElementsByName("modal-insert")[0].innerHTML =
    `<div class="pop-up" style="margin-top:-450px; width:600px;">
    <!-- <span class="cross">x</span> -->
    <div class="pop-up-text">
      <h1 style="padding-top:30px;">Action Submitted Successfully</h1>
      <p>The employee has been deleted successfully. You will be redirected to admin dashboard in 3 seconds</p>
      <img style="margin-left:40%;" src="https://tse1.mm.bing.net/th?id=OIP.8WbIrvh6UlckcGsf7-m2JQHaHa&pid=Api&P=0&h=180" width="100px;"/>
    </div>

  </div>`;
    }
  </script>
          </div>
        </div>
      </div>

  </div>
</div>



</body>
</html>
