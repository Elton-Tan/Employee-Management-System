
<%-- 
    Document   : employee-request-leave
    Created on : 5 Jun 2023, 6:52:19 pm
    Author     : ERMS
--%>



<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.connection.*"%>
<!DOCTYPE html>

<head>
  <link rel="stylesheet" type="text/css" href="leave-request-admin.css">
  <link rel="stylesheet" href="employee-profile.css">
  <link rel="stylesheet" href="modal2.css">
  <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
  <script type="text/javascript" src="gridforms/gridforms.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js" charset="utf-8"></script>


  <!--bootstrap-->
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/reset.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/bootstrap-3.3.7-min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <link rel="stylesheet" href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1535263/global-bmic.min.css">
  <!--end-->

</head>
<body onload="setDate()">

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
    
  <h3 style="text-align:center;">Apply for Leave</h3>
  <div style="float:right; margin-right:50px;" class="back-home">
<img src="https://cdn.iconscout.com/icon/premium/png-512-thumb/home-426-287913.png" height="20px;" alt="">  <span style="margin-left:5px;"> <a href= "EmployeeProfile">Back to Dashboard </a></span>
</div>

<br><br>

  <form class="grid-form" action="RequestLeave" method="post" name="formLeave" style="width:75%; margin-left:13%;" onsubmit ="insertHTML()">
    <fieldset>
      <legend>Personal Details</legend>
       <div class="alert alert-danger" id="danger" name="warning" hidden >You cannot take annual leave and sick leave in the same form</div>
       <div class="alert alert-danger" id="danger" name="warning2" hidden >End date of leave cannot be earlier than start date</div>
        <div class="alert alert-danger" id="danger" name="warning3" hidden >You have insufficient days of leave</div>
       <div class="alert alert-danger" id="danger" name="warning4" hidden >Please fill up your leave start dates and end dates</div>
        <div data-row-span="4">
        <div data-field-span="2" value="">
          <label>Full Name</label>
          <span><%= name %></span>
        </div>
        <div data-field-span="2">
          <label>Leave ID</label>
          <label>${newLeaveId}</label>
        </div>
      </div>
      <div data-row-span="4">
        <div data-field-span="4">
          <label>Contact Number (Required): </label>
          <input type="text" name="contact" required>
        </div>


      </div>
      <div data-row-span="2">
        <div data-field-span="2" data-field-error="Please enter a valid email address">
          <label>Job Title</label>
          <span> <%= role %> </span>
        </div>

      </div>

      <br>
      <fieldset>
    
         
        <legend>Type Of Leave Taken</legend>
        <div data-row-span="4">
          <div data-field-span="1">
            <label>Current Balance of Annual Leave </label>
            <span name="annualNo"><%= annual %></span>
          </div>
          <div data-field-span="1">
            <label>Start Date </label>
         <input type="date" name="an_start" id="start" oninput="calculateAn()" value="" >
            <span></span>
          </div>
          <div data-field-span="1">
            <label>End Date</label>
            <input type="date" name="an_end" id="end"oninput="calculateAn()" value="">
          </div>
      
           
            <script> 
               function setDate () {
                        //set user can only take leave from today onwards
                        document.getElementsByName("an_start")[0].min = new Date().toISOString().split("T")[0];
                        document.getElementsByName("si_start")[0].min = new Date().toISOString().split("T")[0];
                        document.getElementsByName("an_end")[0].min = new Date().toISOString().split("T")[0];
                        document.getElementsByName("si_end")[0].min = new Date().toISOString().split("T")[0];

                  
                }
                
            //validate form so sick leave and annual cannot be in the same form
             function calculateSi(){
                 var Lva_start = new Date (document.getElementsByName("si_start")[0].value).getTime();
                 var Lva_End =  new Date (document.getElementsByName("si_end")[0].value).getTime();
                 //lets start validating input length
                 var AnS_length = document.getElementsByName("an_start")[0].value.length;
                 var AnE_length = document.getElementsByName("an_end")[0].value.length;
                 var SiS_length = document.getElementsByName("si_start")[0].value.length;
                 var SiE_length = document.getElementsByName("si_end")[0].value.length;
                 
                 //check if annual and sick have inputs at the same time
                 if  ((AnS_length !== 0 && SiS_length !==0) || (AnS_length !== 0 && SiE_length !==0) || (AnE_length !== 0 && SiE_length !==0) ||  (AnE_length !== 0 && SiS_length !==0))  {                 
                     document.getElementsByName("an_start")[0].value=null;
                     document.getElementsByName("an_end")[0].value=null;
                      document.getElementsByName("an_no")[0].value=0;
                       document.getElementsByName("si_no")[0].value=0;
                     document.getElementsByName("warning")[0].removeAttribute("hidden");
                 }
                 
                 else {
                     document.getElementsByName("warning")[0].hidden = true;
                 }
                 //WE WILL CALCULATE NUMBAH OF DAYS FROM LEAVE START TO LEAVE ENDDDDD
                 var difference = Lva_End - Lva_start;
                 var Total_Days = Math.ceil(difference/ (1000*3600*24) );
                 var Lva_no = document.getElementsByName("si_no")[0];
                 //IF THE NUMBER OF DAYS FROM START TO END + 1 IS 0 OR LESS MEANS USER END DATE IS EARLIER THAN START DATE
                 if ((Total_Days + 1) > 0){
                 Lva_no.value= Total_Days + 1;
                 document.getElementsByName("warning2")[0].hidden = true; //we display error msg when end is earlier than start
                 //document.getElementsByName("submitBtn")[0].style.backgroundColor = "blue";
                 //document.getElementsByName("submitBtn")[0].innerText = "Submit Leave";
                 document.getElementsByName("submitBtn")[0].disabled = false;
                    //lastly we check if user have sufficient leave
                 if (Total_Days + 1 > parseInt(document.getElementsByName("sickNo")[0].innerHTML)){
                 document.getElementsByName("warning3")[0].removeAttribute("hidden");
                 //document.getElementsByName("submitBtn")[0].style.backgroundColor = "red";
                 //document.getElementsByName("submitBtn")[0].innerText = "Unable to Submit";
                 document.getElementsByName("submitBtn")[0].style.opacity = 0.3;
                 document.getElementsByName("submitBtn")[0].disabled = true;
             }
              else {
                 document.getElementsByName("warning3")[0].hidden = true;
                 document.getElementsByName("submitBtn")[0].style.opacity = 1;
                  
             }
                 
             }
             
             else {
               
                 document.getElementsByName("warning2")[0].removeAttribute("hidden");
                 
                 //document.getElementsByName("submitBtn")[0].innerText = "Unable to Submit";
                document.getElementsByName("submitBtn")[0].style.opacity = 0.3;
                document.getElementsByName("submitBtn")[0].disabled = true;
                 Lva_no.value= null;
                 
                
 
                 
             }
             
         
           
            
              }
                //is the same as calculate si but this time its for annual laves
             function calculateAn(){
         
                 var Lva_start = new Date (document.getElementsByName("an_start")[0].value).getTime();
                 var Lva_End =  new Date (document.getElementsByName("an_end")[0].value).getTime();
                 var AnS_length = document.getElementsByName("an_start")[0].value.length;
                 var AnE_length = document.getElementsByName("an_end")[0].value.length;
                 var SiS_length = document.getElementsByName("si_start")[0].value.length;
                 var SiE_length = document.getElementsByName("si_end")[0].value.length;
                 if  ( (AnS_length !== 0 && SiS_length !==0) || (AnS_length !== 0 && SiE_length !==0) || (AnE_length !== 0 && SiE_length !==0) ||  (AnE_length !== 0 && SiS_length !==0))  {
                     document.getElementsByName("si_start")[0].value=null;
         
                     document.getElementsByName("si_end")[0].value=null;
                  
                     document.getElementsByName("si_no")[0].value=0;
                      document.getElementsByName("an_no")[0].value=0;
                     document.getElementsByName("warning")[0].removeAttribute("hidden");
                 }
                   else {
                     document.getElementsByName("warning")[0].hidden = true;
                 }
                 
                 var difference = Lva_End - Lva_start;
                 var Total_Days = Math.ceil(difference/ (1000*3600*24) );
                 var Lva_no = document.getElementsByName("an_no")[0];
                 
               if ((Total_Days + 1) > 0){
                 Lva_no.value= Total_Days + 1;
                 document.getElementsByName("warning2")[0].hidden = true;
                 document.getElementsByName("submitBtn")[0].style.backgroundColor = "blue";
                 document.getElementsByName("submitBtn")[0].innerText = "Submit Leave";
                 document.getElementsByName("submitBtn")[0].disabled = false;
                
            if (Total_Days + 1  > parseInt(document.getElementsByName("annualNo")[0].innerHTML)){    
                 document.getElementsByName("warning3")[0].removeAttribute("hidden");
                 //document.getElementsByName("submitBtn")[0].style.backgroundColor = "red";
                 //document.getElementsByName("submitBtn")[0].innerText = "Unable to Submit";
                 document.getElementsByName("submitBtn")[0].style.opacity = 0.3;
                 document.getElementsByName("submitBtn")[0].disabled = true;
             }
              else {
                 document.getElementsByName("warning3")[0].hidden = true;
                 document.getElementsByName("submitBtn")[0].style.opacity = 1;
                 
             }
                 
             }
             
             else {
                 document.getElementsByName("warning2")[0].removeAttribute("hidden");
                 //document.getElementsByName("submitBtn")[0].style.backgroundColor = "red";
                //document.getElementsByName("submitBtn")[0].innerText = "Unable to Submit";
                document.getElementsByName("submitBtn")[0].style.opacity = 0.3;
                 document.getElementsByName("submitBtn")[0].disabled = true;
                 Lva_no.value= null;
             }
         
              }
              

          </script>
          <div data-field-span="1">
            <label>Number Of Days</label>
           
            <input type="number" name="an_no" id="difference_lv" readonly required/>
            <br>
        
            
       
          </div>
          
        </div>

        <div data-row-span="4">
          <div data-field-span="1">
            <label>Normal Sick Leave </label>
            <label name="sickNo"><%= sick %></label>
          </div>
          <div data-field-span="1">
            <label>Start Date </label>
            <input type="date" name="si_start" oninput="calculateSi()">
          </div>
          <div data-field-span="1">
            <label>End Date</label>
            <input type="date" name="si_end" oninput="calculateSi()">
          </div>
       
      <div data-field-span="1">
            <label>Number Of Days</label>
           
          <input type="number" name="si_no" readonly required>
          </div>
        </div>



        <div data-row-span="4">
          <div data-field-span="4">
            <label>Reason for Leave (required)</label>
            <input type="text" required name="reason"  >
          </div>


        </div>
          <br>
             <button class="pop-up-button" type="submit" style="display:block; float:right;" onclick="validate()" name="submitBtn"/>Submit Leave </button>
      </fieldset>
    <br>
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
    
    function validate() {
       if(document.getElementsByName('an_no')[0].value.length === 0 && document.getElementsByName('si_no')[0].value.length === 0) {
           document.getElementsByName("warning4")[0].removeAttribute("hidden");
           event.preventDefault();
       }
       else {
          return true;
       } 
    }
  </script>

  
<!-- modal end -->


  </form>



  <!--
<a href="employee-profile.html" style="float:right; margin-right:0%;">
  <button class="btn btn-success ml-auto" type="button" title="Send">Submit Leave</button>
</a>
-->
<br><br><br><br>
</body>

</html>
