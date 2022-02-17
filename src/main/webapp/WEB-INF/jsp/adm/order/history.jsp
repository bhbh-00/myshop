<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<section class="section-order-history">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="pb-7">
			<span class="ml-4 text-2xl font-bold">주문내역</span>
		</div>

		<div class="px-4 py-4">

			<div class="text-center">
				<span class="text-lg font-bold">제품정보</span>
			</div>

			<table
				class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center mt-6 h-6">

				<tr class="border-b border-gray-400">
					<th>제품명</th>
					<th>색상</th>
					<th>가격</th>
					<th>배송비</th>
					<th>결제 금액</th>
				</tr>

				<tr class="border-b border-gray-400">
					<td>${product.productName}</td>
					<td>${product.color}</td>
					<td>${product.price}</td>
					<td>${product.fee}</td>
					<td>${product.fee + product.price}</td>
				</tr>

			</table>
			
			<div class="mt-10 text-center">
				<span class="text-lg font-bold">결제정보</span>
			</div>
			
			<div  class="px-10">
				<table
					class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center mt-6 h-6">

					<tr class="border-b border-gray-400">
						<th>주문번호</th>
						<td>${order.orderCode}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>이름</th>
						<td>${order.orderName}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>연락처</th>
						<td>${order.cellphoneNo}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>주소</th>
						<td>${order.address}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>이메일</th>
						<td>${order.email}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>결제수단</th>
						<td>${order.payment}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>결제금액</th>
						<td>${order.totalPayment}</td>
					</tr>

				</table>
			</div>
			
			<div class="mt-10 text-center">
				<span class="text-lg font-bold">배송정보</span>
			</div>
			
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>