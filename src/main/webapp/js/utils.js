var userTimerInterval;

// 풀 공통 함수 -----
//각 안드로이드와 iOS 를 구분짓는 함수들 true/false를 반환한다.
function isAndroid() {
  return navigator.userAgent.toLowerCase().indexOf('android') > -1;
}
function isiOS() {
  return /(iPad|iPhone|iPod)/g.test(navigator.userAgent);
}
//ios인 경우
if (isiOS()) {
  // iOS에 대한 반응형 미디어 쿼리 작성
  const style = document.createElement('style');
  style.innerHTML = '@media screen and (max-width:1180px){.container{height:100dvh;}}';
  document.head.appendChild(style);
}
function isMobile() {
    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}
function isWinform(){
	return navigator.userAgent.indexOf("_winform")>-1;
}
function sendProtocol(protocol){
	let obj = new Object();
	obj.protocol = protocol;
	doSend(obj);
}
function sendProtocolRid(protocol,rid){
	let obj = new Object();
	obj.protocol = protocol;
	obj.rid = rid;
	doSend(obj);
}
function comma(num) {
	let setNum = parseInt(num);
	return setNum.toLocaleString()
}
function commaTxt(setNum) {
	let num = parseInt(setNum);
	if (num >= 1000000000000) {
		const 조 = Math.floor(num / 1000000000000);
		const 억 = Math.floor((num - (조 * 1000000000000)) / 100000000);
		const 만 = Math
				.floor((num - (조 * 1000000000000) - (억 * 100000000)) / 10000);
		const 일 = num % 10000;
		let result = '';

		if (조 > 0) result += 조.toLocaleString() + '조 ';
		if (억 > 0) result += 억.toLocaleString() + '억 ';
//		if (만 > 0) result += 만.toLocaleString() + '만 ';
//		if (일 > 0) result += 일.toLocaleString();
		
		return result.trim();
	} else if (num >= 100000000) {
		const 억 = Math.floor(num / 100000000);
		const 만 = Math.floor((num - (억 * 100000000)) / 10000);
		const 일 = num % 10000;
		let result = '';

		if (억 > 0) result += 억.toLocaleString() + '억 ';
		if (만 > 0) result += 만.toLocaleString() + '만 ';
//		if (일 > 0) result += 일.toLocaleString();

		return result.trim();
	} else if (num >= 10000) {
		const 만 = Math.floor(num / 10000);
		const 일 = num % 10000;
		let result = '';
		
		if (만 > 0) result += 만.toLocaleString() + '만 ';
		if (일 > 0) result += 일.toLocaleString();

		return result.trim();
	} else {
		return num.toLocaleString();
	}
}	
function slideToggleFlex(id){
	$('#'+id).slideToggle('medium', function() {
	    if ($(this).is(':visible'))
	        $(this).css('display','flex');
	});
}

function changeView(data){
	$("#view").html(data);
}
// connect 
function connect(token){
	let obj = new Object();
	obj.protocol = "connect";
	obj.token = token;
	doSend(obj);
}
function sendReconnect(){
	//alert('재연결');
	location.reload();
}
function openPop(cl){
	$("."+cl).css("display","flex");
}
function closePop(cl){
	$("."+cl).css("display","none");
}
function togglePop(cl){
    if ($("."+cl).css("display") === "none") {
    	$("."+cl).css("display", "block");
    } else {
    	$("."+cl).css("display", "none");
    }
}
function winformClose(n){ // 0 닫기 , 1 취소
	if(n == 1){
		closePop('_chkAllPop');
		window.chrome.webview.hostObjects.bridge.winformClose(false);
	}else{
		sendProtocol('winformLogout');
	}
}

var soundChk = false;

//효과음
var s_coin = new Audio('/nas/webflow/sound/coin.mp3'); // 동전 내는 소리
var s_splitcard = new Audio('/nas/webflow/sound/splitcard.mp3'); // 카드 나눠주기
var s_startgame = new Audio('/nas/webflow/sound/startgame.wav');
var s_timer = new Audio('/nas/webflow/sound/timer.mp3');

// 결과 
var s_showdown = new Audio('/nas/webflow/sound/showdown.wav');
var s_win = new Audio('/nas/webflow/sound/win.wav');

// 베팅
var s_call = new Audio('/nas/webflow/sound/call.wav'); 
var s_check = new Audio('/nas/webflow/sound/check.wav'); 
var s_fold = new Audio('/nas/webflow/sound/fold.wav'); 
var s_raise = new Audio('/nas/webflow/sound/raise.wav'); 
var s_allin = new Audio('/nas/webflow/sound/allin.wav'); 

function setSoundSetting(){
	if(!soundChk){
		s_coin.mute = true;
		s_splitcard.mute = true;
		s_startgame.mute = true;
		s_timer.mute = true;
		s_showdown.mute = true;
		s_win.mute = true;
		s_call.mute = true;
		s_check.mute = true;
		s_fold.mute = true;
		s_raise.mute = true;
		s_allin.mute = true;

		s_coin.play();
		s_splitcard.play();
		s_startgame.play();
		s_timer.play();
		s_showdown.play();
		s_win.play();
		s_call.play();
		s_check.play();
		s_fold.play();
		s_raise.play();
		s_allin.play();
		
		setTimeout(function(){
			s_coin.pause();
			s_splitcard.pause();
			s_startgame.pause();
			s_timer.pause();
			s_showdown.pause();
			s_win.pause();
			s_call.pause();
			s_check.pause();
			s_fold.pause();
			s_raise.pause();
			s_allin.pause();
			
			s_coin.mute = false;
			s_splitcard.mute = false;
			s_startgame.mute = false;
			s_timer.mute = false;
			s_showdown.mute = false;
			s_win.mute = false;
			s_call.mute = false;
			s_check.mute = false;
			s_fold.mute = false;
			s_raise.mute = false;
			s_allin.mute = false;
		}, 1)

		soundChk = true;
	}
}