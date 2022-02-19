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
						<td><a href="history?id=${ order.id }" class="hover:underline">
								<span class="text-blue-500 font-semibold">주문내역</span>
							</a></td>
					</tr>
				</tbody>
			</c:forEach>

		</table>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>