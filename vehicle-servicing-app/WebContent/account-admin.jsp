<%@page import="java.util.Iterator"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


	<!-- Body -->
	<div class="container-fluid">
		<div class="row mt-4">
			<div class="col-1"></div>
			<div class="col-4">
				<h5>List of Service Centers</h5>
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>SERVICE CENTER</th>
							<th>NO OF ORDERS FULFILLED</th>
							<th>TOTAL REVENUE</th>
						</tr>
					</thead>
					<tbody>
						<%
							List<Number[]> list = (List<Number[]>)request.getAttribute("revenue");
							Iterator<Number[]> it = list.iterator();
							while(it.hasNext()) {
								Number[] arr = it.next();
						%>
							<tr>
								<td><button data-id="<%= arr[0] %>"><%= arr[0] %></button></td>
								<td><%= arr[1] %></td>
								<td><%= arr[2] %></td>
							</tr>
						<% 
							}
						%>
					</tbody>
				</table>
			</div>
			<div class="col-6">
				<h5>Service Center Order History</h5>
				<table class="table table-striped table-bordered" id="service-center-details">
					<thead>
						<tr>
							<th>BILL ID</th>
							<th>SERVICES</th>
							<th>TOTAL PRICE</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<script src="assets/js/jquery.min.js"></script>
	<script>	
		$(document).ready(function() {
			$('button').on('click', function() {
				let serviceCenterId = $(this).attr('data-id');
				$.ajax({
					url: "../vehicle-servicing-app/service-center-history-table.htm?id="+serviceCenterId, 
					success: function(result) {
						let serviceCenterHistory = $.parseJSON(result);
						$("#service-center-details tbody").empty();
						$.each(serviceCenterHistory, function(index, value) {
							let str = "<tr>";
							str += "<td>" + value.billId + "</td>";
							str += "<td><ul>";
							$.each(value.serviceName, function(i, v) {
								str += "<li>" + value.serviceName[i] + " -> Rs. " + value.servicePrice[i] + "</li>";
							});
							str += "</ul></td>";
							str += "<td>Rs. " + value.totalPrice + "</td>";
							str += "</tr>";
							$('#service-center-details tbody').append(str);
						});
					}
				});
			});
		});
	</script>