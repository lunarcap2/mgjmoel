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
			ArrRs		= arrGetRsSql(DBCon,"SELECT COUNT(개인아이디) FROM 스크랩채용정보 WHERE 개인아이디 = '" & user_id & "'","","")
			totalcnt	= ArrRs(0, 0)

			ArrRs2		= arrGetRsSql(DBCon,"SELECT COUNT(개인아이디) FROM 스크랩채용정보 WHERE 채용정보등록번호 = " & id_num & " and 개인아이디 = '" & user_id & "'","","")
			curcnt		= ArrRs2(0, 0)

			If curcnt = 0 Then
				strSql = "INSERT INTO 스크랩채용정보 (개인아이디, 채용정보등록번호, 채용정보구분, 등록일, 삭제여부) " &_
						 "VALUES ('"& user_id &"', "& id_num & ", '0', GETDATE(), '0')"
				
				Call execSqlParam(DBCon, strSql, "", "", "")

				result = "1"
			Else
				strSql = "DELETE 스크랩채용정보 WHERE 개인아이디 = '" & user_id & "' AND 채용정보등록번호 = '" & id_num & "'"
				
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