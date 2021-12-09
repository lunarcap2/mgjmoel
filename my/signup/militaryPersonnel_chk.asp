<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
Session.CodePage  = 949			'한글
Response.CharSet  = "euc-kr"	'한글
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "cache-control", "no-staff"
Response.Expires  = -1


Dim txtPhone, txtName, militaryPersonnelNumber
txtPhone				= Request("txtPhone")
txtName					= unescape(Request("txtName"))
militaryPersonnelNumber	= Request("militaryPersonnelNumber")


ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim strSql : strSql = ""
	strSql = strSql & "SELECT COUNT(*) FROM 군무원명단 WHERE 이름 = '" & txtName & "'"
	strSql = strSql & " AND 순번 = '" & militaryPersonnelNumber & "'"
	strSql = strSql & " AND REPLACE(연락처,'-','') = '" & txtPhone & "'"
	
	Response.write arrGetRsSql(DBCon, strSql, "", "")(0,0)	

DisconnectDB DBCon
%>