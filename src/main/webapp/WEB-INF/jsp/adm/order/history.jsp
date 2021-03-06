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

<section class="section-adm-order-history">

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
					<th>사이즈</th>
					<th>가격</th>
					<th>배송비</th>
					<th>결제 금액</th>
				</tr>

				<tr class="border-b border-gray-400">
					<td>${product.productName}</td>
					<td>${product.color}</td>
					<td>${product.size}</td>
					<td>${Util.numberFormat(product.price)}</td>
					<td>${Util.numberFormat(product.fee)}</td>
					<td>${Util.numberFormat(product.price + product.fee)}</td>
				</tr>

			</table>

			<div class="mt-10 text-center">
				<span class="text-lg font-bold">결제정보</span>
			</div>

			<div class="px-10">
				<table
					class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center mt-6 h-6">

					<tr class="border-b border-gray-400">
						<th>이름</th>
						<td>${order.orderName}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>연락처</th>
						<td>${order.cellphoneNo}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>우편번호</th>
						<td>${order.post}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>주소</th>
						<td>${order.address}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>상세주소</th>
						<td>${order.detailAddress}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>이메일</th>
						<td>${order.email}</td>
					</tr>

					<tr class="border-b border-gray-400">
						<th>결제수단</th>
						<c:if test="${order.payment == 1}">
							<td>무통장입금</td>
						</c:if>

						<c:if test="${order.payment == 2}">
							<td>신용카드</td>
						</c:if>
					</tr>

					<tr class="border-b border-gray-400">
						<th>결제금액</th>
						<td>${Util.numberFormat(product.price + product.fee)}</td>
					</tr>

					<tr>
						<th>결제상태</th>
						<td>입금 전</td>
						<c:if test="${order.paymentStatus == 1}">
							<td>입금완료</td>
						</c:if>
						<c:if test="${order.paymentStatus == 2}">
							<td>결제완료</td>
						</c:if>
					</tr>

				</table>
			</div>

			<div class="mt-10">
				<div class="text-center">
					<span class="text-lg font-bold">배송정보</span>
				</div>

				<table
					class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center mt-6 h-6">

					<c:choose>
						<c:when test="${delivery.deliveryState == null}">

							<tr class="border-b border-gray-400">
								<th>배송상태</th>
							</tr>

							<tr class="border-b border-gray-400">
								<td>배송전</td>
							</tr>

							<tr>
								<td><a href="/adm/delivery/add?orderId=${order.id}"><span class="text-blue-500 font-bold">입력</span></a></td>
							</tr>

						</c:when>

						<c:otherwise>
							<tr class="border-b border-gray-400">
								<th>배송상태</th>
								<th>택배사</th>
								<th>운송장번호</th>
								<th>배송날짜</th>
							</tr>

							<tr class="border-b border-gray-400">
								<c:if test="${delivery.deliveryState == 1}">
									<td>발송</td>
								</c:if>
								<c:if test="${delivery.deliveryState == 2}">
									<td>배송완료</td>
								</c:if>
								<td>${delivery.company}</td>
								<td>${delivery.waybillNum}</td>
								<td>${delivery.regDate}</td>
							</tr>
						</c:otherwise>
					</c:choose>

				</table>
			</div>

		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>