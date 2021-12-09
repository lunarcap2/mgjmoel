<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/inc/function/base_util.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->


<%
ConnectDB DBCon, Application("DBInfo_FAIR")

	Dim strRemoteAddr, strUserAgent
	Dim strSql, totalCnt, userChk, arrRs, firstRemoteAddr, educe_email


	strRemoteAddr	= Request.ServerVariables("REMOTE_ADDR")
	strUserAgent	= Request.ServerVariables("HTTP_USER_AGENT")

	'로그인
	If g_LoginChk = 0 Then
		Response.redirect "/my/login.asp"
		Response.end
	End If

	'최초접속
	strSql = "SELECT TOP 1 접속경로 FROM LOG_역량검사접속정보 WHERE 개인아이디 = '" & user_id & "' ORDER BY 등록일 ASC"
	arrRs = arrGetRsSql(DBCon, strSql, "", "")

	If isArray(arrRs) Then
		firstRemoteAddr = arrRs(0,0)

		If isItMobile(firstRemoteAddr) = False Then
			Response.write "<script type='text/javascript'>"
			Response.write "alert('" & user_name & "님의 최초접속은 PC입니다.\n PC로 접속하여 시험에 응하여 주시기 바랍니다.');"
			Response.write "location.href='/';"
			Response.write "</script>"
			Response.end
		End If
	Else
		'응시인원수
		strSql = "SELECT COUNT(DISTINCT 개인아이디) FROM LOG_역량검사접속정보 WHERE 개인아이디 NOT IN ('test4_wk', 'expotest_wk', '200310000261_wk')"
		totalCnt = arrGetRsSql(DBCon, strSql, "", "")(0,0)

		If totalCnt >= 180 Then
			Response.write "<script type='text/javascript'>"
			Response.write "alert('역량검사 응시인원이 마감되었습니다.\n감사합니다.');"
			Response.write "location.href='/';"
			Response.write "</script>"
			Response.end
		End If
	End If

	strSql = "SELECT 이메일주소 FROM AI역량검사_모바일_로그인계정_생성 WHERE 개인아이디= '" & user_id & "'"
	arrRs = arrGetRsSql(DBCon, strSql, "", "")

	If isArray(arrRs) Then
		educe_email = arrRs(0,0)
	End If

	'로그
	strSql = "INSERT INTO LOG_역량검사접속정보(개인아이디, 접속경로, 접속IP, 등록일) VALUES('" & user_id & "', '" & strUserAgent & "', '" & strRemoteAddr & "', GETDATE())"
	DBCon.Execute(strSql)

DisconnectDB DBCon
%>

<script type="text/javascript">
	function fn_submit() {
		if($('#id').val() == '') {
			alert('이메일주소를 입력해주세요.');
			return;
		}

		if($('#pw').val() == '') {
			alert('비밀번호를 입력해주세요.');
			return;
		}

		$.ajax({
			type: "POST"
			, url: "./login_check.asp"
			, data: { id: $('#id').val(), pw: $('#pw').val() }
			, datatype: "html"
			, success: function (data) {
				location.reload();
			}
			, error: function (XMLHttpRequest, textStatus, errorThrown) {
				//alert(textStatus);
			}
		});
	}
</script>
</head>

<body>
<iframe id="procFrame" name="procFrame" style="position:absolute; top:0; left:0; width:0;height:0;border:0;" frameborder="0" src="about:blank"></iframe>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<div class="consul_area">
			<div id="mentor_area_4" class="consul_moth ai_area1" style="display:block;">
				<dl class="what what1">
					<dt>Educe AI 역량검사_In FACE (모바일)<br>
						시작 전 계정준비</dt>
					<dd style="width:30%; text-align:center; margin:0 auto;"><img src="../images/inface1.png" alt="컨설팅신청"></dd>
					<% If isArray(arrRs) Then %>
					<dd>
						* 사용 이메일 : <%=educe_email%><br>
						* 검사시간 : 60분<br>
						* 앱 실행 시, 앱의 설명대로 카메라, 마이크 테스트를 진행해 주세요.<br>
					</dd>
					<% Else %>
					<dd>
						AI역량검사를 모바일로 진행할 경우, In Face 앱 설치가 필요합니다.<br>
						생성하는 ID와 패스워드는  In FACE 앱 접속용으로만 사용됩니다.<br>
					</dd>
					<% End If %>
				</dl>
			</div>

			<div class="login1_content">
				<h2 class="blind">개인회원 로그인</h2>
				
				<div class="login1">
					<% If isArray(arrRs) = False Then %>
					<div class="inp">
						<input class="txt id" id="id" name="id" value="<%=wk_user_email%>" type="text" placeholder="In FACE앱에 접속할 계정(E-mail)을 입력해 주세요.">
						<input class="txt pw" id="pw" name="pw" type="password" maxlength="8" placeholder="비밀번호를 입력해 주세요.(최대 8자리)">
					</div>

					<button class="btn_login" type="button" onclick="fn_submit();">
						<span>계정 생성하기</span>
					</button>

					<div class="consul_moth1" style="display:block;">
						<dl class="apply1">					
							<ul>
								<li>* 입력하신 ID/PW는 자유롭게 입력해 주세요.</li>
								<li>* 입력 후 계정생성 하기 버튼을 클릭하면  In FACE 앱에서 접속이 가능합니다.</li>
								<li>* AI 역량검사_In FACE는 계정당 1회 검사만 가능합니다.</li>
								<li>* 생성된 계정은 박람회 종료 후에도 In FACE 앱에서 검사결과 확인이 가능합니다.</li>
								<li>* 앱 실행 시, 앱의 설명대로 카메라, 마이크 테스트를 진행해 주세요.</li>
							</ul>					
						</dl>
					</div>
					<% End If %>
					
					<!--
					<div class="step3">
						<div class="btn_area2">
							<a href="https://play.google.com/store/apps/details?id=kr.co.whitebox.educegame" class="btn blue">구글 플레이 스토어<br>바로가기</a>
							<a href="https://apps.apple.com/kr/app/inface-ai%EC%97%AD%EB%9F%89%EA%B2%80%EC%82%AC-ai%EB%A9%B4%EC%A0%91-%ED%94%8C%EB%9E%AB%ED%8F%BC-%EC%9D%B8%ED%8E%98%EC%9D%B4%EC%8A%A4/id1541126432" class="btn blue">애플 App 스토어<br>바로가기</a>
						</div>
					</div>
					-->
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //container -->

</body>
</html>
