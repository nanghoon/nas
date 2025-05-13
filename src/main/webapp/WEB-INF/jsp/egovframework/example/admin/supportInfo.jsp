<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//Dth HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dth">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="adminFrame/header.jsp"></jsp:include>
<style>
.form-control[readonly]{background-color:#fff}
</style>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="adminFrame/left.jsp"></jsp:include>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">문의 내용</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">문의내용</div>
						<div class="panel-body">
							<form action="/nas/admin/supportInfo.do" name="listForm" id="listForm">
								<input type="hidden" name="idx" value="${info.idx}" />
								<div class="row">
					                <div class="col-lg-6">
						                <div class="form-group">
                                            <label>병원/업체명</label>
                                            <p class="form-control">${info.company}</p>
                                        </div>
									</div>
					                <div class="col-lg-6">
						                <div class="form-group">
                                            <label>이름</label>
                                            <p class="form-control">${info.name}</p>
                                        </div>
									</div>
					            </div> 
								<div class="row">
					                <div class="col-lg-6">
						                <div class="form-group">
                                            <label>휴대폰</label>
                                            <p class="form-control">${info.phone}</p>
                                        </div>
									</div>
					                <div class="col-lg-6">
						                <div class="form-group">
                                            <label>이메일</label>
                                            <p class="form-control">${info.email}</p>
                                        </div>
									</div>
					            </div> 
								<div class="row">
					                <div class="col-lg-6">
						                <div class="form-group">
                                            <label>문의내용</label>
                                            <textarea class="form-control" rows="10" readonly>${info.text}</textarea>
                                        </div>
									</div>
					                <div class="col-lg-6">
						                <div class="form-group">
                                            <label>문의 날짜</label>
                                            <p class="form-control"><fmt:formatDate value="${info.sdate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                        </div>
									</div>
					            </div> 
							</form>
						</div>
					</div>
					<button type="button" onclick="javasript:location.href='/nas/admin/support.do'" class="btn btn-info">목록으로</button>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="adminFrame/footer.jsp"></jsp:include>
</body>
</html>