var socketUri = "wss://"+window.location.host+"/nas/websocket/echo.do"; // https
if(window.location.host != '7starpoker.io' && window.location.host != 'www.7starpoker.io')
	socketUri = "ws://"+window.location.host+"/nas/websocket/echo.do"; // https
var socket;
var utoken;
var screen;
// 로그인할때 소켓을보낸다 
socketInit();

function socketInit(){
	socket = new WebSocket(socketUri);
	socket.onopen = function(evt){
		if(screen == 'game'){
			gameConnect();
		}else if(screen == 'record'){
			recordConnect();
		}else{
			// 유저 디바이스 정보 저장
			let obj = new Object();
			obj.protocol = "sendDeviceInfo";
			obj.deviceInfo = navigator.userAgent;
			doSend(obj);
		}
	    setInterval(function() {
	        if (socket.readyState === WebSocket.OPEN) {
				let obj = new Object();
				obj.protocol = "ping";
				doSend(obj);
	        }
	    }, 10000); // 10초마다 핑 메시지 전송		
	}
	socket.onmessage = function(evt){
		onMsg(evt);
	}
	socket.onerror = function(evt){
		console.log('onerror:'+evt);
		if(screen == 'game' || screen == 'record') window.close();
		else sendReconnect();
	}
	socket.onclose = function(evt){
		console.log('onclose:'+JSON.stringify(evt));
		if(screen == 'game' || screen == 'record') window.close();
		else sendReconnect();
	}
}

//서버로 데이터 보냄
function doSend(message) {
	socket.send(JSON.stringify(message)); 
	closePop('_chkPop');
}

