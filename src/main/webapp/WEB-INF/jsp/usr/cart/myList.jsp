<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
body {
	margin-top: 125px;
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


<section class="section-adm-category-list">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="pb-7">
			<div class="ml-2">
				<span class="ml-4 text-2xl font-bold">장바구니</span>
			</div>
		</div>

		<div class="container mx-auto">

			<div class="item-bt-1">
				<c:forEach items="${products}" var="product">
					<!-- 반복문 안에 임시변수를 넣어둘 수 있음! c:set -->
					<c:set var="detailUrl" value="../product/detail?id=${product.id}" />
					<c:set var="thumbFileNo" value="${String.valueOf(1)}" />
					<c:set var="thumbFile"
						value="${product.extra.file__common__attachment[thumbFileNo]}" />
					<c:set var="thumbUrl" value="${thumbFile.getForPrintUrl()}" />
					<div class="flex py-5 px-4">
						<div class="flex-shrink-0">
							<a href="${detailUrl}">
								<img
									class="w-16 h-16 object-cover rounded-full shadow mr-2 cursor-pointer"
									alt="Product img" src="${thumbUrl}"
									onerror="${product.productFallbackImgOnErrorHtmlAttr}">
							</a>
						</div>
						<div class="flex-grow px-1">
							<div class="font-semibold">
								<span>${product.productName}</span>
							</div>
							<div class="flex text-gray-400 text-light text-sm">
								<span>${product.color}</span>
								<span class="mx-1">/</span>
								<span>${product.size}</span>
							</div>
						</div>
						<div class="font-medium">
							<span>상품 가격 ${Util.numberFormat(product.price)}원</span>
							<span class="mx-1">/</span>
							<span>배송비 ${Util.numberFormat(product.fee)}원</span>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

		<div
			class="mt-7 p-2 text-center border border-gray-400 hover:bg-black hover:text-gray-50">
			<a href="../order/product?productId=${1}">
				<span>구매하기</span>
			</a>
		</div>

	</div>

	<!-- 페이징 -->
	<nav class="flex justify-center" aria-label="Pagination">

		<!-- 시작 페이지 -->
		<!-- 내가 보고 있는 페이지 챕터가 첫번째이면 < 표시 안보이게 -->
		<c:if test="${pageMenuStart != 1}">
			<a href="${Util.getNewUrl(requestUrl, 'page', 1)}"
				class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
				<span class="sr-only">Previous</span>
				<i class="fas fa-chevron-left"></i>
			</a>
		</c:if>

		<!-- 페이지 번호 -->
		<c:forEach var="i" begin="${pageMenuStrat}" end="${pageMenuEnd}">
			<c:set var="aClassStr"
				value="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium" />

			<c:set var="aClassStr" value="${aClassStr} active" />

			<!-- 현재 페이지 -->
			<c:if test="${i == page}">
				<c:set var="aClassStr"
					value="${aClassStr} text-red-700 hover:bg-red-50" />
			</c:if>

			<!-- 현재 페이지가 아닌 -->
			<c:if test="${i != page}">
				<c:set var="aClassStr"
					value="${aClassStr} text-gray-700 hover:bg-gray-50" />
			</c:if>

			<a href="${Util.getNewUrl(requestUrl, 'page', i)}"
				class="${aClassStr}">${i}</a>
		</c:forEach>

		<!-- 마지막 페이지 -->
		<!-- 내가 보고 있는 페이지 챕터가 마지막이면 > 표시 안보이게 -->
		<c:if test="${pageMenuEnd != totalPage}">
			<a href="${Util.getNewUrl(requestUrl, 'page', totalPage)}"
				class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
				<span class="sr-only">Next</span>
				<i class="fas fa-chevron-right"></i>
			</a>
		</c:if>
	</nav>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>