<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<%	
	redir = Request.QueryString("redir")
%>
<script type="text/javascript">
	function fn_submit(e) {
		if (event.keyCode == 13) {
			validate(document.lform);
		}
	}

	function validate(frm1){
		var objF = frm1;

		if (objF.id.value.length == 0) {
			fieldChk("아이디를 입력해 주세요. ", objF.id);
			return false;
		}

		if (objF.pw.value.length == 0) {
			fieldChk("비밀번호를 입력해 주세요. ", objF.pw);
			return false;
		}

		if (objF.pw.value.length > 25) {
			fieldChk("비밀번호를 올바르게 입력해 주세요. ", objF.pw);
			return false;
		}

		objF.action ="/my/login_check.asp";
		objF.submit();
	}

	function setCookie(cookieName, value, exdays){
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	function deleteCookie(cookieName){
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}

	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if(start != -1){
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if(end == -1)end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}

	$(document).ready(function(){
		var key = getCookie("key");

		if(key != ""){
			$("#id").val(key);
			$("#save_id").attr("checked", true);
		}

		$("#save_id").change(function(){
			if($("#save_id").is(":checked")){
				setCookie("key", $("#id").val(), 30);
			}else{
				deleteCookie("key");
			}
		});

		$("#id").keyup(function(){
			if($("#save_id").is(":checked")){
				setCookie("key", $("#id").val(), 30);
			}
		});
	});
</script>

<body>


<!-- header -->
<div  id="header">
	<div class="header-wrap detail login">
		<div class="detail_box">
			<a href="/">이전</a>
			<p>로그인</p>
		</div>
	</div>
</div>
<!-- //header -->

<!-- container -->
<div id="contents" class="login">
	<div class="contents">
		<div class="app-wrap login-wrap">
			<div class="login_content">
				<h2 class="blind">개인회원 로그인</h2>
				<form name="lform" id="lform" method="post" autocomplete="off">
				<input type="hidden" value="A" name="from">
				<input type="hidden" name="redir" value="<%=redir%>" id="Hidden1">
				<input type="hidden" name="cp" value="" id="Hidden2">
				<input type="hidden" name="ReturnUrl" value="" id="Hidden3">
				<input type="hidden" name="com_id" value="" id="com_id">
				<input type="hidden" name="passwd" value="" id="passwd">
				<input type="hidden" name="UserIPAddress" value="<%=Request.ServerVariables("LOCAL_ADDR")%>" id="UserIPAddress">

				<div class="login">
					<div class="inp">
						<span><img src="/images/logo_color.png" alt="login_logo"></span>
						<input class="txt id" id="id" name="id" type="text" maxlength="20" placeholder="아이디를 입력해 주세요.">
						<input class="txt pw" id="pw" name="pw" type="password" maxlength="32" placeholder="비밀번호를 입력해 주세요." onkeyup="FC_ChkTextLen(this,32); fn_submit(this);">
					</div>
					<div class="check">
						<!-- <label class="checkbox off" for="chk_login_ing"><input class="chk" id="chk_login_ing" name="chk_login" type="checkbox"><span>로그인 유지</span></label> -->
						<label class="checkbox off" for="save_id"><input class="chk" id="save_id" name="save_id" type="checkbox"><span>ID저장</span></label>
						<div class="sch_box">
							<a href="/my/search/searchID.asp" class="sch id">아이디 찾기</a>
							<a href="/my/search/searchPW.asp" class="sch pass">비밀번호 찾기</a>
						</div>
					</div>
					<button class="btn_login" type="button" onclick="return validate(document.lform);">
						<span>로그인</span>
					</button>
				</div>
				</form>
				<div class="sign_up">
					<p><%=site_name%> 회원으로 가입해 주세요.</p>
					<a href="/my/signup/join.asp">회원가입</a>
				</div>
				<!--
				<ul class="socialLog" style="">
					<li class="sl01 "><a id="fb_login" href="javascript:" onclick="fn_openSNSLogin('FB');"><span class="sprite sl1">fackbook</span>페이스북 로그인</a></li>
					<li class="sl02 "><a id="ko_login" href="javascript:" onclick="fn_openSNSLogin('KO');"><span class="sprite sl2">kakao</span>카카오 로그인</a></li>
					<li class="sl03 "><a id="nv_login" href="javascript:" onclick="fn_openSNSLogin('NV');"><span class="sprite sl3">naver</span>네이버 로그인</a></li>
					<li class="sl04 "><a id="gl_login" href="javascript:" onclick="fn_openSNSLogin('GL');"><span class="sprite sl4">google</span>구글 로그인</a></li>
				</ul>
				-->
			</div><!-- .login_content -->
		</div>
	</div><!-- contents -->
</div><!-- contents -->
<!-- //container -->

<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->

</body>
</html>
