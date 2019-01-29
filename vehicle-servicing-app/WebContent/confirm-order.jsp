<%@page import="dto.CustomerBill"%>
<%@page import="dao.CustomerDao" %>
<%@page import="dto.ServiceCenter" %>
<%@ page import ="java.util.List"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import ="java.util.Iterator"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="spr"%>




<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>CONFIRMATION</title>
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/css/styles.css">
	<style>
     .make-center{
         display: flex;
         justify-content: center;
         align-items: center;
     }
    .invoice-box {
        max-width: 650px;
        margin: auto;
        padding: 30px;
        border: 1px solid #eee;
        box-shadow: 0 0 10px rgba(0, 0, 0, .15);
        font-size: 16px;
        line-height: 24px;
        font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
        color: #555;
    }
    
    .invoice-box table {
        width: 100%;
        line-height: inherit;
        text-align: left;
    }
    
    .invoice-box table td {
        padding: 5px;
        vertical-align: top;
    }
    
    .invoice-box table tr td:nth-child(2) {
        text-align: right;
    }
    
    .invoice-box table tr.top table td {
        padding-bottom: 20px;
    }
    
    .invoice-box table tr.top table td.title {
        font-size: 45px;
        line-height: 45px;
        color: #333;
    }
    
    .invoice-box table tr.information table td {
        padding-bottom: 40px;
    }
    
    .invoice-box table tr.heading td {
        background: #eee;
        border-bottom: 1px solid #ddd;
        font-weight: bold;
    }
    
    .invoice-box table tr.details td {
        padding-bottom: 20px;
    }
    
    .invoice-box table tr.item td{
        border-bottom: 1px solid #eee;
    }
    
    .invoice-box table tr.item.last td {
        border-bottom: none;
    }
    
    .invoice-box table tr.total td:nth-child(2) {
        border-top: 2px solid #eee;
        font-weight: bold;
    }
    
    @media only screen and (max-width: 600px) {
        .invoice-box table tr.top table td {
            width: 100%;
            display: block;
            text-align: center;
        }
        
        .invoice-box table tr.information table td {
            width: 100%;
            display: block;
            text-align: center;
        }
    }
    
    /** RTL **/
    .rtl {
        direction: rtl;
        font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
    }
    
    .rtl table {
        text-align: right;
    }
    
    .rtl table tr td:nth-child(2) {
        text-align: left;
    }
    </style>
</head>

<body>
	<!-- Header -->
	<%@ include file="header.jsp"%>
	
	<div class="container-fluid pb-5">	
		<h2>Congrats! Your services have been successfully booked!</h2>
		<a href="home.htm">GO TO HOME</a>
		
		<%
			CustomerBill cb = (CustomerBill)session.getAttribute("customerBill");
			List<String> nameList = null;
			if(cb!=null) {
				nameList = cb.getServiceName();
			} 	
			ServiceCenter sc = cb.getServiceCenter();
		%>
		
		<%
		CustomerBill customerBill1 = (CustomerBill) session.getAttribute("customerBill");
		int billid=customerBill1.getBillId();
		%>
				
		 <div class="invoice-box pv">
	        <table cellpadding="0" cellspacing="0">
	            <tr class="top">
	                <td colspan="2">
	                    <table>
	                        <tr>
	                            <td class="title">
	                                <img src="assets/images/logo.png" style="width:100%; max-width:250px;">
	                            </td>                            
	                            <td>
	                                Invoice #:<%=billid%><br>
	                           		<p id="demo"></p>	                                
	                            </td>
	                        </tr>
	                    </table>
	                </td>
	            </tr>
	            
	            <tr class="information">
	                <td colspan="2">
	                    <table>
	                        <tr>
	                            <td>
	                            	<%= sc.getServiceCenterName() %><br>
	                                <%= sc.getMobileNo() %><br>
	                                <%= sc.getAddress() %><br>
	                                <%= sc.getZipcode() %>
	                            </td>
	                        </tr>
	                    </table>
	                </td>
	            </tr>
	            
	            <tr class="heading">
	                <td>Payment Method</td>
	                <td>Cash</td>
	            </tr>
	            
	            <tr class="details">
	                <td></td>	                
	                <td></td>
	            </tr>
	            
	            <tr class="heading">
	                <td>Item</td>
	                <td>Price</td>
	            </tr>
	            
	        </table>
	         
			<div class="service-list">
				<div class="service-item row" id="service-item-dummy">
					<span class="service-item-name col-9"></span> 
					<span class="service-item-price col-3 text-right"></span>
					<input type="hidden" class="service-item-name" path="serviceName" value="" />
					<input type="hidden" class="service-item-price" path="servicePrice" value="" />
				</div>

				<%
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
					<input type="hidden" class="service-item-name" path="serviceName" value="<%=s1%>" />
					<input type="hidden" class="service-item-price" path="servicePrice" value="<%=s2%>" />
				</div>
				<% } %>
			</div>	           
	            
    		<div class="service-total-calc bill-bdr">	
				<%
					int total = 0, mktTotal = 0;
					if (session.getAttribute("customerBill") != null) {
						total = customerBill.getTotalPrice();
						mktTotal = customerBill.getMarketPrice();
					}
				%>
				<b>
				<div class="row">
					<div class="col-8">
						<span>Total:</span>
					</div>
					<div class="col-4 text-right">		
					<b>								
						<span class="text-dark" id="total-price">Rs. <%= total %></span>
						<input type="hidden" path="totalPrice" value="<%= total %>" />
					</b>
					</div>
				</div>
				</b>						
	    	</div>
	    
		    <div class="make-center">
		        <input type="button" value="Print" onclick="window.print()" /> 
		    </div>						
			<% } %>		
		</div>
	</div>

	<script type="text/javascript">
		var d = new Date();
		var m= d.getMonth()+ 1;
		document.getElementById("demo").innerHTML = d.getDate()+"/"+m+"/"+d.getFullYear();
	</script>
</body>
</html>