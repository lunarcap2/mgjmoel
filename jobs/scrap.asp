<%
	 Response.CharSet="euc-kr"
     Session.codepage="949"
     Response.codepage="949"
     Response.ContentType="text/html;charset=euc-kr"
%>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->

<%
	Response.AddHeader "P3P", "CP='ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC'"

	Dim id_num, ArrRs, ArrRs2, totalcnt, curcnt

	id_num		= Request("id_num")

	ConnectDB DBCon, Application("DBInfo_FAIR")

	If user_id <> "" Then
		If id_num <> "" Then
			ArrRs		= arrGetRsSql(DBCon,"SELECT COUNT(���ξ��̵�) FROM ��ũ��ä������ WHERE ���ξ��̵� = '" & user_id & "'","","")
			totalcnt	= ArrRs(0, 0)

			ArrRs2		= arrGetRsSql(DBCon,"SELECT COUNT(���ξ��̵�) FROM ��ũ��ä������ WHERE ä��������Ϲ�ȣ = " & id_num & " and ���ξ��̵� = '" & user_id & "'","","")
			curcnt		= ArrRs2(0, 0)

			If curcnt = 0 Then
				strSql = "INSERT INTO ��ũ��ä������ (���ξ��̵�, ä��������Ϲ�ȣ, ä����������, �����, ��������) " &_
						 "VALUES ('"& user_id &"', "& id_num & ", '0', GETDATE(), '0')"
				
				Call execSqlParam(DBCon, strSql, "", "", "")

				result = "1"
			Else
				strSql = "DELETE ��ũ��ä������ WHERE ���ξ��̵� = '" & user_id & "' AND ä��������Ϲ�ȣ = '" & id_num & "'"
				
				Call execSqlParam(DBCon, strSql, "", "", "")

				result = "2"
			End If
		Else
			result = "0"
		End If
	Else
		result = "0"
	End If

	Response.write result

	DisconnectDB DBCon
%>