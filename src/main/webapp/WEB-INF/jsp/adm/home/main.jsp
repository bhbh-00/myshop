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

<section class="section-adm-home-main">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="flex pb-7">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">최근 업데이트 된 상품 목록</span>
			</div>
		</div>

		<div class="p-4">

			<table
				class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center h-6 font-medium">

				<thead>
					<tr>
						<th>번호</th>
						<th>코드</th>
						<th>이름</th>
						<th></th>
					</tr>
				</thead>

				<c:forEach items="${getForPrintNewUpdatedProducts}" var="product">
					<tbody>
						<tr>
							<td><span>${product.id}</span></td>
							<td><span>${product.productName}</span></td>
							<td><span>${product.body}</span></td>
						</tr>
					</tbody>
				</c:forEach>

			</table>
			
		</div>
		
		<div class="flex pb-7">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">오늘 업데이트 된 상품 목록</span>
			</div>
		</div>

		<div class="p-4">

			<table
				class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center h-6 font-medium">

				<thead>
					<tr>
						<th>번호</th>
						<th>코드</th>
						<th>이름</th>
						<th></th>
					</tr>
				</thead>

				<c:forEach items="${getForPrintNewUpdatedProducts}" var="product">
					<tbody>
						<tr>
							<td><span>${product.id}</span></td>
							<td><span>${product.productName}</span></td>
							<td><span>${product.body}</span></td>
						</tr>
					</tbody>
				</c:forEach>

			</table>
			
		</div>

		<div class="flex pt-10">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">최근 업데이트 된 공지사항</span>
			</div>
		</div>

		<div class="p-4">

			<table
				class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center h-6 font-medium">

				<thead>
					<tr>
						<th>번호</th>
						<th>코드</th>
						<th>이름</th>
						<th></th>
					</tr>
				</thead>

				<c:forEach items="${LatestArticleByBoardNameNotice}" var="artcle">
					<tbody>
						<tr>
							<td><span>${artcle.id}</span></td>
							<td><span>${artcle.title}</span></td>
							<td><span>${artcle.body}</span></td>
						</tr>
					</tbody>
				</c:forEach>

			</table>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>

