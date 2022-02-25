<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<!-- lodash -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<c:set var="fileInputMaxCount" value="5" />

<style>
html, body {
	position: relative;
	height: 100%;
	margin-top: 125px;
}

body {
	background: #eee;
	margin: 0;
	padding: 0;
}

th, td {
	padding: 10px;
}

.swiper-slide {
	text-align: center;
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

<section class="section-adm-product-detail">

	<div class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative">

		<!-- Swiper -->
		<div class="swiper mySwiper w-1/2 h-2/5 max-w-lg">
			<div class="swiper-wrapper">
				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
					<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
					<c:set var="file"
						value="${product.extra.file__common__attachment[fileNo]}" />
					<c:set var="detailUrl" value="detail?id=${product.id}" />
					<div class="swiper-slide">${file.mediaHtml}</div>

				</c:forEach>
			</div>
			<div class="swiper-pagination"></div>
		</div>

		<div class="p-10">

			<table class="container max-w-3xl min-w-max mx-auto p-5 mb-5">

				<tr class="border-b border-gray-400">
					<th>제품명</th>
					<td>${product.productName}</td>
				</tr>

				<tr class="border-b border-gray-400">
					<th>색상</th>
					<td>${product.color}</td>
				</tr>

				<tr class="border-b border-gray-400">
					<th>가격</th>
					<td>${product.price}</td>
				</tr>

			</table>

			<div
				class="container text-center text-lg font-bold m-6">
				<span>${product.body}</span>
			</div>

			<div
				class="container text-center text-lg font-bold border border-gray-400 hover:bg-black hover:text-gray-50">
				<a href="../order/product?productId=${product.id}">
					<span>구매하기</span>
				</a>
			</div>

		</div>

		<!-- Swiper JS -->
		<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

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
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>