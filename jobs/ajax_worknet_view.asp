<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	Dim seq, subject
	seq = Request("seq")
	subject = unescape(Request("subject"))

	ConnectDB DBCon, Application("DBInfo_FAIR")

		Dim regKey : regKey = 0
		Dim strSql

		strSql = "INSERT INTO T_GJMOEL_JOBS_CLICK VALUES('" & seq & "', '" & subject & "', 'M', GETDATE(),'"&user_id&"')"
'		Response.write strSql
'		Response.end
		DBCon.Execute(strSql)

	DisconnectDB DBCon

	Response.write regKey
%>