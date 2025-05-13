/* top 메뉴 탭 */
function changeTab(num , cl) {
	$('.s-tab').removeClass('on');
	$('.s-tab').eq(num).addClass('on');
	
	changeMypageView(0 , cl)
}

/* left menu */
function changeMypageView(tabindex , cl){
	// 화면 초기화
	$('.t-contents').hide();
	$('.tabmenu .btn').removeClass('choice');
	$('.tabmenu').hide();
	$('._reset').val('');
	$('[class^="_error"]').css('display', 'none');
	closePop('_popup');
	
	// 화면 구현
	$(".tabmenu."+cl).find('.tabmenubtn:eq('+tabindex+')').addClass('choice'); // left 메뉴
	$('.tabmenu.'+cl).show(); // left 메뉴
	
	let tabClass = $('.tabmenu.'+cl).find('.tabmenubtn').eq(tabindex).attr('class').split(' ')[2];
	$(".t-contents."+tabClass).show();
	
	if(tabClass == 'balancehistory') gameLogList(1);
	else if(tabClass == 'deposithistory') chargeList(0, 1);
	else if(tabClass == 'withdrawhistory') chargeList(1, 1);
	else if(tabClass == 'faq') boardList(0, 1);
	else if(tabClass == 'contact') boardList(1, 1);
	else if(tabClass == 'rewardshistory') rewardList(1);
	else if(tabClass == 'holdem') {
		$("._chkbox").addClass("w--redirected-checked");
		recordList(1, "-1");
	}	
    if(isMobile()){
    	window.Screen.postMessage(tabClass);
    } 	
}


/* 프로필 아이콘 변경 */
function changeIcon(self, icon){
	$(".img_avatar").removeClass('choice');
	$(self).addClass('choice');
	myIcon = icon;
	let obj = new Object();
	obj.protocol = 'changeIcon';
	obj.icon = myIcon;
	doSend(obj);
}

function setChangeIcon(obj){
	closePop('avatarbox');
	$('._changeImg').attr('src', obj.icon);
}

/* 비밀번호 변경 */
function changePw() {
	let obj = new Object();
	obj.protocol = 'changePw';
	obj.newpw = $("#newpw").val();
	doSend(obj);
	pw = $("#newpw").val();
}
/* wallet 값 변경 */
function changeWallet() {
	let obj = new Object();
	obj.protocol = 'changeWallet';
	obj.wallet = $("#wallet").val();
	doSend(obj);
}
function setChangeWallet(obj){
	alert(obj.msgtxt);
	if(obj.result == 'success'){
		initialWalletValue = obj.wallet;
	}else{
		$("#wallet").val(initialWalletValue);
		$("#wwallet").val(initialWalletValue);
	}
}

/* 충환전 신청 : 0 Cryptocurrency 1 Cash / 0 충전 1 환전 */
function chargeApply(category, kind) {
	let obj = new Object();
	obj.protocol = 'chargeApply';
	obj.money = (category == 0 ? (kind == 0 ? '-1' : $("#wamount").val()) : (kind == 0 ? $("#dmoney").val() : $("#wmoney").val()));
	obj.name = (category == 0 ? (kind == 0 ? '-1' : 'USDT') : (kind == 0 ? $("#dname").val() : $("#wname").val()));
	obj.bank = (category == 0 ? (kind == 0 ? $("#hash").val() : $("#wwallet").val()) : (kind == 0 ? '-1' : $("#bank").val()));
	obj.category = category;
	obj.kind = kind;
	doSend(obj);
}

/* 충환전 리스트 */
function chargeList(kind, num) {
	let obj = new Object();
	obj.protocol = 'getMyChargeList';
	obj.num = num;
	obj.kind = kind;
	doSend(obj);
}

