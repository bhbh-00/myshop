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

<script>
	const productId = parseInt("${product.id}");
</script>


<section class="section-order-product">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="pb-7">
			<span class="text-2xl ml-4 font-bold">제품확인</span>
		</div>

		<div class="px-4 py-4">

			<div class="flex justify-center"></div>

			<div class="px-10">

				<table
					class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center mt-6 h-6">

					<tr class="border-b border-gray-400">
						<th>제품명</th>
						<td>${product.productName}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>색상</th>
						<td>${product.color}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>사이즈</th>
						<td>${product.size}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>가격</th>
						<td>${Util.numberFormat(product.price)}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>배송비</th>
						<td>${Util.numberFormat(product.fee)}</td>
					</tr>

					<tr>
						<th>결제 금액</th>
						<td>${Util.numberFormat(product.price + product.fee)}</td>
					</tr>
				</table>

				<div
					class="text-center text-lg font-bold mt-4 hover:bg-black hover:text-gray-50">
					<a
						href="add?productId=${product.id}&categoryId=${product.categoryId}">
						<span>결제하기</span>
					</a>
				</div>

			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>