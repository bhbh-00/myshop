<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<c:set var="fileInputMaxCount" value="5" />

<style>
body {
	margin-top: 150px;
}

th, td {
	padding: 10px;
}
</style>

<section class="section-order-product">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="ml-4 pb-7">
			<span class="text-2xl font-bold">제품확인</span>
		</div>

		<div class="px-4 py-4">

			<div class="flex justify-center">
				<!-- 프로필 -->
				<a href="#">
					<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
						<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
						<c:set var="file"
							value="${product.extra.file__common__attachment[fileNo]}" />
									${file.mediaHtml}
							</c:forEach>
				</a>
			</div>

			<table
				class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center mt-6 h-6">

				<tr class="border-b border-gray-400">
					<th>제품명</th>
					<td><a
							href="../order/add?productId=${product.id}&categoryId=${product.categoryId}"
							class="hover:underline">
							<span>${product.name}</span>
						</a></td>
				</tr>

				<tr class="border-b border-gray-400">
					<th>색상</th>
					<td><a
							href="../order/add?productId=${product.id}&categoryId=${product.categoryId}"
							class="hover:underline">
							<span>${product.color}</span>
						</a></td>
				</tr>

				<tr class="border-b border-gray-400">
					<th>가격</th>
					<td><a
							href="../order/add?productId=${product.id}&categoryId=${product.categoryId}"
							class="hover:underline">
							<span>${product.price}</span>
						</a></td>

				</tr>

				<tr class="border-b border-gray-400">

					<th>배송비</th>
					<td><a
							href="../order/add?productId=${product.id}&categoryId=${product.categoryId}"
							class="hover:underline">
							<span>${product.fee}</span>
						</a></td>
				</tr>

				<tr class="border-b border-gray-400">
					<th>결제 금액</th>
					<td>${product.fee + product.price}</td>
				</tr>
			</table>


			<div class="text-center text-lg font-bold mt-2 hover:underline">
				<a
					href="../order/add?productId=${product.id}&categoryId=${product.categoryId}">
					<span>결제하기</span>
				</a>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>