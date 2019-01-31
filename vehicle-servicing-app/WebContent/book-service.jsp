<%@page import="dto.CustomerBill"%>
<%@ page import ="java.util.List"%>
<%@ page import ="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="spr"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Car Fix | Book Services</title>
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/styles.css">
<style>
	.checkout-service { margin-left: 10px; }
	.checkout-service .card {
		padding-top: 15px;
		padding-bottom: 25px;
		border-color: #ccc;
		box-shadow: 0 .25rem .5rem rgba(0,0,0,.075);
	}
	.checkout-service img { margin-top: -10px; }
	.checkout-service ul { padding-left: 18px; }
	.checkout-service h6 { font-size: 17px; }
	.checkout-service button { background-color: #01704f; }

	.service-total-bill {
		max-width: 365px;
		margin: 8px auto 0;
	}
	.service-total-bill .card-body {
		padding-left: 0;
		padding-right: 0;
		font-size: 15px;
	}
	.service-total-bill .bill-bdr {
		padding: 0 15px 0.75rem;
		border-bottom: 2px solid #dcdcdc;
	}
	.service-total-bill .service-list {
		padding: 0.75rem 15px;
	}
	.service-total-bill .service-item:last-child:not(#service-item-dummy) {
		padding-bottom: 0.75rem;
		border-bottom: 2px solid #dcdcdc;
	}
	.service-total-calc {
		font-size: 19px;
		font-weight: bold;
	}
	.service-total-calc .row:first-child {
		font-size: 16px;
	}
	#checkout-login {
		background-image: linear-gradient(to right top, #28a745, #12994b, #008c4f, #007e50, #01704f);
		font-size: 20px;
    	font-weight: 600;
	}
	#checkout-login:hover {
		background-image: linear-gradient(to left top, #01704f, #007e50, #008c4f, #12994b, #28a745);
	}
	#checkout-login+span {
		position: absolute;
	    left: 115px;
	    color: red;
	}
