<%@page import="java.util.Iterator"%>
<%@page import="dto.CustomerBill"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account</title>
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/styles.css">
<style>
	.account-tabs .active {
		background-color: #28a745;
	    color: #fff;
	    font-weight: 700;
	}
	table { width: 100%; }
</style>
</head>
<body>
	<!-- Header -->
	<%@ include file="header.jsp"%>
	
	<!-- Body -->	
	<div class="container-fluid">
		<div class="row mt-4 account-tabs">
			<div class="col-2"></div>
			<div class="col-4">
				<button type="button" class="btn btn-block btn-outline-success active" 
				id="current-orders-tab">Current Orders</button>
			</div>
			<div class="col-4">
				<button type="button" class="btn btn-block btn-outline-success" 
				id="history-tab">History</button>
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col-2"></div>
			<div class="col-8">
				<div id="current-orders-section">
					<h5>Current Orders</h5>
					<table class="table table-striped table-bordered">
						<thead>
							<tr>
								<th>BILL ID</th>
								<th>SERVICES</th>
								<th>TOTAL PRICE</th>
								<th>APPROVE</th>
							</tr>
						</thead>
						<tbody>
							<%
								List<CustomerBill> customerOrders = (List<CustomerBill>) request.getAttribute("serviceCenterOrders");
								Iterator<CustomerBill> it = customerOrders.iterator();
								while(it.hasNext()) {
									CustomerBill customerBill = it.next();			
							%>
							<tr>
								<td><%= customerBill.getBillId() %></td>
								<td>
									<ul>
								<%
									List<String> serviceNamesList = customerBill.getServiceName();
									List<String> servicePricesList = customerBill.getServicePrice();
									Iterator<String> it2 = serviceNamesList.iterator();
									Iterator<String> it3 = servicePricesList.iterator();
									while(it2.hasNext() && it3.hasNext()) {
								%>
									<li><%= it2.next() + " -> Rs " + it3.next() %></li>
								<% } %>
									</ul>
								</td>
								
								<td>Rs. <%= customerBill.getTotalPrice() %></td>
								<td>
									<form action="approve-payment.htm" method="post">
										<input type="hidden" name="billId" value="<%= customerBill.getBillId() %>">
										<button type="submit">APPROVE PAYMENT</button>
									</form>
								</td>
							</tr>
							<% } %>
						</tbody>
					</table>
				</div>
				
				<div id="history-orders-section" class="d-none">	
					<h5>Order History</h5>
					<div class="row make-center">
						<table class="table table-striped table-bordered col-10">
							<thead>
								<tr>
									<th>BILL ID</th>
									<th>SERVICES</th>
									<th>TOTAL PRICE</th>
								</tr>
							</thead>
							<tbody>
								<%
									List<CustomerBill> customerOrderHistory = (List<CustomerBill>) request.getAttribute("serviceCenterOrderHistory");
									Iterator<CustomerBill> it4 = customerOrderHistory.iterator();
									while(it4.hasNext()) {
										CustomerBill customerBill = it4.next();			
								%>
								<tr>
									<td><%= customerBill.getBillId() %></td>
									<td>
										<ul>
									<%
										List<String> serviceNamesList = customerBill.getServiceName();
										List<String> servicePricesList = customerBill.getServicePrice();
										Iterator<String> it5 = serviceNamesList.iterator();
										Iterator<String> it6 = servicePricesList.iterator();
										while(it5.hasNext() && it6.hasNext()) {
									%>
										<li><%= it5.next() + " -> Rs " + it6.next() %></li>
									<% } %>
										</ul>
									</td>
									
									<td>Rs. <%= customerBill.getTotalPrice() %></td>
								</tr>
								<% } %>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script src="assets/js/jquery.min.js"></script>
	<script>
		$('#current-orders-tab').on('click', function() {
			$('#history-orders-section').addClass('d-none');
			$('#current-orders-section').removeClass('d-none');
			$('#history-tab').removeClass('active');
			$(this).addClass('active');
		});
	
		$('#history-tab').on('click', function() {
			$('#current-orders-section').addClass('d-none');
			$('#history-orders-section').removeClass('d-none');
			$('#current-orders-tab').removeClass('active');
			$(this).addClass('active');
		});
	</script>
</body>
</html>