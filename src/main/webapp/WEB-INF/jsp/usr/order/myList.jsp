<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
body {
	margin-top: 150px;
}

th, td {
	padding: 10px;
}
</style>

<section class="section-adm-category-list">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="flex pb-7">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">주문내역</span>
			</div>
		</div>

		<div class="py-7 px-2">
			<c:forEach items="${orders}" var="order">

				<div class="flex container mx-auto border-b border-gray-400">
					<div class="items-center font-bold">
						<span>${order.regDate}</span>
					</div>
					<div class="flex-grow"></div>

					<div class="flex text-blue-500 font-bold">
						<a href="history?id=${ order.id }" class="hover:underline">
							<span>주문상세</span>
							<span class="mx-1"></span>
							<i class="fas fa-angle-right"></i>
						</a>
					</div>
				</div>

				<div class="item-bt-1">
					<div class="flex py-5 px-4">
						<div class="flex-shrink-0">
							<a href="${detailUrl}">
								<img
									class="w-16 h-16 object-cover rounded-full shadow mr-2 cursor-pointer"
									alt="Product img" src="${order.thumbImgUrl}"
									onerror="${order.productFallbackImgOnErrorHtmlAttr}">
							</a>
						</div>
						<div class="flex-grow px-1">
							<div class="font-semibold">
								<span>${order.extra__productName}</span>
							</div>
							<div class="flex text-gray-400 text-light text-sm">
								<span>${order.extra__productColor}</span>
								<span class="mx-1">/</span>
								<span>${order.extra__productSize}</span>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<!-- 페이징 -->
		<nav class="flex justify-center pt-3" aria-label="Pagination">

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