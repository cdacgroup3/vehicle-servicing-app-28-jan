<%@page import="dto.CustomerBill"%>
<%@page import="java.util.Iterator"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="spr"%>
<%@page import="dto.ServiceCenter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pick service center</title>
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/styles.css">
<style>
	span {
		display: block;
	}
  /* .funkyradio label {
    width: 50%;
    border-radius: 3px;
    border: 2px solid #D1D3D4;
    font-weight: normal;
  }  
  .funkyradio input[type="radio"]:empty
  {
    display: none;
  }  
  .funkyradio input[type="radio"]:empty ~ label
  {
    position: relative;
    line-height: 2.5em;
    text-indent: 3em;
    margin-top: 1em;
    cursor: pointer;
  } 
  .funkyradio input[type="radio"]:empty ~ label:before
  {
    position: absolute;
    display: block;
    height: 3em;
    content: '';
    width: 3em;
    background: #D1D3D4;
    border-radius: 3px 0 0 3px;
  }
  .funkyradio input[type="radio"]:checked ~ label:before,
  .funkyradio input[type="checkbox"]:checked ~ label:before {
    content: '\2714';
    text-indent: .9em;
    color: #333;
    background-color: #ccc;
  }
  .funkyradio-success input[type="radio"]:checked ~ label:before,
  .funkyradio-success input[type="checkbox"]:checked ~ label:before {
    color: #fff;
    background-color: #5cb85c;
  } */
  	input[type="radio"]{
	  display: none;
	}
	label { cursor: pointer; }
  	label:before {
	  	content: '';
  	    width: 35px;
	    height: 35px;
	    padding: 0 6px 0 8px;
	    border-radius: 50%;
	    display: inline-block;
	    position: absolute;
	    background-color: #28a745;
	    cursor: pointer;
	}
	input[type="radio"]:checked+label:before {
	  	content: '\2713';
	    background-color: #01704f;
	    color: white;
	    font-size: 24px;
	    font-weight: bold;
	}
	h4 {
		padding-top: 3px;
		margin: 0 0 -3px 45px;
	}
</style>
</head>
<body>
	<!-- Header -->
	<%@ include file="header.jsp"%>
	
	<div class="container-fluid pb-5">
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6">
				<h3 class="my-4">PICK SERVICE CENTER</h3>
				<spr:form action="confirm-order.htm" commandName="serviceCenterPicked">
					<%
						List<ServiceCenter> serviceCenters = (List<ServiceCenter>) request.getAttribute("serviceCenters");
						Iterator<ServiceCenter> it = serviceCenters.iterator();
						while (it.hasNext()) {
							ServiceCenter sc = it.next();
					%>
					<div class="card mb-4">		
						<div class="card-header">
							<spr:radiobutton path="mobileNo" value="<%= sc.getMobileNo() %>" id="<%= String.valueOf(sc.getMobileNo()) %>" />
						    <label for="<%= String.valueOf(sc.getMobileNo()) %>">
						    	 <h4><%= sc.getServiceCenterName() %></h4>
						    </label>
						 </div>
						 <div class="card-body">
							<span>Email: <%= sc.getEmail() %></span>
							<span>Mobile No: <%= sc.getMobileNo() %></span>
							<span>Address: <%= sc.getAddress() %></span>
							<span>Zipcode: <%= sc.getZipcode() %></span>
						</div>
					</div>
					<% } %>
					<div class="text-center">
						<button type="submit" class="btn btn-lg btn-success">CONFIRM BOOKING</button>
					</div>
				</spr:form>
			</div>
		</div>
	</div>
	
</body>
</html>