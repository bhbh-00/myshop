<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
body {
	margin-top: 125px;
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

</style>

<section class="section-adm-home-main">

	<div class="container mx-auto pb-10">
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
							class="mx-auto">
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

		<ul class="after w-full">
			<c:forEach items="${getForPrintNewUpdatedProducts}" var="product">

				<!-- 반복문 안에 임시변수를 넣어둘 수 있음! c:set -->
				<c:set var="detailUrl" value="detail?id=${product.id}" />
				<c:set var="thumbFileNo" value="${String.valueOf(1)}" />
				<c:set var="thumbFile"
					value="${product.extra.file__common__attachment[thumbFileNo]}" />
				<c:set var="thumbUrl" value="${thumbFile.getForPrintUrl()}" />

				<li class="left px-5 text-center lg:w-1/4 md:w-1/3 w-1/2">
					<a href="${detailUrl}">
						<img src="${thumbUrl}" alt=""
							onerror="${product.productFallbackImgOnErrorHtmlAttr}"
							class="mx-auto">
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

