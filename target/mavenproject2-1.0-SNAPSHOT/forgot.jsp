<!DOCTYPE html>
<head>
  <link rel="stylesheet" href="reset2.css" />
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css'>
  <style>
      * {
          background-color:white;
      }
  </style>
</head>

<body>
  <div class="container" style="width:700px; background-color:white;">
    <div class="card" style="width:600px;">
           
      <h1 class="card-title">Did you forget your password?</h1>
      <small> We will send you an email containing your new password</small>

      <form class="card-form" action="Forgot" method="post">
                <%
                                    //Connecting to the database
                                    String credential = (String) session.getAttribute("credential");
                                    //Checking creditionals whether there are null or not
                                    if (credential != null) {
                                        session.removeAttribute("credential");
                                        
                                %>
                                 <div class="alert alert-danger" id="danger">Your email is unregistered in our database</div>
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
                                 <div class="alert alert-success" id="danger">Email sent successfully! Please check your email.</div>
 <%
                                    }
                                %>
        <div class="card-input-container password">
            <input type="email" placeholder="Enter Your Email" name="email" id="password" required/>
        </div>
          

        <input type="submit" class="card-button" value="Send Email"/>
            <small style="color:red;">*Please allow up to 5 seconds after submit for the page to process.</small>
        <br>
        <a href ="login.jsp">&#8592 Return to Login </a>
      </form>
    </div>
  </div>
</body>
