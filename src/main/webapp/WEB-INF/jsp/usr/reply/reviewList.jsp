<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
body {
	overflow-x: hidden;
	margin: 0;
	padding: 0;
}

/* 2차메뉴 bg */
.bg {
	position: absolute;
	width: 100%;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 5;
	opacity: 0;
	visibility: hidden;
	transition: 1s;
}

.bg.active {
	opacity: 1;
	visibility: visible;
}

.nav-2dep {
	position: absolute;
	width: 80%;
	height: 100vh;
	background-color: white;
	z-index: 9;
	left: -100%;
	transition: 1s;
}

.nav-2dep.active {
	left: 0%;
}

.review-dep {
	position: absolute;
	right: 0;
	display: none;
}

.review-dep.active {
	display: block;
}
</style>

<script>
	param.productId = parseInt("${product.id}");
</script>

<section class="section-usr-reviews-list">

	<div class="bg"></div>
	<div class="nav-2dep">
		<div class="review-dep"></div>
	</div>

	<script>
		$(document).ready(function() {
			$(".review_img").click(function() {
				var $this = $(this);
				var $index = $this.index();

				if ($this.siblings().hasClass("active")) {
					$this.siblings().removeClass("active");
					$(".review-dep").removeClass("active");
				}

				if ($this.hasClass("active")) {
					$this.removeClass("active");
					$(".bg").removeClass("active");
					$(".nav-2dep").removeClass("active");
					$(".review-dep").eq($index).removeClass("active");
				} else {
					$this.addClass("active");
					$(".bg").addClass("active");
					$(".nav-2dep").addClass("active");
					$(".review-dep").eq($index).addClass("active");
				}
			});
		});
	</script>

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="flex pb-7 mt-28">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">${product.productName}</span>
			</div>

			<div class="flex-grow"></div>

			<div class="flex items-center mr-4 text-gray-500">
				<a href="addReview?relTypeCode=product&relId=${product.id}">
					<span>리뷰 작성</span>
				</a>
			</div>
		</div>

		<div class="p-4">
			<form class="flex">
				<select name="searchKeywordType">
					<option value="productNameAndBodyAndColor">전체</option>
					<option value="productName">상품명</option>
					<option value="body">내용</option>
					<option value="color">제목</option>
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

		<div class="container p-10 max-w-3xl min-w-max mx-auto text-center">
			<div class="flex grid grid-cols-3 gap-10">
				<c:forEach items="${reviews}" var="review">

					<!-- 반복문 안에 임시변수를 넣어둘 수 있음! c:set -->
					<c:set var="thumbFileNo" value="${String.valueOf(1)}" />
					<c:set var="thumbFile"
						value="${review.extra.file__common__attachment[thumbFileNo]}" />
					<c:set var="thumbUrl" value="${thumbFile.getForPrintUrl()}" />

					<div>
						<!-- 썸네일 -->
						<div class="flex justify-center review_img">
							<img src="${thumbUrl}" alt=""
								onerror="${review.reviewFallbackImgOnErrorHtmlAttr}">
						</div>

						<!-- 상품설명 -->
						<div class="py-4">
							<span> ${review.body} </span>
						</div>

						<!-- 작성자 / 등록날짜 수정날짜 -->
						<div class="text-xs my-2">
							<span class="mr-2">${review.extra__writer}</span>
							<span class="text-gray-600 text-light">${review.regDate}</span>
							<c:if test="${review.updateDate != review.regDate}">
								<span class="text-gray-600 text-light">${review.updateDate}</span>
							</c:if>
						</div>

						<c:if test="${review.memberId == loginedMember.id}">
							<!-- 상품설명 -->
							<div class="border-t border-gray-400 py-4 font-bold">
								<a href="modifyReview?productId=${product.id}&id=${review.id}">
									<span class="text-blue-600">수정</span>
								</a>

								<span class="mx-8"></span>
								<!-- 삭제 -->
								<a onclick="if ( !confirm('삭제하시겠습니까?') ) return false;"
									href="doDeleteReview?id=${review.id}">
									<span class="text-red-600">삭제</span>
								</a>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>
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