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

	Dim com_idnum, company_name, company_id, ArrRs, ArrRs2, totalcnt, chk_cnt

	com_idnum		= Request("com_idnum")
	company_name	= unescape(Request.form("company_name"))
	company_id		= Request("company_id")

	company_name = replace(company_name, "��", "(��)")

	ConnectDB DBCon, Application("DBInfo_FAIR")

	If company_id <> "" Then
		If com_idnum <> "" Then
			ArrRs		= arrGetRsSql(DBCon,"SELECT COUNT(���ξ��̵�) FROM ���ΰ��ɱ�� WHERE ���ξ��̵� = '" & user_id & "'","","")
			totalcnt	= ArrRs(0, 0)

			ArrRs2		= arrGetRsSql(DBCon,"SELECT ��Ϲ�ȣ FROM ���ΰ��ɱ�� WHERE ����ڵ�Ϲ�ȣ = '" & com_idnum & "' and ���ξ��̵� = '" & user_id & "'","","")
			
			If isArray(ArrRs2) Then
				strSql = "DELETE ���ΰ��ɱ�� WHERE ���ξ��̵� = '" & user_id & "' AND ��Ϲ�ȣ = '" & ArrRs2(0, 0) & "'"
				
				Call execSqlParam(DBCon, strSql, "", "", "")

				result = "2"
			Else
				chk_cnt = totalcnt + 1 '���ݱ��� ����� ���ɱ�� + ���ݺ��� �߰��� ���ɱ��

				If chk_cnt > 50 Then '50�� ����		
					Response.write "50"
					Response.End
				End If  
				
				strSql = "INSERT INTO ���ΰ��ɱ�� (���ξ��̵�, ����ڵ�Ϲ�ȣ, ȸ���, ȸ����̵�, �����, ����Ʈ) " &_
						 "VALUES ('"& user_id &"', '"& com_idnum &"', '"& company_name &"', '"& company_id &"', GETDATE(), 'P')"
				
				Call execSqlParam(DBCon, strSql, "", "", "")

				result = "1"				
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