<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html PUBLIC "-//W3C//Dth HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dth">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="adminFrame/header.jsp"></jsp:include>
<style>
th, td {
	width: 25%;
}
</style>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="adminFrame/left.jsp"></jsp:include>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Account Info</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading"></div>
						<div class="panel-body">
							<form action="/nas/admin/userInfo.do" name="listForm" id="listForm">
								<input type="hidden" name="pageIndex" value="1" />
								<input type="hidden" name="idx" value="${info.idx}" />
								<div class="row">
					                <div class="col-lg-12">
			                            <h4>Account</h4>
			                            <div class="table-responsive">
			                                <table class="table table-bordered">
			                                    <tbody>
			                                        <tr>
			                                            <th>Status</th>
			                                            <td>${info.status == 0 ? 'Active' : 'Frozen'}</td>
			                                            <th>Nickname</th>
			                                            <td>${info.nick}</td>
			                                        </tr>
			                                        <tr>
			                                            <th>Date of joining</th>
			                                            <td><fmt:formatDate value="${info.mdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			                                            <th>Mail</th>
			                                            <td>${info.email}</td>
			                                        </tr>
			                                        <tr>
			                                            <th>Date of birth</th>
			                                            <td><fmt:formatDate value="${info.birth}" pattern="yyyy-MM-dd"/></td>
			                                            <th>Wallet</th>
			                                            <td>${info.wallet}</td>
			                                        </tr>
			                                    </tbody>
			                                </table>
			                                <div style="text-align:right;">
			                                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">Freeze</button>
			                                </div>
											<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
															<h4 class="modal-title" id="myModalLabel"></h4>
														</div>
														<div class="modal-body">
															<textarea id="dmemo" name="dmemo" maxlength="50" rows="5" class="form-control" placeholder="Please write in 50 characters or less.">${info.dmemo}</textarea>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
															<button type="button" class="btn btn-primary" onclick="javascript:updateUserStatus(${info.idx}, 1)">Save changes</button>
														</div>
													</div>
												</div>
											</div>
										</div> 
			                            <h4>Finance</h4>
			                            <div class="table-responsive">
			                                <table class="table table-bordered">
			                                    <tbody>
			                                        <tr>
			                                            <th>Money</th>
			                                            <td><fmt:formatNumber value="${info.money}"/></td>
			                                            <%-- <th>Rakes</th>
			                                            <td><fmt:formatNumber value="${info.rake}"/></td> --%>
			                                        </tr>
			                                        <%-- <tr>
			                                            <th>Reward Rank</th>
			                                            <td>${info.rlev}</td>
			                                            <th>Reward Point</th>
			                                            <td><fmt:formatNumber value="${info.reward}"/> / <fmt:formatNumber value="${info.nrpe}"/></td>
			                                        </tr> --%>
			                                    </tbody>
			                                </table>
			                            </div> <br>
			                            <h4>Referral</h4>
			                            <div class="table-responsive">
			                                <table class="table table-bordered">
			                                    <tbody>
			                                        <tr>
			                                            <th style="vertical-align: middle;">Referral(%)</th>
			                                            <td><input type="text" class="form-control" placeholder="Referral" name="fee" oninput="this.value = this.value.replace(/[^\d.]*([^\d.].*|\.(?=.*\.))/g, '');" value="${info.fee}"></td>
			                                            <th style="vertical-align: middle;">Referral Code</th>
			                                            <td style="vertical-align: middle;">${info.lev == 2 ? info.code : 'Only agents have invitation codes'}</td>
			                                        </tr>
			                                        <tr>
			                                            <th style="vertical-align: middle;">Level</th>
			                                            <td style="vertical-align: middle;" ${info.lev == 3 ? 'colspan=3' : '' }>${info.lev == 3 ? 'Agency' : (info.lev == 2 ? 'Agent' : 'User')}</td>
			                                            <c:if test="${info.lev == 1}">
				                                            <th style="vertical-align: middle;">Change Level / Top Agent Settings</th>
				                                            <td>
				                                            	<c:if test="${info.recom == -1}">
				                                            		<button type="button" class="btn btn-success" onclick="javascript:changeLev(${info.idx},3 ,-1)">Change to Agency</button>
				                                            		<button type="button" class="btn btn-warning" onclick="javascript:getAgencyList(${info.idx})">Change to Agent</button>
				                                            		<br/>						                                            
					                                            </c:if>
					                                            <div style="display:flex; justify-content:space-between;">
					                                            	<select class="form-control" id="agentIdx">
					                                            		<option value="">Select agent</option>
					                                            		<c:if test="${info.recom != -1}"><option value="-1">Delete parent agent</option></c:if>
					                                            		<c:forEach var="i" items="${alist}">
					                                            			<option value="${i.idx}" ${info.midx == i.idx ? 'selected':''}>${i.nick}</option>
					                                            		</c:forEach>
							                                    	</select>
					                                            	<button type="button" class="btn btn-info" onclick="javascript:topAgentSetting(${info.idx})">Top Agent Settings</button>
					                                            </div>
				                                            </td>
			                                            </c:if>
			                                            <c:if test="${info.lev == 2}">
				                                            <th style="vertical-align: middle;">Top Agency</th>
				                                            <td><a href="/nas/admin/userInfo.do?idx=${info.midx }">${info.mnick}</a></td>
			                                            </c:if>
			                                        </tr>
			                                        <tr>
			                                            <th style="vertical-align: middle;">All Rake</th>
			                                            <td><fmt:formatNumber value="${rake.amoney}" pattern="#,###.##"/></td>
			                                            <th style="vertical-align: middle;">Unsettled Rake</th>
			                                            <td style="vertical-align: middle;"><fmt:formatNumber value="${rake.nmoney}" pattern="#,###.##"/></td>
			                                        </tr>
			                                        <tr>
			                                            <th style="vertical-align: middle;">Settled Rake</th>
			                                            <td style="vertical-align: middle;"><fmt:formatNumber value="${rake.cmoney}" pattern="#,###.##"/></td>
			                                            <th style="vertical-align: middle;">Calculate Rake</th>
			                                            <td>
			                                            	<div style="display:flex">
				                                            	<input type="text" class="form-control" placeholder="Calculate Rake" id="cmoney" name="cmoney" oninput="this.value = this.value.replace(/[^\d.]*([^\d.].*|\.(?=.*\.))/g, '');" value="">
				                                            	<button type="button" class="btn btn-warning" onclick="javascript:calculate(${info.idx})">Calculate</button>
			                                            	</div>
		                                            	</td>
			                                        </tr>
			                                    </tbody>
			                                </table>
			                                <div style="display:flex; justify-content:space-between;">
			                                    <button type="button" onclick="location.href='/nas/admin/user.do'" class="btn btn-default">List</button>
			                                    <button type="button" onclick="javascript:updateUserInfo(${info.idx})" class="btn btn-info">Save</button>
			                                </div>
			                                
			                                <%-- top agnecy list modal --%>
			                                <button type="button" style="display:none;" data-toggle="modal" data-target="#agencyModal" id="modalBtn"></button>
			                                <div class="modal fade" id="agencyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close _closeModal" data-dismiss="modal" aria-hidden="true">&times;</button>
															<h4 class="modal-title" id="myModalLabel">set Top Agency</h4>
														</div>
														<div class="modal-body">
															<div class="row">
																<div class="col-lg-12">
																	<label>Select Top Agency</label>
																	<div class="form-group">
																		<select class="form-control" onchange="javascript:selectTopAgency(this)" name="ridx" id="ridx">
							                                            </select>
																	</div>
																</div>
															</div>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-default _closeModal" data-dismiss="modal">Close</button>
															<button type="button" class="btn btn-primary" id="modalCheckBtn">Check</button>
														</div>
													</div>
												</div>
											</div>
											<%-- // top agnecy list modal --%>
			                            </div>
									</div>
					            </div> <br>
								<div style="display: flex; justify-content: space-between; align-items: center;">
									<div>
										<button type="button" class="btn btn-default" style="cursor:default;">Child members</button>
										<button type="button" onclick="javascript:userInfoDownload(${info.idx})" class="btn btn-success">Excel Download</button>
									</div>
									<ul class="pagination" style="margin: 0;">
										<ui:pagination paginationInfo="${pi}" type="admin" jsFunction="page" />
									</ul>
								</div><br/>
								<div class="table-responsive">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th style="text-align:center;">Date of joining</th>
												<th style="text-align:center;">Name</th>
												<th style="text-align:center;">Lev</th>
												<th style="text-align:center;">Referral(%)</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${list}">
												<tr>
													<td style="text-align:center;"><fmt:formatDate value="${item.mdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
													<td style="text-align:center;"><a href="/nas/admin/userInfo.do?idx=${item.idx}">${item.nick}</a></td>
													<td style="text-align:center;">${item.lev == 2 ? 'Agent' : 'User'}</td>
													<td style="text-align:center;">${item.fee}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="adminFrame/footer.jsp"></jsp:include>
