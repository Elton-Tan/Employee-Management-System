<!DOCTYPE html>
<head>
<link rel="stylesheet" href="reset2.css">
<link rel="stylesheet" href="modal2.css">
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css'>

</head>

<body>
    <div class="container">
  <div class="card">
        <h3 class="card-title">Reset Password</h3>
                       
        <form class="card-form" action="Reset" method="post" onsubmit="">
                <%
                                    //Connecting to the database
                                    String credential = (String) session.getAttribute("credential");
                                    //Checking creditionals whether there are null or not
                                    if (credential != null) {
                                        session.removeAttribute("credential");
                                %>
                                <div class="alert alert-danger" id="danger">Your current password is incorrect</div>
                                <%
                                            }
                                %>
                                
                                 <%
                                    //Connecting to the database
                                    String success = (String) session.getAttribute("success");
                                    //Checking creditionals whether there are null or not
                                    if (success != null) {
                                        session.removeAttribute("success");
                                        session.setAttribute("credential", credential);
                                %>
                                <div class="alert alert-success" id="danger">Password reset successfully</div>
                                <%
                                            }
                                %>
          <div class="alert alert-danger" id="" name="mismatch" hidden>Please make sure your new passwords match</div>
            <div class="alert alert-danger" id="" name="passworderr" hidden>Your password must have at least 8 characters</div>  
          <div class="alert alert-danger" id="" name="samepass" hidden>Your new password cannot be the same as your current</div>  
          <div class="card-input-container password">
                <input type="password" placeholder="Enter Your Current Password" name="current"  id="password" required>
            </div>
            
            <script>
                /*using super nested if else to prevent error overload aka show too many error on the screen
                - each error will only show appropriately after user solves one error
                - aka Password mistmatch error will only show after user resolve password length error
                - this prevent the form from displaying too many error msg at the same time
                - because it makes the form look overcrowded and ugly */
    
                function check() {
                    if(document.getElementsByName('newpass')[0].value.length < 8) { //check if new password length is 8
                        document.getElementsByName('passworderr')[0].hidden = false; //show error if its less than 8
                        document.getElementsByName('resetbtn')[0].disabled = true; //disable btn to prevent submit
                        document.getElementsByName('resetbtn')[0].style.opacity = 0.3; //reduce opacity of button
                    }
                    else if(document.getElementsByName('newpass')[0].value.length >= 8) {
                        document.getElementsByName('passworderr')[0].hidden = true; //hide the error once more than 8
                        if (document.getElementsByName('current')[0].value ===  document.getElementsByName('newpass')[0].value) {
                         document.getElementsByName('samepass')[0].hidden = false;
                     }
                        else {
                        document.getElementsByName('samepass')[0].hidden = true; //we hide the same pass error msg
                        //now we check if the new password is = to our confirm password
                        if (document.getElementsByName('confirm')[0].value !== document.getElementsByName('newpass')[0].value) {
                        document.getElementsByName('mismatch')[0].hidden = false; //if not equal, show error msg
                        document.getElementsByName('resetbtn')[0].disabled = true; //disable button to prevent submit      
        }
                        else {
                        document.getElementsByName('mismatch')[0].hidden = true; //if equal, hide error msg
                        document.getElementsByName('resetbtn')[0].disabled = false; //if all form OK, we can submit
                        document.getElementsByName('resetbtn')[0].style.opacity = 1;
                    }
                        }
                     
                }  
            }
            </script>
            <div class="card-input-container password">
                <input type="password" placeholder="Enter Your New Password" name="newpass" onkeyup="check()" id="password" required>
            </div>
            
            <div class="card-input-container password">
                <input type="password" placeholder="Confirm your New Password" name="confirm" id="password" onkeyup="check()" required>
            </div>
            <button type="submit" class="card-button" name="resetbtn" value="Reset Password">Reset Password</button>
            <small style="color:red;">*Please allow up to 5 seconds after submit for the page to process.</small>
            <br>
            <a href ="EmployeeProfile"> &#8592; Back to Profile</a>
           
        </form>


    </div>
</div>

</body>
</html>