/* 충환전 리스트 */
function setMyChargeList(obj) {
	let list = '';
	for(var i=0; i<obj.list.length; i++){
		list += '<div class="historylist '+(obj.list[i].kind == 0 ? 'deposit' : 'withdraw')+'">'
		list += '<div class="h-list">'+obj.list[i].cdate+'</div>';
		list += '<div class="h-list">'+(obj.list[i].category == 0 && obj.list[i].money == -1 ? 'Checking' : '$'+comma(obj.list[i].money) )+'</div>';
		list += '<div class="h-list">'+(obj.list[i].category == 0 ? 'Cryptocurrency' : 'Cash')+'</div>';
		list += '<div class="h-list">'+(obj.list[i].status == 0 ? 'Waiting' : (obj.list[i].status == 1 ? 'Completed' : 'Reject'))+'</div>';
		list += '</div>'
	}

	let paging = '';
	paging += '<div class="btn table start" onclick="javascript:chargeList(' + obj.kind + ' , ' + obj.first + ')"></div>';
	if (obj.curPage > obj.first) paging += '<div class="btn table prev" onclick="javascript:chargeList(' + obj.kind + ' , ' + (obj.curPage - 1) + ')"></div>';
	else paging += '<div class="btn table prev"></div>';
	if (obj.curPage < obj.last) paging += '<div class="btn table next" onclick="javascript:chargeList(' + obj.kind + ' , ' + (obj.curPage + 1) + ')"></div>';
	else paging += '<div class="btn table next"></div>';
	paging += '<div class="btn table end" onclick="javascript:chargeList(' + obj.kind + ' , ' + obj.last + ')"></div>';
	
	if(obj.kind == 0) {
		$("._dchargePage").html(paging);
		$("._dchargeList").html(list);
	} else {
		$("._wchargePage").html(paging);
		$("._wchargeList").html(list);
	}
	$("._umoney").text("$"+comma(obj.money));
}

/* 게시판 리스트 */
function boardList(kind, num) {
	let obj = new Object();
	obj.protocol = 'getBoardList';
	obj.num = num;
	obj.kind = kind;
	doSend(obj);
}

/* 게시판 리스트 */
function setBoardList(obj) {
	let list = '';
	for(var i=0; i<obj.list.length; i++){
		if(obj.kind == 0) {
			list += '<div class="faqlist">';
			list += '<div class="faqtop" onclick="javascript:getBoardDetail(\'list_' + obj.list[i].idx + '\', \'' + obj.kind + '\')" style="cursor:pointer;">';
			list += '<div class="faqtitle ellipsis _2">'+obj.list[i].title+'</div><div class="btn showfaq"></div></div>';
			list += '<div class="faqbottom" id="text_'+obj.list[i].idx+'"><div class="faqcontents scrollbox"><p class="paragraph" style="word-break:break-all; white-space:pre-line;">'+obj.list[i].text+'</p></div></div>';
			list += '</div>';
		} else {
			list += '<div class="inquirylist" onclick="javascript:getBoardDetail('+obj.list[i].idx+')" style="cursor:pointer;">';
			list += '<div class="inquirystatus '+(obj.list[i].status == 0 ? 'waiting' : 'completed')+'">'+(obj.list[i].status == 0 ? 'Waiting' : 'Completed')+'</div>';
			list += '<div class="inquirybox _2"><div class="inquirytitle">'+obj.list[i].title+'</div>';
			list += '<div class="inquirydate">'+obj.list[i].bdate+'</div></div>';
			list += '</div>';
		}
	}
	
	let paging = '';
	paging += '<div class="btn table start" onclick="javascript:boardList(' + obj.kind + ' , ' + obj.first + ')"></div>';
	if (obj.curPage > obj.first) paging += '<div class="btn table prev" onclick="javascript:boardList(' + obj.kind + ' , ' + (obj.curPage - 1) + ')"></div>';
	else paging += '<div class="btn table prev"></div>';
	if (obj.curPage < obj.last) paging += '<div class="btn table next" onclick="javascript:boardList(' + obj.kind + ' , ' + (obj.curPage + 1) + ')"></div>';
	else paging += '<div class="btn table next"></div>';
	paging += '<div class="btn table end" onclick="javascript:boardList(' + obj.kind + ' , ' + obj.last + ')"></div>';
	
	if(obj.kind == 0) {
		$("._fboardPage").html(paging);
		$("._fboardList").html(list);
	} else {
		$("._qboardPage").html(paging);
		$("._qboardList").html(list);
	}
}

/* 게시글 상세 */
function getBoardDetail(idx, kind) {
	if(kind == 0) $("#text_"+idx.replace("list_", "")).slideToggle();
	let obj = new Object();
	obj.idx = (kind == 0 ? idx.replace("list_", "") : idx);
	obj.protocol = (kind == 0 ? 'updateBoardHit' : 'getMyQnaDetail');
	doSend(obj);
}

