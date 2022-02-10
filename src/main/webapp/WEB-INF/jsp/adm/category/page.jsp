<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<section class="section-adm-category-page">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child bg-red-500">
		<ul>
			<li>
				<a href="add?boardId=${ board.id }">카테고리 생성</a>
			</li>
			<li>
				<a href="#">상품수정</a>
			</li>
		</ul>
	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>