</style>
</head>
<body>
	<!-- Header -->
	<%@ include file="header.jsp"%>	
	
	<%
		CustomerBill cb = (CustomerBill)session.getAttribute("customerBill");
		List<String> nameList = null;
		if(cb!=null) {
			nameList = cb.getServiceName();
		} 	
	%>

	<!-- Body -->
	<div class="container-fluid">
		<!-- Service selection tabs -->
		<div class="row mt-4 mb-3 service-tab">
			<ul class="nav w-100">
				<li class="col-3">
					<button type="button"
						class="btn btn-block btn-lg btn-outline-success"
						id="servicing-service-tab">Servicing</button>
				</li>
				<li class="col-3">
					<button type="button"
						class="btn btn-block btn-lg  btn-outline-success"
						id="repairing-service-tab">Repairing</button>
				</li>
				<li class="col-3">
					<button type="button"
						class="btn btn-block btn-lg btn-outline-success"
						id="denting-service-tab">Denting/Painting</button>
				</li>
				<li class="col-3">
					<button type="button"
						class="btn btn-block btn-lg btn-outline-success"
						id="emergency-service-tab">Emergency</button>
				</li>
			</ul>
		</div>
		
	</div>

	<div class="container-fluid">
	<div class="row">
	<div class="col-8">
		<%
			String serviceType = (String) request.getAttribute("serviceType");
			if (serviceType.equals("servicing")) {
		%>
		<div class="service-info-book" data-visible="true">
			<%@ include file="book-servicing.jsp"%>
		</div>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-repairing.jsp"%>
		</div>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-denting.jsp"%>
		</div>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-emergency.jsp"%>
		</div>
	<%
		} else if (serviceType.equals("repairing")) {
	%>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-servicing.jsp"%>
		</div>
		<div class="service-info-book" data-visible="true">
			<%@ include file="book-repairing.jsp"%>
		</div>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-denting.jsp"%>
		</div>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-emergency.jsp"%>
		</div>
	<%
		} else if (serviceType.equals("denting")) {
	%>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-servicing.jsp"%>
		</div>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-repairing.jsp"%>
		</div>
		<div class="service-info-book" data-visible="true">
			<%@ include file="book-denting.jsp"%>
		</div>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-emergency.jsp"%>
		</div>
	<% 
		} else if (serviceType.equals("emergency")) {
	%>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-servicing.jsp"%>
		</div>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-repairing.jsp"%>
		</div>
		<div class="service-info-book" data-visible="false">
			<%@ include file="book-denting.jsp"%>
		</div>
		<div class="service-info-book" data-visible="true">
			<%@ include file="book-emergency.jsp"%>
		</div>
	<% 
		}
	%>
	</div>

	<!--bill payment-->
	<div class="col-4">
		<div class="card service-total-bill">
			<div class="card-header bg-light text-center">
				<h5 class="mb-0">Your Quote</h5>
			</div>
			<div class="card-body">
				<div class="bill-bdr pt-0">
					<span><span class="font-weight-bold">Vehicle:</span> ${customerCar.carBrand}</span>
				</div>

				<spr:form action="checkout-login.htm" method="post" commandName="customerBill" id="checkout-form">
					<div class="service-list">
						<div class="service-item row" id="service-item-dummy">
							<span class="service-item-name col-9"></span> 
							<span class="service-item-price col-3 text-right"></span>
							<spr:input type="hidden" class="service-item-name" path="serviceName" value="" />
							<spr:input type="hidden" class="service-item-price" path="servicePrice" value="" />
						</div>

						<%
							System.out.println(session.getAttribute("customerBill"));
							if (session.getAttribute("customerBill") != null) {
								CustomerBill customerBill = (CustomerBill) session.getAttribute("customerBill");
								List<String> serviceNameList = customerBill.getServiceName();
								List<String> servicePriceList = customerBill.getServicePrice();
								Iterator<String> it1 = serviceNameList.iterator();
								Iterator<String> it2 = servicePriceList.iterator();
								while (it1.hasNext() && it2.hasNext()) {
									String s1 = it1.next();
									String s2 = it2.next();
						%>
						<div class="service-item row" data-id="<%=s1%>">
							<span class="service-item-name col-9"><%=s1%></span> 
							<span class="service-item-price col-3 text-right">Rs. <%=s2%></span>
							<spr:input type="hidden" class="service-item-name" path="serviceName" value="<%=s1%>" />
							<spr:input type="hidden" class="service-item-price" path="servicePrice" value="<%=s2%>" />
						</div>
						<%
								}
							}
						%>
					</div>
					
					<div class="service-total-calc bill-bdr">	
						<%
							int total = 0, mktTotal = 0;
							if (session.getAttribute("customerBill") != null) {
								CustomerBill customerBill = (CustomerBill) session.getAttribute("customerBill");
								total = customerBill.getTotalPrice();
								mktTotal = customerBill.getMarketPrice();
							}
						%>
						<div class="row">
							<div class="col-8">
								<span class="text-danger">Market Price:</span>
							</div>
							<div class="col-4 text-right">
								<span class="text-danger" id="market-price"><del>Rs. <%= mktTotal %></del></span>
								<spr:input type="hidden" path="marketPrice" value="<%= mktTotal %>" />
							</div>
						</div>

						<div class="row">
							<div class="col-8">
								<span>Total:</span>
							</div>
							<div class="col-4 text-right">										
								<span class="text-dark" id="total-price">Rs. <%= total %></span>
								<spr:input type="hidden" path="totalPrice" value="<%= total %>" />
							</div>
						</div>

						<div class="row">
							<div class="col-12 text-right">
								<span class="text-success small">Save <span id="save-price">Rs. <%= mktTotal-total %></span></span>
							</div>
						</div>
					</div>	
				
					<div class="px-4 pt-4">
						<button type="submit" class="btn btn-block btn-success" id="checkout-login">BOOK NOW</button>
					</div>
				</spr:form>
			</div>
		</div>
	</div>
	
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/site.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			let name = '<%=session.getAttribute("serviceType")%>';
			$("#" + name + "-service-tab").parent().addClass('active');
	
			let nameList = "<%=nameList%>";
			if(nameList!="null") {
				nameList = nameList.slice(1, -1);
				nameList = nameList.split(", ");	
				let arr = $('.checkout-service-name');
				$.grep(arr, function(el) {
				    if ($.inArray(el.innerText, nameList) != -1) {
				        $(el).parents('.checkout-service').find('button').eq(0).prop("disabled", true);
				        $(el).parents('.checkout-service').find('button').eq(1).removeClass('d-none');
				    }
				});
			}

			$("#checkout-login").on('click', function(e) {
				e.preventDefault();
				if($('.service-item').length<=1) {
					if($(this).next('span').length == 0) {
						$(this).after('<span>No services selected</span>');
					}
				} else {
					$(this).next('span').remove();
					$("#checkout-form").submit();
				}
			});
		});
	</script>
</body>
</html>