/* qna 상세 */
function setMyQnaDetail(obj) {
	$("._btitle").text(obj.info.title);
	$(".writedate").text(obj.info.bdate);
	$("._btext").text(obj.info.text);
	$(".answerdate").text(obj.info.adate);
	$("._atext").html(obj.info.answer);
	$('.inquirydetails').css('display', 'block');
}

/* qna 확인 */
function checkQna() {
	if($("#title").val() == '') {
		alert("Enter Title");
		return;
	}
	if($("#text").val() == '') {
		alert("Enter Text");
		return;
	}
	if ($("#text").val().length < 10) {
	    alert("Please write the content in at least 10 characters.");
		return;
	}
	openPop('doublecheck');
}

/* qna 전송 */
function insertQna() {
	let obj = new Object();
	obj.protocol = 'insertQna';
	obj.title = $("#title").val();
	obj.text = $("#text").val();
	doSend(obj);
}

/* 지갑 주소 복사 */
$('.copyicon').click(function() {
	let copyText = $('.qrcode:eq(0)').text();
	let textarea = document.createElement('textarea');
	textarea.value = copyText;
	document.body.appendChild(textarea);
	textarea.select();
	document.execCommand('copy');
	document.body.removeChild(textarea);
	alert('Copied');
});

/* 지갑 큐알 코드 열기 */
function openQrCode() {
	$.ajax({
		type: 'post',
		url : '/nas/openQr.do',
		success:function(data){
			$(".qr").attr("src" , data.qrCode);
			closePop('_dPop');
			openPop('_dPop2'); 
		}
	})
}

/* 로그아웃 */
function userLogout() {
	sendProtocol('logout');
}

/* 카드 덱 탭 변경 */
function changeCardDeck(card) {
	if(card == 'F') {
		if ($(".decktypebox").css("display") === "flex" && $(".decktype.front").css("display") === "flex") {
	    	$(".decktypebox").css("display", "none");
	    } else {
	    	$(".decktypebox").css("display", "flex");
			closePop('decktype.back');
			openPop('decktype.front');
	    }
	} else {
		if ($(".decktypebox").css("display") === "flex" && $(".decktype.back").css("display") === "flex") {
	    	$(".decktypebox").css("display", "none");
	    } else {
	    	$(".decktypebox").css("display", "flex");
			closePop('decktype.front');
			openPop('decktype.back');
	    }
	}
}

/* 카드 덱 설정 */
function updateCardDeck(card, num) {
	let obj = new Object();
	obj.protocol = 'updateCardDeck';
	obj.card = card;
	obj.num = num;
	doSend(obj);
}

function setUpdateCardDeck(obj){
	if(obj.card == 'F') {
		$("._fDeck").removeClass("on");
		$(".tablecardbox .tablecardwrap:eq(0) img").attr("src", "/nas/webflow/fcard0"+obj.num+"/0.png");
		$(".tablecardbox .tablecardwrap:eq(1) img").attr("src", "/nas/webflow/fcard0"+obj.num+"/13.png");
		$(".tablecardbox .tablecardwrap:eq(2) img").attr("src", "/nas/webflow/fcard0"+obj.num+"/26.png");
		$(".tablecardbox .tablecardwrap:eq(3) img").attr("src", "/nas/webflow/fcard0"+obj.num+"/39.png");
		$(".frontdeck").attr("src", "/nas/webflow/fcard0"+obj.num+"/0.png");
	} else {
		$("._bDeck").removeClass("on");
		$(".card.preview").attr("src", "/nas/webflow/bcard/"+obj.num+".png");
        $(".card._2.preview").attr("src", "/nas/webflow/bcard/"+obj.num+".png");
        $(".backdeck").attr("src", "/nas/webflow/bcard/"+obj.num+".png");
	}
	$(".deckimg._fDeck").removeClass('on');
	$(".deckimg._fDeck").eq(obj.num-1).addClass('on');
}

/* record 열기 */
function openRecord(gid) {
	if(isMobile()) getAjaxRecord(gid);
	else window.open('/nas/record.do?gid='+gid+'&token='+encodeURIComponent(utoken));
}

/* 게임 로그 리스트 */
function gameLogList(num) {
	let obj = new Object();
	obj.protocol = 'getGameLogList';
	obj.num = num;
	doSend(obj);
}

