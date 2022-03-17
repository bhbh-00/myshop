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
				<span class="ml-4 text-2xl font-bold">주문 관리</span>
			</div>
		</div>

		<div class="flex py-5 px-12 border-t font-semibold">
			<div class="flex-grow">
				<div>
					<span>총 주문내역 수</span>
					<span class="px-2">:</span>
					<span>${Util.numberFormat(totleItemsCount)}</span>
				</div>
			</div>
			<div>
				<span>오늘 주문 수</span>
				<span class="px-2">:</span>
				<span>${Util.numberFormat(TodayItemsCount)}</span>
			</div>
		</div>

		<div class="py-5 px-12">
			<form class="flex">
				<select name="searchKeywordType">
					<option value="regDateAndproductId">전체</option>
					<option value="regDate">등록날짜</option>
					<option value="productId">상품 번호</option>
				</select>

				<script>
					/* 값이 있다면 */
					if (param.searchKeywordType) {
						$('.section-adm-product-list select[name="searchKeywordType"]').val(param.searchKeywordType);
					}
				</script>

				<input autofocus="autofocus" type="text" style="border-radius: 25px"
					placeholder="검색어를 입력해주세요" name="searchKeyword" maxlength="20"
					autocomplete="off" value="${param.searchKeyword}"
					class="w-full py-2 pl-4 pr-10 text-sm bg-gray-100 border border-transparent appearance-none rounded-tg placeholder-gray-400
								focus:bg-white focus:outline-none focus:border-blue-500 focus:text-gray-900 focus:shadow-outline-blue" />

				<button type="submit" class="ml-2">
					<i class="fas fa-pen"></i>
				</button>

			</form>
		</div>


		<div class="pt-10">
			<table
				class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center h-6 font-medium">

				<thead>
					<tr>
						<th>번호</th>
						<th>주문날짜</th>
						<th></th>
					</tr>
				</thead>

				<c:forEach items="${orders}" var="order">
					<tbody>
						<tr>
							<td>${order.id}</td>
							<td>${order.regDate}</td>
							<td><a href="history?id=${ order.id }"
									class="hover:underline">
									<span class="text-blue-500 font-semibold">주문내역</span>
								</a></td>
						</tr>
					</tbody>
				</c:forEach>

			</table>
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