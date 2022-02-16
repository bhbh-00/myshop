<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
body {
	margin-top: 150px;
}

th,td {
	padding: 10px;
}
</style>

<section class="section-adm-category-list">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child overflow-auto">

		<div class="pb-7">
			<span class="ml-4 text-2xl font-bold">카테고리 목록</span>
		</div>

		<table
			class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center h-6">
			<thead>
				<tr>
					<th>번호</th>
					<th>코드</th>
					<th>이름</th>
					<th></th>
				</tr>
			</thead>

			<c:forEach items="${categorys}" var="category">

				<!-- 반복문 안에 임시변수를 넣어둘 수 있음! c:set -->
				<c:set var="detailUrl" value="detail?id=${category.id}" />

				<tbody>
					<tr>
						<td><a href="${detailUrl}" class="hover:underline">
								<span>${category.id}</span>
							</a></td>
						<td><a href="${detailUrl}" class="hover:underline">
								<span>${category.code}</span>
							</a></td>
						<td><a href="${detailUrl}" class="hover:underline">
								<span>${category.name}</span>
							</a></td>
						<td><a href="modify?id=${ category.id }"
								class="hover:underline">
								<span class="line-clamp-3 ml-1"> 수정 </span>
							</a></td>
					</tr>
				</tbody>
			</c:forEach>

		</table>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>