<script>
function page(pageNo){
	document.listForm.pageIndex.value = pageNo;
   	document.listForm.submit();
}
function calculate(idx){
	$.ajax({
		type : 'post',
		data : {'idx':idx, 'cmoney':$("#cmoney").val()},
		url : '/nas/admin/calculateRake.do',
		success : function(data){
			alert(data.msg);
			if(data.result == 'suc') {
				location.reload();
			}
		}
	})
	
}
function topAgentSetting(idx){
	$.ajax({
		type : 'post',
		data : {'idx':idx, 'ridx':$("#agentIdx").val()},
		url : '/nas/admin/topAgentSetting.do',
		success : function(data){
			alert(data.msg);
			if(data.result == 'suc') {
				location.reload();
			}
		}
	})
}
function selectTopAgency(self) {
	  let currentOnclick = document.getElementById("modalCheckBtn").getAttribute("onclick");
	  let match = currentOnclick.match(/changeLev\(([^,]+),([^,]+),([^)]+)\)/);
	  
	  if (match) {
	    let newOnclick = "javascript:changeLev(" + match[1] + "," + match[2] + "," + self.value + ")";
	    document.getElementById("modalCheckBtn").setAttribute("onclick", newOnclick);
	  }
	}
function changeLev(idx , lev , ridx){
	if (confirm("Do you want to change it?")) {
		$.ajax({
			type : 'post',
			data : {'idx':idx,'lev':lev , 'ridx':ridx},
			url : '/nas/admin/changeLev.do',
			success : function(data){
				alert(data.msg);
				if(data.result == 'suc') {
					location.reload();
				}
			}
		})
	}
}
function getAgencyList(idx){
	$.ajax({
		type : 'post',
		url : '/nas/admin/getAgencyList.do',
		success : function(data){
			if(data.result == 'suc') {
				let txt = '';				
				for(let i=0; i<data.list.length; i++){
					txt += '<option value="'+data.list[i].idx+'">'+data.list[i].nick+'</option>';
				}
				$("#ridx").html(txt);
				$("#modalBtn").click();
				$("#modalCheckBtn").attr("onclick","javascript:changeLev("+idx+",2,"+data.list[0].idx+")");
			}else{
				alert(data.msg);
			}
		}
	})
}
function updateUserInfo(idx){
	if (confirm("Do you want to register it?")) {
		$.ajax({
			type : 'post',
			data : $("#listForm").serialize(),
			url : '/nas/admin/updateUserInfo.do?idx='+idx,
			success : function(data){
				if(data.result == 'suc') {
					alert("Success");
					location.reload();
				}
			}
		})
	}
}
function updateUserStatus(idx, status){
	if (confirm("Do you want to change it?")) {
		$.ajax({
			type : 'post',
			data : {'status':status, 'dmemo':$("#dmemo").val()},
			url : '/nas/admin/updateUserStatus.do?idx='+idx,
			success : function(data){
				if(data.result == 'suc') {
					alert("Success");
					location.reload();
				}
			}
		})
	}
}
function userInfoDownload(idx) {
	window.location.href = '/nas/admin/userInfoDownload.do?idx=' + idx;
}
</script>
</body>
</html>