/* 게임 로그 리스트 */
function setGameLogList(obj) {
	let list = '';
	for(var i=0; i<obj.list.length; i++){
		list += '<div class="historylist">';
		list += '<div class="h-list">' + obj.list[i].mdate + '</div>';
		list += '<div class="h-list">' + obj.list[i].category+ '-' + obj.list[i].title + '($' + comma(obj.list[i].sb) + '/$' + comma(obj.list[i].bb) + ')</div>';
		list += '<div class="h-list">$' + comma(obj.list[i].money) + '</div>';
		list += '<div class="h-list">$' + comma(obj.list[i].afmoney) + '</div>';
		list += '<div class="h-list">' + obj.list[i].category+ '</div>';
		list += '</div>';
	}
	
	let paging = '';
	paging += '<div class="btn table start" onclick="javascript:gameLogList(' + obj.first + ')"></div>';
	if (obj.curPage > obj.first) paging += '<div class="btn table prev" onclick="javascript:gameLogList(' + (obj.curPage - 1) + ')"></div>';
	else paging += '<div class="btn table prev"></div>';
	if (obj.curPage < obj.last) paging += '<div class="btn table next" onclick="javascript:gameLogList(' + (obj.curPage + 1) + ')"></div>';
	else paging += '<div class="btn table next"></div>';
	paging += '<div class="btn table end" onclick="javascript:gameLogList(' + obj.last + ')"></div>';
	
	$("._gameLogPage").html(paging);
	$("._gameLogList").html(list);
}

/* 리워드 히스토리 */
function rewardList(num) {
	let obj = new Object();
	obj.protocol = 'getRewardList';
	obj.num = num;
	doSend(obj);
}

/* 리워드 히스토리 */
function setRewardList(obj) {
	let list = '';
	for(var i=0; i<obj.list.length; i++){
		list += '<div class="historylist rewards">';
		list += '<div class="h-list">' + obj.list[i].rdate + '</div>';
		list += '<div class="h-list">' + (obj.list[i].category == 0 ? 'Rakeback' : obj.list[i].mnick + ' - referral revenue') + '</div>';
		//list += '<div class="h-list">' + (obj.list[i].category == 0 ? obj.list[i].rlev + ' - Rakeback' : obj.list[i].mnick + ' - referral revenue') + '</div>';
		list += '<div class="h-list">$' + comma(obj.list[i].money) + '</div>';
		list += '<div class="h-list">$' + comma(obj.list[i].afmoney) + '</div>';
		list += '<div class="h-list">' + (obj.list[i].category == 1 ? 'Rewards' : 'Refferal') + '</div>';
		list += '</div>';
	}
	
	let paging = '';
	paging += '<div class="btn table start" onclick="javascript:rewardList(' + obj.first + ')"></div>';
	if (obj.curPage > obj.first) paging += '<div class="btn table prev" onclick="javascript:rewardList(' + (obj.curPage - 1) + ')"></div>';
	else paging += '<div class="btn table prev"></div>';
	if (obj.curPage < obj.last) paging += '<div class="btn table next" onclick="javascript:rewardList(' + (obj.curPage + 1) + ')"></div>';
	else paging += '<div class="btn table next"></div>';
	paging += '<div class="btn table end" onclick="javascript:rewardList(' + obj.last + ')"></div>';
	
	$("._rewardPage").html(paging);
	$("._rewardList").html(list);
}

/* 래코드 리스트 */
function recordList(num, search) {
	let obj = new Object();
	obj.protocol = 'getRecordList';
	obj.num = num;
	obj.search = search;
	doSend(obj);
}

