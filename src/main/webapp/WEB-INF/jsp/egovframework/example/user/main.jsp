<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html data-wf-page="680733de29e73c3d654ca31c" data-wf-site="680733de29e73c3d654ca30f">
<head>
	<jsp:include page="frame/header.jsp"></jsp:include>
</head>
<body>
	<div class="root">
		<jsp:include page="frame/menu.jsp"></jsp:include>
		<div class="banner-content main">
			<div class="half-main-left">
				<div data-w-id="ce316016-e5b3-25c3-cb36-bc18abfab52c" style="width: 0px" class="line">
					<div class="circle"></div>
				</div>
				<div data-w-id="ce316016-e5b3-25c3-cb36-bc18abfab52e" style="opacity: 0" class="main-banner-txt">NATURAL</div>
			</div>
			<div class="banner-empty"></div>
			<div class="half-main">
				<div data-w-id="c23ca89a-7509-3ba2-6fd0-8e7064c8526f"
					style="-webkit-transform: translate3d(-25px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); -moz-transform: translate3d(-25px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); -ms-transform: translate3d(-25px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); transform: translate3d(-25px, 0, 0) scale3d(1, 1, 1) rotateX(0) rotateY(0) rotateZ(0) skew(0, 0); opacity: 0"
					class="sub-main-txt">자연을 닮은 당신의 피부</div>
				<div data-w-id="d3d58293-261f-3308-ace8-de0a803b2bb2"
					style="opacity: 0" class="banner-txt">
					BACK TO YOUR<br>NATURAL SKIN
				</div>
			</div>
		</div>
		<div class="naturally-section">
			<div class="main-img-box"></div>
			<div data-w-id="5eed5094-ac10-f291-34f7-b965a345d975" class="naturally-wrap">
				<div style="opacity: 0" class="naturally-txt-sub">피부에게 가장 자연스러운 선택</div>
				<div style="opacity: 0" class="naturally-title">NATURALLY YOU, AGAIN</div>
				<div style="opacity: 0" class="naturally-detail">Lorem ipsum
					Lorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem
					ipsum</div>
			</div>
		</div>
		<jsp:include page="frame/bottom.jsp"></jsp:include>
	</div>
	<jsp:include page="frame/footer.jsp"></jsp:include>
</body>
</html>
<script>
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