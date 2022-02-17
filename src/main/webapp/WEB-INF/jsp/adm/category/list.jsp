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

		<div class="pb-7">
			<span class="ml-4 text-2xl font-bold">카테고리 목록</span>
		</div>

		<div class="p-4">
			<form class="flex">
				<select name="searchKeywordType">
					<option value="codeAndCategoryName">전체</option>
					<option value="code">코드</option>
					<option value="categoryName">내용</option>
				</select>

				<script>
					/* 값이 있다면 */
					if (param.searchKeywordType) {
						$('.section-adm-category-list select[name="searchKeywordType"]').val(param.searchKeywordType);
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

			<c:forEach items="${categorys}" var="category">

				<!-- 반복문 안에 임시변수를 넣어둘 수 있음! c:set -->
				<c:set var="detailUrl" value="detail?id=${category.id}" />

				<tbody>
					<tr>
						<td><span>${category.id}</span></td>
						<td><span>${category.code}</span></td>
						<td><span>${category.categoryName}</span></td>
						<td><a href="modify?id=${ category.id }"
								class="hover:underline"><span class="text-blue-500 font-semibold">수정</span>
							</a></td>
						<td><a onclick="if ( !confirm('삭제하시겠습니까?') ) return false;" href="doDelete?id=${ category.id }"
								class="text-red-600">
								<i class="fas fa-times"></i>
							</a></td>
					</tr>
				</tbody>
			</c:forEach>

		</table>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>