function getAjaxView(view){
	$.ajax({
		type : 'get',
		url : '/nas/'+view+'.do',
		success:function(data){
			changeView(data);
		}
	})
}
function getAjaxViewToken(view){
	$.ajax({
		type : 'post',
		data : {'token':utoken},
		url : '/nas/'+view+'.do',
		success:function(data){
			changeView(data);
		}
	})
}

function getAjaxMyPageTap(num){
	$.ajax({
		type : 'get',
		data : {'token':utoken, 'num':num},
		url : '/nas/myPage.do',
		success:function(data){
			changeView(data);
		}
	})
}

function getAjaxViewForm(view , formid){
	$.ajax({
		type : 'post',
		data : $("#"+formid).serialize()+'&token='+utoken,
		url : '/nas/'+view+'.do',
		success:function(data){
			changeView(data);
		},error:function(e){console.log(JSON.stringify(e))}
	})
}

function getAjaxGame(view,rid,rejoin){
	$.ajax({
		type : 'post',
		data : {'rid':rid,'token':utoken , 'rejoin':rejoin},
		url : '/nas/'+view+'.do',
		success:function(data){
			changeView(data);
		}
	})
}

function getAjaxRecord(gid){
	$.ajax({
		type : 'post',
		data : {'token':utoken , 'gid':gid},
		url : '/nas/recordRoom.do',
		success:function(data){
			changeView(data);
		}
	})
}

function getAjaxMobileRecord(gid, rid){
	$.ajax({
		type : 'post',
		data : {'token':utoken , 'gid':gid, 'rid':rid},
		url : '/nas/recordRoom.do',
		success:function(data){
			changeView(data);
		}
	})
}

function getAjaxMobileSetting(num, rid){
	$.ajax({
		type : 'post',
		data : {'token':utoken , 'num':num, 'rid':rid},
		url : '/nas/myPage.do',
		success:function(data){
			changeView(data);
		}
	})
}

function checkOpenBuyinPop(rid , seat){
	if(rid == null || rid == '') getAjaxMyPageTap('5');
	else {
		let obj = new Object();
		obj.protocol = "checkOpenBuyinPop";
		obj.rid = rid;
		obj.seat = seat;
		doSend(obj);
	}
}