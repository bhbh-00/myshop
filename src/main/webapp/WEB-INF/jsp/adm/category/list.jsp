<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<section class="section-adm-product-page">

	<div class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative">

		<c:forEach items="${categorys}" var="category">

			<!-- 반복문 안에 임시변수를 넣어둘 수 있음! c:set -->
			<c:set var="detailUrl" value="detail?id=${category.id}" />
			<c:set var="thumbFileNo" value="${String.valueOf(1)}" />
			<c:set var="thumbFile"
				value="${product.extra.file__common__attachment[thumbFileNo]}" />
			<c:set var="thumbUrl" value="${thumbFile.getForPrintUrl()}" />

			<div class="p-4">

				<!-- 게시물 번호 -->
				<a href="${detailUrl}" class="hover:underline">
					<span class="text-base">No.${category.id}</span>
				</a>

				<div
					class="mt-3 grid sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3">

					<!-- 제목 -->
					<a href="${detailUrl}" class="hover:underline cursor-pointer">
						<span class="line-clamp-3 ml-1"> ${category.code} </span>
					</a>

					<!-- 본문 -->
					<a href="${detailUrl}"
						class="mt-3 hover:underline cursor-pointer col-span-1 sm:col-span-2 xl:col-span-3">
						<span class="line-clamp-3 ml-1"> ${category.name} </span>
					</a>

					<!-- 수정 -->
					<a href="modify?id=${ category.id }"
						class="hover:underline cursor-pointer">
						<span class="line-clamp-3 ml-1"> 수정 </span>
					</a>
				</div>
			</div>

		</c:forEach>

		<!-- 등록 -->
		<a href="add?categoryId=${ category.id }"
			class="hover:underline cursor-pointer">
			<span class="line-clamp-3 ml-1"> 등록 </span>
		</a>

	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>