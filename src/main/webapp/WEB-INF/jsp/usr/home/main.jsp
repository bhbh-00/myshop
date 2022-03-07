<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
html, body {
	position: relative;
	height: 100%;
	margin-top: 125px;
}

body {
	margin: 0;
	padding: 0;
}

th, td {
	padding: 10px;
}

.after::after {
	display: block;
	content: "";
	clear: both;
}

/* float : left */
.left {
	float: left;
}

/* float : right */
.right {
	float: right;
}

/* 배너 */
.swiper {
	width: 100%;
	height: 100%;
}

.swiper-slide {
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

<section class="section-adm-home-main">

	<!-- 배너 -->
	<!-- Swiper -->
	<div class="swiper mySwiper mb-11 border border-gray-400">
		<div class="swiper-wrapper p-5 container text-center">
			<c:forEach items="${LatestArticleByBoardNameNotice}" var="notice">
				<div class="swiper-slide">
					<span class="text-lg font-bold">
						notice
						<br>${notice.body}</span>
				</div>
			</c:forEach>
		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
	</div>

	<!-- Swiper JS -->
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

	<!-- Initialize Swiper -->
	<script>
		var swiper = new Swiper(".mySwiper", {
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
		});
	</script>

	<div class="container mx-auto pb-10">

		<div class="text-center mb-5 font-bold">Today</div>

		<!-- 오늘 업데이트 된 상품 -->
		<ul class="after w-full">
			<c:forEach items="${getForPrintTodayUpdatedProducts}" var="product">

				<!-- 반복문 안에 임시변수를 넣어둘 수 있음! c:set -->
				<c:set var="detailUrl" value="../product/detail?id=${product.id}" />
				<c:set var="thumbFileNo" value="${String.valueOf(1)}" />
				<c:set var="thumbFile"
					value="${product.extra.file__common__attachment[thumbFileNo]}" />
				<c:set var="thumbUrl" value="${thumbFile.getForPrintUrl()}" />


				<li class="left px-3 text-center lg:w-1/4 md:w-1/3 w-1/2">
					<a href="${detailUrl}">
						<img src="${thumbUrl}" alt=""
							onerror="${product.productFallbackImgOnErrorHtmlAttr}"
							class="mx-auto h-80">
					</a>

					<div class="m-4">
						<span class="text-lg font-semibold"> ${product.productName}
						</span>
					</div>

					<div class="pb-10">
						<span class="text-gray-600 text-light">${product.regDate}</span>
						<c:if test="${product.updateDate != product.regDate}">
							<span class="text-gray-600 text-light">${product.updateDate}</span>
						</c:if>

					</div>
				</li>
			</c:forEach>
		</ul>

		<!-- 최근 업데이트 된 상품 -->
		<ul class="after w-full">
			<c:forEach items="${getForPrintNewUpdatedProducts}" var="product">

				<!-- 반복문 안에 임시변수를 넣어둘 수 있음! c:set -->
				<c:set var="detailUrl" value="../product/detail?id=${product.id}" />
				<c:set var="thumbFileNo" value="${String.valueOf(1)}" />
				<c:set var="thumbFile"
					value="${product.extra.file__common__attachment[thumbFileNo]}" />
				<c:set var="thumbUrl" value="${thumbFile.getForPrintUrl()}" />

				<li class="left px-5 text-center lg:w-1/4 md:w-1/3 w-1/2">
					<a href="${detailUrl}">
						<img src="${thumbUrl}" alt=""
							onerror="${product.productFallbackImgOnErrorHtmlAttr}"
							class="mx-auto h-80">
					</a>

					<div class="m-4">
						<span class="text-lg font-semibold"> ${product.productName}
						</span>
					</div>

					<div>
						<span class="text-gray-600 text-light">${product.regDate}</span>
						<c:if test="${product.updateDate != product.regDate}">
							<span class="text-gray-600 text-light">${product.updateDate}</span>
						</c:if>

					</div>
				</li>
			</c:forEach>
		</ul>
	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>

