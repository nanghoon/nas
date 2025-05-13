<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html PUBLIC "-//W3C//Dth HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dth">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="adminFrame/header.jsp"></jsp:include>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="adminFrame/left.jsp"></jsp:include>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">문의 내역</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading"></div>
						<div class="panel-body">
							<form action="/nas/admin/support.do" name="listForm" id="listForm">
								<input type="hidden" name="pageIndex" value="1" />
							</form>
							<div class="table-responsive">
								<table class="table table-hover table-bordered">
									<thead>
										<tr>
											<th>병원/업체명</th>
											<th>이름</th>
											<th>연락처</th>
											<th>이메일</th>
											<th>날짜</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="item" items="${list}">
											<tr onclick="location.href='/nas/admin/supportInfo.do?idx=${item.idx}'" style="cursor:pointer;">
												<td>${item.company}</td>
												<td>${item.name}</td>
												<td>${item.phone}</td>
												<td>${item.email}</td>
												<td><fmt:formatDate value="${item.sdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12" style="text-align:center;">
								<ul class="pagination">
									<ui:pagination paginationInfo="${pi}" type="admin" jsFunction="page" />
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="adminFrame/footer.jsp"></jsp:include>
<script>

function page(pageNo) {
	document.listForm.pageIndex.value = pageNo;
   	document.listForm.submit();
}

</script>
</body>
</html>