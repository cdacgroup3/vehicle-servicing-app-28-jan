$(document).ready(function() {
	$("#servicing-service").click(function name() {
		window.location.href="../vehicle-servicing-app/servicing.htm";
	});
	
	$("#repairing-service").click(function name() {
		window.location.href="../vehicle-servicing-app/repairing.htm";
	});
	
	$("#denting-service").click(function name() {
		window.location.href="../vehicle-servicing-app/denting.htm";
	});
	
	$("#emergency-service").click(function name() {
		window.location.href="../vehicle-servicing-app/emergency.htm";
	});
	
	$("#servicing-service-tab").click(function name() {
		$(".service-info-book").attr("data-visible", "false");
		$(".service-info-book").eq(0).attr("data-visible", "true");
		$(this).parent().siblings().removeClass('active');
		$(this).parent().addClass('active');
	});
	
	$("#repairing-service-tab").click(function name() {
		$(".service-info-book").attr("data-visible", "false");
		$(".service-info-book").eq(1).attr("data-visible", "true");
		$(this).parent().siblings().removeClass('active');
		$(this).parent().addClass('active');
	});
	
	$("#denting-service-tab").click(function name() {
		$(".service-info-book").attr("data-visible", "false");
		$(".service-info-book").eq(2).attr("data-visible", "true");
		$(this).parent().siblings().removeClass('active');
		$(this).parent().addClass('active');
	});
	
	$("#emergency-service-tab").click(function name() {
		$(".service-info-book").attr("data-visible", "false");
		$(".service-info-book").eq(3).attr("data-visible", "true");
		$(this).parent().siblings().removeClass('active');
		$(this).parent().addClass('active');
	});
	
	let sum = parseInt($('#total-price').text().slice(3));
	let marketsum = parseInt($("#market-price del").text().slice(3));
	
	$(".book-checkout").click(function name() {		
		let serviceName = $(this).closest(".checkout-service").find(".checkout-service-name")[0].innerHTML;
		let servicePrice = $(this).closest(".checkout-service").find(".checkout-price")[0].innerHTML;
		let marketPrice = $(this).closest(".checkout-service").find(".market-price")[0].innerHTML.slice(3);
		let newChild = $("#service-item-dummy").clone(true);
		$(newChild).removeAttr("id");
		$(newChild).attr("data-id", serviceName);
		$(newChild).find(".service-item-name")[0].innerHTML = serviceName;
		$(newChild).find(".service-item-name")[1].value = serviceName;		
		$(newChild).find(".service-item-price")[0].innerHTML = "Rs. " + servicePrice;
		$(newChild).find(".service-item-price")[1].value = servicePrice;
		$(this).prop("disabled", true);
		$(this).next().removeClass("d-none");
		$(".service-list").append(newChild);	
		$("#checkout-login").next('span').remove();
		
		marketsum += parseInt(marketPrice);
		$(".service-total-calc").find("#market-price del")[0].innerHTML = "Rs. " + marketsum;
		$(".service-total-calc").find("#market-price").next().val(marketsum);
		sum += parseInt(servicePrice);
		$(".service-total-calc").find("#total-price")[0].innerHTML = "Rs. " + sum;
		$(".service-total-calc").find("#total-price").next().val(sum);
		let saved = Number(marketsum) - Number(sum);
		$(".service-total-calc").find("#save-price")[0].innerHTML="Rs. " + saved;		
	});
	
	$(".service-remove").click(function name() {
		let serviceName = $(this).closest(".checkout-service").find(".checkout-service-name")[0].innerHTML;
		let servicePrice = $(this).closest(".checkout-service").find(".checkout-price")[0].innerHTML;
		let marketPrice = $(this).closest(".checkout-service").find(".market-price")[0].innerHTML.slice(3);
		$("div[data-id='" + serviceName +"']").remove();
		$(this).prev().prop("disabled", false);
		$(this).addClass("d-none");		

		marketsum -= parseInt(marketPrice);
		$(".service-total-calc").find("#market-price del")[0].innerHTML="Rs. " + marketsum;
		$(".service-total-calc").find("#market-price").next().val(marketsum);
		sum -= parseInt(servicePrice);
		$(".service-total-calc").find("#total-price")[0].innerHTML="Rs. " + sum;
		$(".service-total-calc").find("#total-price").next().val(sum);
		let saved = Number(marketsum) - Number(sum);
		$(".service-total-calc").find("#save-price")[0].innerHTML="Rs. " + saved;		
	});
});