var allStakes = "";
/* 래코드 리스트 */
function setRecordList(obj) {
	let list = '';
	if(obj.list != null) {
		for(var i=0; i<obj.list.length; i++){
			list += '<div class="historylist record" onclick="javascript:openRecord(\'' + obj.list[i].gid + '\');" style="cursor:pointer;">';
			list += '<div class="h-list">' + obj.list[i].gdate + '</div>';
			list += '<div class="h-list">$' + obj.list[i].sb + ' / $' + obj.list[i].bb + '</div>';
			list += '<div class="h-list">' + obj.list[i].title + '</div>';
			list += '<div class="h-list cd"><img src="/nas/webflow/fcard0' + obj.fcard+ '/' + obj.list[i].hand.split(',')[0] + '.png" style="width:10%"><img src="/nas/webflow/fcard0' + obj.fcard+ '/' + obj.list[i].hand.split(',')[1] + '.png" style="width:10%"></div>';
			list += '<div class="h-list">' + comma(obj.list[i].gain) + '</div>';
			list += '</div>';
		}
	}
	
	let search_stakes = $("[id*=labelChk_]").find("._chkbox.w--redirected-checked").map(function () {
        return $(this).next().val();
    }).get().join('|');
	if(search_stakes == '') search_stakes = '-2';
	else if(search_stakes == allStakes) search_stakes = '-1';
	
	let paging = '';
	paging += '<div class="btn table start" onclick="javascript:recordList(' + obj.first + " , " + search_stakes + ')"></div>';
	if (obj.curPage > obj.first) paging += '<div class="btn table prev" onclick="javascript:recordList(' + (obj.curPage - 1) + " , " + search_stakes + ')"></div>';
	else paging += '<div class="btn table prev"></div>';
	if (obj.curPage < obj.last) paging += '<div class="btn table next" onclick="javascript:recordList(' + (obj.curPage + 1) + " , " + search_stakes + ')"></div>';
	else paging += '<div class="btn table next"></div>';
	paging += '<div class="btn table end" onclick="javascript:recordList(' + obj.last + " , " + search_stakes + ')"></div>';
	
	$("._recordPage").html(paging);
	$("._recordList").html(list);
}

/* 나의 레코드 stakes 리스트 */ 
function setMyStakesList(obj) {
	let txt = '';
	for (var i = 0; i < obj.list.length; i++) {
		let stakes = obj.list[i].stakes;
		let parts = stakes.split('_');
		allStakes += stakes + "|";

        txt += '<label class="w-checkbox checkbox" id="labelChk_'+stakes+'" onclick="javascript:getRecordSearch('+parts[0]+','+parts[1]+')" style="cursor:pointer;">';
        txt += '<div class="w-checkbox-input w-checkbox-input--inputType-custom checkboxicon w--redirected-checked filter _chkbox"></div>';
        txt += '<input type="checkbox" style="opacity:0;position:absolute;z-index:-1" checked="true" value="'+stakes+'">';
        txt += '<span class="checkboxlabel w-form-label" for="checkbox">$'+comma(parts[0])+' / $'+comma(parts[1])+'</span>';
        txt += '</label>';
    }
	allStakes = allStakes.trim().slice(0, -1);
	$(".filterbox").html(txt);
}

var getRecordRun = false;
function getRecordSearch(sb , bb){
	if(!getRecordRun) {
		if ($("#labelChk_"+sb+"_"+bb).find("._chkbox").hasClass("w--redirected-checked")) {
			$("#labelChk_"+sb+"_"+bb).find("._chkbox").removeClass("w--redirected-checked");
			$("#labelChk_"+sb+"_"+bb).find('input').prop('checked',false);
		} else {
			$("#labelChk_"+sb+"_"+bb).find("._chkbox").addClass("w--redirected-checked");
			$("#labelChk_"+sb+"_"+bb).find('input').prop('checked',true);
		}
		
		let search_stakes = $("[id*=labelChk_]").find("._chkbox.w--redirected-checked").map(function () {
	        return $(this).next().val();
	    }).get().join('|');
		if(search_stakes == '') search_stakes = '-2';
		
		recordList(1, search_stakes);
		getRecordRun = true;
	} else {
		getRecordRun = false;
	}
}

/* 베팅 즐겨찾기 탭 변경 */
function changeBookmarkTap(self, num) {
    $(".bookmark").removeClass("on");
    $(self).addClass("on");
    $(".btn_apply").attr("onclick", "javascript:openChkMsg('change it?' , 'javascript:updateUserBetBookmark(" + num + ")')");
    let obj = new Object();
	obj.protocol = 'getMyBetBookmarkList';
	obj.num = num;
	doSend(obj);
}

function setMyBetBookmarkList(obj) {
	for (var i = 1; i <= 7; i++) {
	    $("#bet" + i).val(obj["bet" + i]);
	}
}

/* 베팅 즐겨찾기 변경 */
function updateUserBetBookmark(num) {
	for (var i = 1; i < 8; i++) {
	    if (!$("#bet" + i).val()) {
	        alert("Enter Bet Size");
	        return;
	    }
	}
	let obj = new Object();
	obj.protocol = 'updateUserBetBookmark';
	obj.num = num;
	for (var i = 1; i < 8; i++) {
	    obj['bet' + i] = $("#bet" + i).val();
	}
	doSend(obj);
}