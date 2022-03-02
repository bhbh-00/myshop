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
body {
	background: #eee;
	margin: 0;
	padding: 0;
	overflow-x: hidden;
}

/* 제품 설명 */
th, td {
	padding: 10px;
}

/* 제품 이미지 */
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

<section class="section-usr-product-detail">

	<div class="container max-w-3xl min-w-max mx-auto p-5 relative">

		<!-- Swiper -->
		<div class="swiper mySwiper w-1/2 h-2/5 max-w-lg mt-24">
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


		<!-- 제품 정보 -->
		<div class="my-10">

			<table
				class="container text-center max-w-3xl min-w-max mx-auto p-5 mb-5">

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
					<td>${Util.numberFormat(product.price)}</td>
				</tr>

			</table>

			<div class="container text-center text-lg font-bold my-6">
				<span>" ${product.body} "</span>
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

		<div
			class="container text-center text-lg font-bold border border-gray-400 hover:bg-black hover:text-gray-50 mt-3">
			<a href="../order/product?productId=${product.id}">
				<span>구매하기</span>
			</a>
		</div>
	</div>


	<div
		class="container flex justify-center items-center text-center max-w-3xl min-w-max mx-auto p-5 mb-5 relative">

		<!-- 좋아요 -->
		<!-- 만약에 좋아요의 멤버아이디와 아이디가 같으면 채우진 하트 아니면 빈하트 -->
		<div class="w-1/3">
			<c:choose>
				<c:when test="${like.memberId == loginMemberId}">
					<a
						href="../like/doDelete?relTypeCode=product&relId=${product.id}&id=${like.id}&redirectUrl=../product/detail?id=${product.id}">
						<span class="">
							<!-- 하트 -->
							<i class="fab fa-gratipay text-pink-500 text-xl"></i>
						</span>
					</a>
				</c:when>

				<c:otherwise>
					<form class="grid form-type-1" action="../like/doLike"
						method="POST">

						<input type="hidden" name="relTypeCode" value="product" />
						<input type="hidden" name="relId" value="${product.id}" />
						<input type="hidden" name="like" value="like" />

						<input type="hidden" name="redirectUrl"
							value="../product/detail?id=${product.id}" />

						<button type="submit">
							<c:choose>
								<c:when test="${like.memberId == loginMemberId}">
									<i class="fab fa-gratipay text-pink-500 text-xl"></i>
								</c:when>

								<c:otherwise>
									<span class="">
										<i class="fab fa-gratipay text-xl"></i>
									</span>
								</c:otherwise>

							</c:choose>
						</button>
					</form>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- 장바구니 -->
		<div class="w-1/3 mx-3">
			<form class="grid form-type-1" action="../like/doLike" method="POST">

				<input type="hidden" name="relTypeCode" value="product" />
				<input type="hidden" name="relId" value="${product.id}" />
				<input type="hidden" name="like" value="like" />

				<input type="hidden" name="redirectUrl"
					value="../product/detail?id=${product.id}" />

				<button type="submit">
					<i class="fas fa-shopping-cart text-xl"></i>
				</button>
			</form>

		</div>

		<!-- 리뷰 -->
		<div class="w-1/3">
			<div class="review text-xl"><a href="../reply/reviewList?productId=${product.id}">review</a></div>
		</div>
	
	</div>



</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>