function SolidCost(elem){
	$('.dent-paint-options').find('button').removeClass('btn-dark').addClass('btn-secondary');
	$(elem).removeClass('btn-secondary').addClass('btn-dark');
    document.getElementById("cp1").innerHTML = "2100";
    document.getElementById("mp1").innerHTML = "Rs. 2700";

    document.getElementById("cp2").innerHTML = "2000";
    document.getElementById("mp2").innerHTML = "Rs. 2600";

    document.getElementById("cp3").innerHTML = "2100";
    document.getElementById("mp3").innerHTML = "Rs. 2700";

    document.getElementById("cp4").innerHTML = "2100";
    document.getElementById("mp4").innerHTML = "Rs. 2700";

    document.getElementById("cp5").innerHTML = "2000";
    document.getElementById("mp5").innerHTML = "Rs. 2600";

    document.getElementById("cp6").innerHTML = "2300";
    document.getElementById("mp6").innerHTML = "Rs. 2990";
    
    document.getElementById("cp7").innerHTML = "2300";
    document.getElementById("mp7").innerHTML = "Rs. 2990";

    document.getElementById("cp8").innerHTML = "2100";
    document.getElementById("mp8").innerHTML = "Rs. 2700";

    document.getElementById("cp8").innerHTML = "33000";
    document.getElementById("mp8").innerHTML = "Rs. 42500";
}

function MetallicCost(elem){
	$('.dent-paint-options').find('button').removeClass('btn-dark').addClass('btn-secondary');
	$(elem).removeClass('btn-secondary').addClass('btn-dark');
    document.getElementById("cp1").innerHTML = "2900";
    document.getElementById("mp1").innerHTML = "Rs. 3770";

    document.getElementById("cp2").innerHTML = "2900";
    document.getElementById("mp2").innerHTML = "Rs. 3770";

    document.getElementById("cp3").innerHTML = "2200";
    document.getElementById("mp3").innerHTML = "Rs. 2860";

    document.getElementById("cp4").innerHTML = "2200";
    document.getElementById("mp4").innerHTML = "Rs. 2860";

    document.getElementById("cp5").innerHTML = "3000";
    document.getElementById("mp5").innerHTML = "Rs. 3900";

    document.getElementById("cp6").innerHTML = "3000";
    document.getElementById("mp6").innerHTML = "Rs. 3900";
    
    document.getElementById("cp7").innerHTML = "2900";
    document.getElementById("mp7").innerHTML = "Rs. 3770";

    document.getElementById("cp8").innerHTML = "2200";
    document.getElementById("mp8").innerHTML = "Rs. 2860";

    document.getElementById("cp9").innerHTML = "44000";
    document.getElementById("mp9").innerHTML = "Rs. 57200";
}

function PearlCost(elem){
	$('.dent-paint-options').find('button').removeClass('btn-dark').addClass('btn-secondary');
	$(elem).removeClass('btn-secondary').addClass('btn-dark');
	document.getElementById("cp1").innerHTML = "2900";
    document.getElementById("mp1").innerHTML = "Rs. 3770";

    document.getElementById("cp2").innerHTML = "2900";
    document.getElementById("mp2").innerHTML = "Rs. 3770";

    document.getElementById("cp3").innerHTML = "2200";
    document.getElementById("mp3").innerHTML = "Rs. 2860";

    document.getElementById("cp4").innerHTML = "2200";
    document.getElementById("mp4").innerHTML = "Rs. 2860";

    document.getElementById("cp5").innerHTML = "3000";
    document.getElementById("mp5").innerHTML = "Rs. 3900";

    document.getElementById("cp6").innerHTML = "3000";
    document.getElementById("mp6").innerHTML = "Rs. 3900";
    
    document.getElementById("cp7").innerHTML = "2900";
    document.getElementById("mp7").innerHTML = "Rs. 3770";

    document.getElementById("cp8").innerHTML = "2200";
    document.getElementById("mp8").innerHTML = "Rs. 2860";

    document.getElementById("cp9").innerHTML = "44000";
    document.getElementById("mp9").innerHTML = "Rs. 57200";
}