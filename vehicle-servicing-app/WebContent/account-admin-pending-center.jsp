<%@page import="java.util.Iterator"%>
<%@page import="dto.WaitlistedServiceCenter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
	<!-- Header -->
	<%@ include file="header.jsp"%>	
	
	<%
		//request.getAttribute("waitlisted");
		System.out.println(request.getAttribute("waitlisted"));
	%>
	
	<!-- Body -->
	<div class="container-fluid">
		<div class="row mt-4">
			<div class="col-1"></div>
			<div class="col-10">
				<h5>Waitlisted Service Centers</h5>
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>SERVICE CENTER NAME</th>
							<th>MOBILE NO</th>
							<th>EMAIL</th>
							<th>ADDRESS</th>
							<th>ZIPCODE</th>
							<th>ADD</th>
							<th>REJECT</th>
						</tr>
					</thead>
					<tbody>
						<% 
							List<WaitlistedServiceCenter> list = (List<WaitlistedServiceCenter>)request.getAttribute("waitlisted");
							Iterator<WaitlistedServiceCenter> it = list.iterator();
							while(it.hasNext()) {
								WaitlistedServiceCenter ws = it.next();
						%>
						<tr>
							<td><%= ws.getServiceCenterName() %></td>
							<td><%= ws.getMobileNo() %></td>
							<td><%= ws.getEmail() %></td>
							<td><%= ws.getAddress() %></td>
							<td><%= ws.getZipcode() %></td>
							<td>
								<form action="approve-center.htm" method="post">
									<input type="hidden" name="centerId" value="<%= ws.getMobileNo() %>">
									<button type="submit">ACCEPT</button>
								</form>
							</td>
							<td>
								<form action="deny-center.htm" method="post">
									<input type="hidden" name="centerId" value="<%= ws.getMobileNo() %>">
									<button type="submit">DENY</button>
								</form>
							</td>
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>