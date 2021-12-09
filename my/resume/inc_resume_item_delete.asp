<%
If resumeIsComplete = "5" Then
	ConnectDB DBCon, Application("DBInfo_FAIR")

		Call execResumeItemDel_M(DBCon, Array(user_id,rid,rsubGubun,rsubItem,rsub_seq_no,rtype), "", "")

		Call execResumeMonth(DBCon, Array(rid, "", ""), "", "") '이력서 경력월수 update

	DisconnectDB DBCon
End If
%>