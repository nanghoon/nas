<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html data-wf-page="681c40a38af61b6913a830f4" data-wf-site="680733de29e73c3d654ca30f">
<head>
	<jsp:include page="frame/header.jsp"></jsp:include>
</head>
<body>
	<div class="root">
		<jsp:include page="frame/menu.jsp"></jsp:include>
		<div class="banner-content support">
			<div class="half-support">
				<div data-w-id="7c994296-a1b8-27a6-db27-66aa9f648465"
					style="-webkit-transform: translate3d(-20px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); -moz-transform: translate3d(-20px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); -ms-transform: translate3d(-20px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); transform: translate3d(-20px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); opacity: 0"
					class="w-layout-vflex">
					<div class="sub-main-txt support">무엇을 도와드릴까요?</div>
					<div class="main-banner-txt support">COUNSELING</div>
					<div class="main-banner-txt support">Need help?</div>
				</div>
			</div>
			<div class="banner-empty"></div>
			<div class="half-main"></div>
		</div>
		<div class="support-send-section">
			<div class="frame-max support">
				<div data-w-id="c7a73b3c-3cc6-94e2-4abb-422f1fa041b9"
					style="-webkit-transform: translate3d(-20px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); -moz-transform: translate3d(-20px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); -ms-transform: translate3d(-20px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); transform: translate3d(-20px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); opacity: 0"
					class="half">
					<div class="support-h-txt">Lorem Ipsum</div>
					<div>Lorem Ipsum is simply dummy text of the printing and
						typesetting industry. Lorem Ipsum has been the industry&#x27;s
						standard dummy text ever since the 1500s, when an unknown printer
						took a galley of type and scrambled it to make a type specimen
						book. It has survived not only five centuries, but also the leap
						into electronic typesetting, remaining essentially unchanged. It
						was popularised in the 1960s with the release of Letraset sheets
						containing Lorem Ipsum passages, and more recently with desktop
						publishing software like Aldus PageMaker including versions of
						Lorem Ipsum.</div>
				</div>
				<div class="half">
					<div class="form-send w-form">
						<form name="form" style="-webkit-transform: translate3d(0, -35px, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); -moz-transform: translate3d(0, -35px, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); -ms-transform: translate3d(0, -35px, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); transform: translate3d(0, -35px, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); opacity: 0"
							data-w-id="a75653e4-d5dd-6974-e231-0b2ab594c02d" id="form"
							class="support-send" data-wf-page-id="681c40a38af61b6913a830f4"
							data-wf-element-id="a75653e4-d5dd-6974-e231-0b2ab594c02d">
							<input class="support-input w-input" maxlength="100" name="company" placeholder="병원/업체명" type="text">
							<input class="support-input w-input" maxlength="30" name="name" placeholder="성함" type="text">
							<input class="support-input w-input" maxlength="20" onkeyup="SetNum(this);" name="phone" placeholder="휴대폰 (숫자만 입력)" type="text">
							<input class="support-input w-input" maxlength="200" name="email" placeholder="이메일" type="text">
							<textarea placeholder="문의내용" maxlength="5000" name="text" class="support-input area-input w-input"></textarea>
							<a href="javascript:support()" class="send-btn w-button">문의 완료하기</a>
						</form>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="frame/bottom.jsp"></jsp:include>
	</div>
	<jsp:include page="frame/footer.jsp"></jsp:include>
</body>
</html>
<script>
function setNum(obj){
	val=obj.value;
	re=/[^0-9]/gi;
	obj.value=val.replace(re,"");
}
function support(){
	$(".send-btn").attr("href","javascript:void(0)");
	if(confirm("문의하시겠습니까?")){
		$.ajax({
			type :'post',
			url :'/nas/supportInsert.do',
			data :$("#form").serialize(),
			success:function(data){
				alert(data.msg)
				if(data.result == 'success'){
					location.reload();
				}else{
					$(".send-btn").attr("href","javascript:support()");
				}
				
			}
		})
	}
}
document.addEventListener('DOMContentLoaded', () => {
	  const breakpoint = 768; // 모바일/PC 기준(px)
	  const btn = document.querySelector('.menu-hamberger');
	  const frame = document.querySelector('.menu-frame');
	  const closeBtns = document.querySelectorAll('.close-btn');
	  // 1) 햄버거 메뉴 토글 + body 스크롤 잠금/해제
	  if (btn && frame) {
	    const updateFrame = () => {
	      if (window.innerWidth > breakpoint) {
	        frame.style.display = 'flex';
	        document.body.style.overflow = '';
	      } else {
	        frame.style.display = 'none';
	        document.body.style.overflow = '';
	      }
	    };
	    updateFrame();
	    window.addEventListener('resize', updateFrame);
	    btn.addEventListener('click', () => {
	      if (window.innerWidth <= breakpoint) {
	        if (frame.style.display === 'flex') {
	          frame.style.display = 'none';
	          document.body.style.overflow = '';
	        } else {
	          frame.style.display = 'flex';
	          document.body.style.overflow = 'hidden';
	        }
	      }
	    });
	  }
	  // 닫기 버튼 클릭 시 menu-frame 숨기고 스크롤 복원
	  closeBtns.forEach(closeBtn => {
	    closeBtn.addEventListener('click', () => {
	      if (frame) {
	        frame.style.display = 'none';
	        document.body.style.overflow = '';
	      }
	    });
	  });
	  // 2) .menu-list → .hover-menu: PC hover / 모바일 click
	  document.querySelectorAll('.menu-list').forEach(menu => {
	    const sub = menu.querySelector('.hover-menu');
	    if (!sub) return;
	    let hideTimeout, rafId;
	    sub.style.display = 'none';
	    sub.style.opacity = 1;
	    // 즉시 보이기
	    const showSub = () => {
	      clearTimeout(hideTimeout);
	      cancelAnimationFrame(rafId);
	      sub.style.display = 'flex';
	      sub.style.opacity = 1;
	    };
	    // 200ms 지연 후 200ms 페이드아웃
	    const hideSub = () => {
	      clearTimeout(hideTimeout);
	      hideTimeout = setTimeout(() => {
	        const duration = 200;
	        const start = performance.now();
	        function animate(now) {
	          const t = Math.min((now - start) / duration, 1);
	          sub.style.opacity = 1 - t;
	          if (t < 1) {
	            rafId = requestAnimationFrame(animate);
	          } else {
	            sub.style.display = 'none';
	            sub.style.opacity = 1;
	          }
	        }
	        rafId = requestAnimationFrame(animate);
	      }, 200);
	    };
	    // 모바일 클릭 토글 (즉시 show/hide)
	    menu.addEventListener('click', e => {
	      if (window.innerWidth <= breakpoint) {
	        if (sub.style.display === 'flex') {
	          sub.style.display = 'none';
	          sub.style.opacity = 1;
	        } else {
	          sub.style.display = 'flex';
	          sub.style.opacity = 1;
	        }
	      }
	    });
	    // PC hover
	    menu.addEventListener('mouseenter', () => {
	      if (window.innerWidth > breakpoint) showSub();
	    });
	    sub.addEventListener('mouseenter', () => {
	      if (window.innerWidth > breakpoint) showSub();
	    });
	    menu.addEventListener('mouseleave', () => {
	      if (window.innerWidth > breakpoint) hideSub();
	    });
	    sub.addEventListener('mouseleave', () => {
	      if (window.innerWidth > breakpoint) hideSub();
	    });
	  });
	});
</script>
