<%
	 Response.CharSet="euc-kr"
     Session.codepage="949"
     Response.codepage="949"
     Response.ContentType="text/html;charset=euc-kr"
%>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
'Request ��
Dim id, pw
id = Request("hdn_id")
pw = Trim(Request("hdn_pw"))

'������ ��
Dim set_pw
set_pw = EnCodeValue(pw)

ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim strSql

	strSql = "INSERT INTO AI�����˻�_�����_�α��ΰ���_����(���ξ��̵�, �̸����ּ�, ��й�ȣ, ��ȣȭ_��й�ȣ)"
	strSql = strSql & " VALUES('" & user_id & "', '" & id & "', '" & pw & "', '" & set_pw & "')"
	DBCon.Execute(strSql)

DisconnectDB DBCon
%>

<form method="post" name="infaceForm" id="infaceForm" action="https://inface.ai/career" accept-charset="utf-8">
	<input type="hidden" name="SetupNo" value="103" />								<!-- �����ڵ� (�����Ұ�) -->
	<input type="hidden" name="UserID" value="<%=Replace(user_id,"_wk","")%>" />	<!-- ȸ����ȣ�� ���̵���� ����ũ �� -->
	<input type="hidden" name="UserName" value="<%=user_name%>" />					<!-- ���� -->
	<input type="hidden" name="UserEmail" value="<%=id%>" />						<!-- �̸��� -->
	<input type="hidden" name="ReturnUrl" value="1" />								<!-- ������̸� 1�־��� -->
	<input type="hidden" name="UserPass" value="<%=set_pw%>" />						<!-- ��й�ȣ -->
</form>

<script type="text/javascript">
	$(document).ready(function () {
		$('#infaceForm').submit();
	});
</script>