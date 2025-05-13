<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//Dth HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dth">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="adminFrame/header.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">관리자 로그인</h3>
				</div>
				<div class="panel-body">
					<form id="loginForm" role="form" method="post">
						<fieldset>
							<div class="form-group">
								<input class="form-control" placeholder="ID" name="id" type="text" maxlength="20" value="${cookieEmail}" id="emailInput">
							</div>
							<div class="form-group">
								<input class="form-control" placeholder="Password" name="pw" type="password" maxlength="60" value="${cookiePw}" id="pwInput" onKeyPress="if(event.keyCode==13) { javascript:login(); return false; }">
							</div>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="rememberAc" ${cookieRemember == 1 ? 'checked' : ''}>로그인 정보 저장
								</label>
							</div>
							<div class="form-group">
								<p style="color:red;" id="msg"></p>
							</div>
							<button type="button" class="btn btn-lg btn-success btn-block disabled" onclick="" id="loginBtn">Login</button>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="adminFrame/footer.jsp"></jsp:include>
</body>
<script>
	$(document).ready(function() {
		$("#emailInput").focus(function() {
			$(this).removeAttr("placeholder");
		});
		$("#emailInput").blur(function() {
			$(this).attr("placeholder", "ID");
		});
		$("#pwInput").focus(function() {
			$(this).removeAttr("placeholder");
		});
		$("#pwInput").blur(function() {
			$(this).attr("placeholder", "Password");
		});
		checkInputs();
	});
	function checkInputs() {
	    if ($("#emailInput").val() && $("#pwInput").val()) {
	        $("#loginBtn").removeClass("disabled");
	        $("#loginBtn").attr("onclick", "javascript:login()");
	    } else {
	        $("#loginBtn").addClass("disabled");
	        $("#loginBtn").removeAttr("onclick");
	    }
	}

	$("#emailInput, #pwInput").on("input", checkInputs);
	
	function login() {
		$("#loginBtn").attr("onclick" , "javascript:void(0)");
		$.ajax({
			type : 'post',
			url : '/nas/admin/loginProcess.do',
			data : $("#loginForm").serialize(),
			success : function(data) {
				if (data.result == 'suc') {
					location.href = '/nas/admin/support.do';
				} else $("#msg").text(data.msg);
				$("#loginBtn").attr("onclick" , "javascript:login()");
			},
			error : function(e) {
				console.log(JSON.stringify(e));
			}
		})
	}
</script>
</html>