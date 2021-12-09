<!--#include virtual = "/common/common.asp"-->
<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->
<%
	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.Expires = -1
	Response.Charset = "euc-kr"
	
	Dim hid_myPhoto, photo_reg_rid, photo_reg_stp, photo_reg_rtype, photo_reg_cflag, photo_reg_gubun
	hid_myPhoto		= Request("hid_myPhoto")	' 삭제 대상 파일명
	photo_reg_rid	= Request("rid")
	photo_reg_stp	= Request("step")
	photo_reg_rtype	= Request("rtype")
	photo_reg_cflag	= Request("cflag")
	photo_reg_gubun	= Request("rsubGubun")
	

	If Len(hid_myPhoto)>0 And InStr(hid_myPhoto, "/")>0 Then 
		splPhoto	= Split(hid_myPhoto, "/")	
		chkPolder	= splPhoto(0)
		chkFileNm	= splPhoto(1)
	End If 


	Dim sourcepath
	'sourcepath	= "D:\solution\"& site_title &"\files\mypic\"&chkPolder	' 사진 저장 위치
	sourcepath = "\\218.145.70.142\files$\files\fair\mypic\" & chkPolder

	Dim objFS, Post
	Set objFS = CreateObject("Scripting.FileSystemObject")


	If Len(chkFileNm)>0 Then
		
		' 1) 파일 삭제
		Set Post = Server.CreateObject("ActiveFile.Post")
		On Error Resume Next
		objFs.DeleteFile sourcepath &"\"& chkFileNm
		Post.Flush
		Set Post = Nothing 

		' 2) DB 저장 정보 수정
ConnectDB DBCon, Application("DBInfo_FAIR")

		strSql = "UPDATE 개인회원정보 SET 사진파일 = ''"
		strSql = strSql & " WHERE 개인아이디 = '" & user_id & "'"
		strSql = strSql & " ; UPDATE 이력서 SET 사진유무 = '0', 사진파일=''"
		strSql = strSql & " WHERE 개인아이디 = '" & user_id & "'"
		strSql = strSql & " ; UPDATE 이력서공통정보 SET 사진유무 = '0', 사진파일=''"
		strSql = strSql & " WHERE 개인아이디 = '" & user_id & "'"
DBCon.Execute (strSql)

DisconnectDB DBCon

		Response.Write "<script language=javascript>"&_
		"alert('이력서 사진이 삭제 되었습니다.');"&_
		"location.href='/my/resume/rsub_regist.asp?rid=" & photo_reg_rid & "&step=" & photo_reg_stp & "&rtype=" & photo_reg_rtype & "&cflag=" & photo_reg_cflag & "&rsubGubun=" & photo_reg_gubun & "';"&_
		"</script>"
		Response.End
	Else 
		Response.write "<script language='javascript'>"
		Response.write "alert('삭제 대상 파일을 찾을 수 없습니다.');"
		Response.write "history.back();"
		Response.write "</script>"
	End If 
%>