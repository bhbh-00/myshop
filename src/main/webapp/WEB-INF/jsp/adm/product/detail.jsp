<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
html, .product-detail-img-box {
	position: relative;
	height: 100%;
}

body {
	margin-top: 125px;
}

.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
	/* Center slide text vertically */
	display: -webkit-box;
	display: -ms-flexbox;
	display: -webkit-flex;
	display: flex;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	-webkit-justify-content: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	-webkit-align-items: center;
	align-items: center;
}

.swiper-slide img {
	display: block;
	width: 100%;
	height: 100%;
	object-fit: cover;
}
</style>

<!-- Initialize Swiper -->
<script>
	var swiper = new Swiper(".mySwiper", {
		spaceBetween : 30,
		pagination : {
			el : ".swiper-pagination",
			clickable : true,
		},
	});
</script>

<section class="section-usr-product-detail">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative bg-red-100">

		<div
			class="product-detail-img-box mx-auto w-9 min-w-max h-500 min-h-full">
		</div>
		
		<div><a href="../order/product?productId=${product.id}">주문하기</a></div>

	</div>


</section>
<%@ include file="../part/mainLayoutFoot.jspf"%>