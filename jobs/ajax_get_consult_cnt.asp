<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim gubun : gubun = Request("gubun")
	Dim consultant_id : consultant_id = Request("consultant_id")
	Dim consultant_day : consultant_day = Request("consultant_day")

	ReDim Param(2)

	Param(0) = makeparam("@CONSULTANT_ID", adVarChar, adParamInput, 20, consultant_id)
	Param(1) = makeparam("@CONSULTANT_DAY", adVarChar, adParamInput, 10, consultant_day)
	
	If gubun = "C" Then
		Param(2) = makeparam("@USER_ID", adVarChar, adParamInput, 20, "")
	Else
		Param(2) = makeparam("@USER_ID", adVarChar, adParamInput, 20, user_id)
	End If
	
	Dim arrRs
	arrRs = arrGetRsSP(DBcon, "USP_채용상담_일정", Param, "", "")

	DisconnectDB DBCon

	Dim str_rtn : str_rtn = ""
	If isArray(arrRs) Then
		For i=0 To UBound(arrRs, 2)
			If arrRs(0,i) = 3 And gubun = "C" Then
				str_rtn = str_rtn & "," & arrRs(1, i)
			ElseIf gubun = "U" Then
				str_rtn = str_rtn & "," & arrRs(1, i)
			End If
		Next
	End If 

	If str_rtn <> "" Then str_rtn = Mid(str_rtn, 2)
	Response.write str_rtn
%>