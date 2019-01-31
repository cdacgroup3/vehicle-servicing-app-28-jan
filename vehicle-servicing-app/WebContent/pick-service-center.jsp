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
	#pick-center-form span {
		display: block;
	}
  	#pick-center-form input[type="radio"]{
	  display: none;
	}
	#pick-center-form label { cursor: pointer; }
  	#pick-center-form label:before {
	  	content: '';
  	    width: 35px;
	    height: 35px;
	    padding: 0 0 0 7px;
	    border: 3px solid green;
	    border-radius: 50%;
	    display: inline-block;
	    position: absolute;
	    background: transparent;
	    cursor: pointer;
	}
	#pick-center-form input[type="radio"]:checked+label:before {
	  	content: '\2713';
	    background: green;
	    color: white;
	    font-size: 20px;
	    font-weight: bold;
	}
	h4 .error-icon {
		font-size: 45px;
		vertical-align: -6px;
	}
	#pick-center-form h4 {
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
				<% 
				if(request.getAttribute("serviceCenters") != null) {
				%>
				<h3 class="my-4">PICK SERVICE CENTER</h3>
				<spr:form action="confirm-order.htm" commandName="serviceCenterPicked" id="pick-center-form">
					<%
						List<ServiceCenter> serviceCenters = (List<ServiceCenter>) request.getAttribute("serviceCenters");
						Iterator<ServiceCenter> it = serviceCenters.iterator();
						while (it.hasNext()) {
							ServiceCenter sc = it.next();
					%>
					<div class="card mb-4">		
						<div class="card-header">
							<spr:radiobutton path="mobileNo" value="<%= sc.getMobileNo() %>" id="<%= String.valueOf(sc.getMobileNo()) %>" required="required" />
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
				<% } else { %>
					<h4 class="mt-5 text-danger"><span class="error-icon">&#x26A0;</span> We don't have any service centers for your zipcode.</h4>
				<% } %>
				
				<div class="mt-5">
					<h5>Currently in a different location?</h5>
					<form class="col-6 form-inline" action="service-center-by-zip-table.htm">						
						<label for="alt-zip-code" class="col-sm-2 col-form-label">Zip code: </label>
						<input class="form-control" type="text" id="alt-zip-code" name="alt-zip-code">
						<button type="submit" class="btn btn-success mt-3" id="find-alt-center">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>