function onMsg(evt){
	let obj = JSON.parse(evt.data);
	if (obj.protocol !== "ping" || obj.cmd !== "sendGameMode") {
	    console.log('onmessage:' + JSON.stringify(obj));
	}
	if(obj.cmd == 'connectResult') getAjaxViewToken('gameList');
	else if(obj.cmd == 'logout') {location.href='/nas/logout.do'}
	else if(obj.cmd == 'logoutWinform') {window.chrome.webview.hostObjects.bridge.winformClose(true);}
	else if(obj.cmd == 'sendDupleLogout') {alert('Duplicate login. You will be logged out.'); sendProtocol("logoutDuple");}
	// 세팅 (마이페이지)
	else if(obj.cmd == 'sendChargeApply') {alert("Success"); closePop('_wPop'); $("._umoney").text("$"+comma(obj.money)); $('._reset').val('');}
	else if(obj.cmd == 'sendReturnChargeApply') {alert(obj.msg); $('._reset').val('');}
	else if(obj.cmd == 'sendInsertQna') {closePop('_popContact'); closePop('doublecheck'); boardList(1, 1); $('._reset').val('');}
	else if(obj.cmd == 'sendMyQnaDetail') {setMyQnaDetail(obj);}
	else if(obj.cmd == 'sendChangePw') {alert("Success"); $('._reset').val(''); pw = (obj.pw);}
	else if(obj.cmd == 'sendChangeWallet') {setChangeWallet(obj)}
	else if(obj.cmd == 'sendMyChargeList') {setMyChargeList(obj);}
	else if(obj.cmd == 'sendBoardList') {setBoardList(obj);}
	else if(obj.cmd == 'sendChangeIcon') {setChangeIcon(obj);}
	else if(obj.cmd == 'sendUpdateCardDeck') {setUpdateCardDeck(obj);}
	else if(obj.cmd == 'sendUpdateCardDeckInGame') {setUpdateCardValue(obj);}
	else if(obj.cmd == 'sendMyBetBookmarkList') {setMyBetBookmarkList(obj);}
	else if(obj.cmd == 'sendGameLogList') {setGameLogList(obj);}
	else if(obj.cmd == 'sendRewardList') {setRewardList(obj);}
	else if(obj.cmd == 'sendRecordList') {setRecordList(obj);}
	else if(obj.cmd == 'sendMyRecordDetail') {setMyRecordDetail(obj);}
	else if(obj.cmd == 'sendMyStakesList') {setMyStakesList(obj);}
	// 게임
	else if(obj.cmd == 'sendHoldemRoomList') {setHoldemRoomList(obj)}
	else if(obj.cmd == 'sendStakesList') {setStatkesList(obj)}
	else if(obj.cmd == 'sendRoomListInfo') {setRoomListInfo(obj)}
	else if(obj.cmd == 'sendCheckBuyinPop') {setCheckBuyinPop(obj)}
	else if(obj.cmd == 'sendJoinHoldemErr') {alert(obj.msg); closePop('popupframe');getRoomList('');sendProtocol('getStakesList');}
	else if(obj.cmd == 'gameConnectSuccess') {getAjaxGame('gameRoom', obj.rid , false);}
	else if(obj.cmd == 'sendJoinRoomOk') {
		closePop('popupframe.addchips');
		if(isWinform()){
			let windata = {'gameUrl' : window.location.origin+'/nas/game.do?rid='+obj.rid+'&token='+encodeURIComponent(utoken) , 
					'recordUrl' : window.location.origin+'/nas/record.do?gid=-1&token='+encodeURIComponent(utoken) ,
					'rid': obj.rid , 'title':obj.title};
			window.chrome.webview.hostObjects.bridge.sendLink(JSON.stringify(windata));
		}else{
			if(isMobile()) getAjaxGame('gameRoom', obj.rid , false);
			else window.open('/nas/game.do?rid='+obj.rid+'&token='+encodeURIComponent(utoken));
		}
	}
	else if(obj.cmd == 'sendRejoinRoomOk') {
		if(isWinform()){
			let windata = {'gameUrl' : window.location.origin+'/nas/game.do?rid='+obj.rid+'&token='+encodeURIComponent(utoken) , 
					'recordUrl' : window.location.origin+'/nas/record.do?gid=-1&token='+encodeURIComponent(utoken) ,
					'rid': obj.rid , 'title':obj.title};
			window.chrome.webview.hostObjects.bridge.sendLink(JSON.stringify(windata));
		}else{
			if(isMobile()) getAjaxGame('gameRoom', obj.rid , true);
			else window.open('/nas/game.do?rid='+obj.rid+'&token='+encodeURIComponent(utoken));
		}
	}
	else if(obj.cmd == 'sendAddMygameChipResult') {alert(obj.msg)}
	else if(obj.cmd == 'gameConnectResult') {setGameConnect(obj)}
	else if(obj.cmd == 'sendNotifyJoinUser') joinRoomResult(obj);
	else if(obj.cmd == 'sendNotifyRejoinUser') rejoinRoomResult(obj);
	else if(obj.cmd == 'sendRoomDetailAll') sendRoomDetailCheck(obj);
	else if(obj.cmd == 'sendRoomLeaveOk') roomLeaveResult(obj);
	else if(obj.cmd == 'sendRoomLeaveSpectorOk') roomLeaveSpectorResult(obj);
	else if(obj.cmd == 'deleteClientSetting') deleteGameSetting(obj);
	else if(obj.cmd == 'startGame') startGameSetting(obj);
	else if(obj.cmd == 'sbBetSuc' || obj.cmd == 'bbBetSuc' || obj.cmd == 'strBetSuc') bbetSuc(obj);
	else if(obj.cmd == 'giveTwoCard') giveTwoCard(obj);
	else if(obj.cmd == 'sendTwoCard') setTwoCard(obj);
	else if(obj.cmd == 'bet') showBetPan(obj);  
	else if(obj.cmd == 'betSuc') betSuc(obj);	
	else if(obj.cmd == 'theFlop') theFlop(obj);
	else if(obj.cmd == 'jokbo') jokbo(obj);	
	else if(obj.cmd == 'theTurn') theTurn(obj);	
	else if(obj.cmd == 'theRiver') theRiver(obj);
	else if(obj.cmd == 'showResult') showResult(obj);
	else if(obj.cmd == 'roomOut') roomOut(obj);
	else if(obj.cmd == 'multiInfo') setMultiInfo(obj);	
	else if(obj.cmd == 'sendChat') setChat(obj);
	else if(obj.cmd == 'giveChipsPop') setGiveChipsPop(obj);
	else if(obj.cmd == 'sendTips') setTips(obj);
	else if(obj.cmd == 'sendTipsReturn') setTipsReturn(obj);
	else if(obj.cmd == 'addChipsPop') setAddChipsPop(obj);
	else if(obj.cmd == 'sendAddMygameChip') setAddMygameChip(obj);
	else if(obj.cmd == 'showDownHand') {obj.type == 0 ? showDownUserHandOpen(obj) : showDownHand(obj);}
	else if(obj.cmd == 'showDownTableCard') showDownResult(obj);
	else if(obj.cmd == 'showCard') setShowCard(obj);
	else if(obj.cmd == 'sendChangeBBStack') setChangeBBStack(obj);
	else if(obj.cmd == 'sendBbBlindsPop') setBbBlindsPop(obj);
	else if(obj.cmd == 'sendSbBettingBoxPop') setSbBettingBoxPop(obj);
	else if(obj.cmd == 'theEnd') theEnd(obj);
	else if(obj.cmd == 'changeStatus') setChangeStatus(obj);
	else if(obj.cmd == 'sendNextStraddle') setdNextStraddle(obj);
	else if(obj.cmd == 'sendSidePot') setSidePot(obj);
	else if(obj.cmd == 'sendAdminRoomInfo') setAdminRoomInfo(obj);
	else if(obj.cmd == 'sendNotStraddle') notStraddle(obj);
	else if(obj.cmd == 'sendSeatType') changeGameModeSeat(obj);
	else if(obj.cmd == 'resettingUserCard') setResettingUserCard(obj);
	else if(obj.cmd == 'resettingBoardCard') setResettingBoardCard(obj);
	else if(obj.cmd == 'sendReDeal') setReDeal(obj);
}