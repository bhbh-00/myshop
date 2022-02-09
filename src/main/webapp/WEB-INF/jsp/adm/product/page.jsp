<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script>
	param.categoryId = parseInt("${category.id}");
</script>


<section class="section-adm-product-page">

	<div class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative">
		<ul>
			<li>
				<a href="add">상품추가</a>
			</li>
			<li>
				<a href="#">상품수정</a>
			</li>
		</ul>
	</div>
		
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>