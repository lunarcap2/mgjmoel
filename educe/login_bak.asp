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

	'�α���
	If g_LoginChk = 0 Then
		Response.redirect "/my/login.asp"
		Response.end
	End If

	'��������
	strSql = "SELECT TOP 1 ���Ӱ�� FROM LOG_�����˻��������� WHERE ���ξ��̵� = '" & user_id & "' ORDER BY ����� ASC"
	arrRs = arrGetRsSql(DBCon, strSql, "", "")

	If isArray(arrRs) Then
		firstRemoteAddr = arrRs(0,0)

		If isItMobile(firstRemoteAddr) = False Then
			Response.write "<script type='text/javascript'>"
			Response.write "alert('" & user_name & "���� ���������� PC�Դϴ�.\n PC�� �����Ͽ� ���迡 ���Ͽ� �ֽñ� �ٶ��ϴ�.');"
			Response.write "location.href='/';"
			Response.write "</script>"
			Response.end
		End If
	Else
		'�����ο���
		strSql = "SELECT COUNT(DISTINCT ���ξ��̵�) FROM LOG_�����˻��������� WHERE ���ξ��̵� NOT IN ('test4_wk', 'expotest_wk', '200310000261_wk')"
		totalCnt = arrGetRsSql(DBCon, strSql, "", "")(0,0)

		If totalCnt >= 180 Then
			Response.write "<script type='text/javascript'>"
			Response.write "alert('�����˻� �����ο��� �����Ǿ����ϴ�.\n�����մϴ�.');"
			Response.write "location.href='/';"
			Response.write "</script>"
			Response.end
		End If
	End If

	strSql = "SELECT �̸����ּ� FROM AI�����˻�_�����_�α��ΰ���_���� WHERE ���ξ��̵�= '" & user_id & "'"
	arrRs = arrGetRsSql(DBCon, strSql, "", "")

	If isArray(arrRs) Then
		educe_email = arrRs(0,0)
	End If

	'�α�
	strSql = "INSERT INTO LOG_�����˻���������(���ξ��̵�, ���Ӱ��, ����IP, �����) VALUES('" & user_id & "', '" & strUserAgent & "', '" & strRemoteAddr & "', GETDATE())"
	DBCon.Execute(strSql)

DisconnectDB DBCon
%>

<script type="text/javascript">
	function fn_submit() {
		if($('#id').val() == '') {
			alert('�̸����ּҸ� �Է����ּ���.');
			return;
		}

		if($('#pw').val() == '') {
			alert('��й�ȣ�� �Է����ּ���.');
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
					<dt>Educe AI �����˻�_In FACE (�����)<br>
						���� �� �����غ�</dt>
					<dd style="width:30%; text-align:center; margin:0 auto;"><img src="../images/inface1.png" alt="�����ý�û"></dd>
					<% If isArray(arrRs) Then %>
					<dd>
						* ��� �̸��� : <%=educe_email%><br>
						* �˻�ð� : 60��<br>
						* �� ���� ��, ���� ������ ī�޶�, ����ũ �׽�Ʈ�� ������ �ּ���.<br>
					</dd>
					<% Else %>
					<dd>
						AI�����˻縦 ����Ϸ� ������ ���, In Face �� ��ġ�� �ʿ��մϴ�.<br>
						�����ϴ� ID�� �н������  In FACE �� ���ӿ����θ� ���˴ϴ�.<br>
					</dd>
					<% End If %>
				</dl>
			</div>

			<div class="login1_content">
				<h2 class="blind">����ȸ�� �α���</h2>
				
				<div class="login1">
					<% If isArray(arrRs) = False Then %>
					<div class="inp">
						<input class="txt id" id="id" name="id" value="<%=wk_user_email%>" type="text" placeholder="In FACE�ۿ� ������ ����(E-mail)�� �Է��� �ּ���.">
						<input class="txt pw" id="pw" name="pw" type="password" maxlength="8" placeholder="��й�ȣ�� �Է��� �ּ���.(�ִ� 8�ڸ�)">
					</div>

					<button class="btn_login" type="button" onclick="fn_submit();">
						<span>���� �����ϱ�</span>
					</button>

					<div class="consul_moth1" style="display:block;">
						<dl class="apply1">					
							<ul>
								<li>* �Է��Ͻ� ID/PW�� �����Ӱ� �Է��� �ּ���.</li>
								<li>* �Է� �� �������� �ϱ� ��ư�� Ŭ���ϸ�  In FACE �ۿ��� ������ �����մϴ�.</li>
								<li>* AI �����˻�_In FACE�� ������ 1ȸ �˻縸 �����մϴ�.</li>
								<li>* ������ ������ �ڶ�ȸ ���� �Ŀ��� In FACE �ۿ��� �˻��� Ȯ���� �����մϴ�.</li>
								<li>* �� ���� ��, ���� ������ ī�޶�, ����ũ �׽�Ʈ�� ������ �ּ���.</li>
							</ul>					
						</dl>
					</div>
					<% End If %>
					
					<!--
					<div class="step3">
						<div class="btn_area2">
							<a href="https://play.google.com/store/apps/details?id=kr.co.whitebox.educegame" class="btn blue">���� �÷��� �����<br>�ٷΰ���</a>
							<a href="https://apps.apple.com/kr/app/inface-ai%EC%97%AD%EB%9F%89%EA%B2%80%EC%82%AC-ai%EB%A9%B4%EC%A0%91-%ED%94%8C%EB%9E%AB%ED%8F%BC-%EC%9D%B8%ED%8E%98%EC%9D%B4%EC%8A%A4/id1541126432" class="btn blue">���� App �����<br>�ٷΰ���</a>
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
