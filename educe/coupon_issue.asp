<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/inc/function/aspJSON1.17.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
'Response.write "<script>"
'Response.write "alert('박람회가 종료되었습니다.\n참여해 주셔서 감사합니다.');"
'Response.write "location.href = './guid.asp';"
'Response.write "</script>"
'Response.end

ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim sql_couponCnt, couponCnt

	sql_couponCnt = ""
	sql_couponCnt = sql_couponCnt & "SELECT COUNT(*) "
	sql_couponCnt = sql_couponCnt & "  FROM AI역량검사쿠폰 AS A "
	sql_couponCnt = sql_couponCnt & " INNER JOIN 사용자정보 AS B ON A.개인아이디 = B.아이디 "
	sql_couponCnt = sql_couponCnt & " WHERE A.개인아이디 IS NOT NULL "
	sql_couponCnt = sql_couponCnt & "   AND B.이메일 NOT LIKE '%@career.co.kr' "
	sql_couponCnt = sql_couponCnt & "   AND B.아이디 NOT IN ('yesol12_wk') "

	couponCnt = arrGetRsSql(DBCon, sql_couponCnt, "", "")(0,0)

	If couponCnt >= 100 Then
		Response.write "<script>"
		Response.write "alert('쿠폰 발급이 마감되었습니다.\n참여해 주셔서 감사합니다.');"
		Response.write "location.href = './guid.asp';"
		Response.write "</script>"
		Response.end
	End If

	ReDim Param(3)
	Param(0) = makeparam("@GUBUN"		,adChar			,adParamInput	,1	,"S")
	Param(1) = makeparam("@USER_ID"		,adVarChar		,adParamInput	,20	,user_id)
	Param(2) = makeparam("@COUPON_CODE"	,adChar			,adParamInput	,14	,"")
	Param(3) = makeparam("@DATE"		,adDBTimeStamp	,adParamInput	,20	,"")

	Dim Rtn, str_coupon_code, str_user_id, str_now_date, str_EnCodeValue, rtn_msg
	Rtn				= arrGetRsSP(DBcon, "usp_AI역량검사쿠폰_조회_발급", Param, "", "")(0,0)
	str_user_id		= Replace(user_id,"_wk","")
	str_now_date	= FormatDateTime(Now(),2) & " " & FormatDateTime(Now(),4) & ":" & Second(Now())
	
	
	If Len(Rtn) > 1 Then
		str_coupon_code = Rtn

		'base64encode
		str_EnCodeValue = EnCodeValue("user_id=" & str_user_id & "&coupon_code=" & str_coupon_code & "&date=" & str_now_date)
	Else
		If Rtn = "E" Then
			rtn_msg = "쿠폰은 인당 1회만 발급됩니다.\n" & user_name & "님은 이미 발급받은 내역이 존재합니다."
		Else
			'Rtn = F
			rtn_msg = "다시 시도해 주세요."
		End If

		Response.write "<script type='text/javascript'>"
		Response.write "alert('" & rtn_msg & "');"
		Response.write "location.href='./guid.asp';"
		Response.write "</script>"
		Response.end
	End If	
	
	'Response.write "str_user_id : " & str_user_id & "<br>"
	'Response.write "Rtn : " & Rtn & "<br>"
	'Response.write "str_now_date : " & str_now_date & "<br>"	
	'Response.write "str_EnCodeValue : " & str_EnCodeValue & "<br>"
	'Response.end	

DisconnectDB DBCon


Function coupon_issue(str_EnCodeValue)
	api_url = "https://www.inface.ai/career/api/mobileCouponCheck/?" & str_EnCodeValue

	Set objXMLHTTP = server.CreateObject("MSXML2.ServerXMLHTTP.3.0")
	objXMLHTTP.Open "POST", api_url, false
	objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded;charset=utf-8"
	objXMLHTTP.Send
	If objXMLHTTP.status = 200 Then ret_value = objXMLHTTP.responseText Else ret_value = objXMLHTTP.responseText
	Set objXMLHTTP=Nothing

	coupon_issue = ret_value
End function


Dim json_coupon_issue, json_result, json_msg
json_coupon_issue = coupon_issue(str_EnCodeValue)

'json 파싱
Set oJSON = New aspJSON
oJSON.loadJSON(json_coupon_issue)
json_result	= oJSON.data("result")
json_msg	= oJSON.data("msg")

'Response.write "json_result : " & json_result & "<br>"
'Response.write "json_msg : " & json_msg & "<br>"

'성공시(json_result:Y) 문자 발송
If json_result = "N" Then
	rtn_msg = "다시 시도해 주세요."
Else
	ConnectDB DBCon, Application("DBInfo_FAIR")

		ReDim Param(3)
		Param(0) = makeparam("@GUBUN"		,adChar			,adParamInput	,1	,"U")
		Param(1) = makeparam("@USER_ID"		,adVarChar		,adParamInput	,20	,user_id)
		Param(2) = makeparam("@COUPON_CODE"	,adChar			,adParamInput	,14	,str_coupon_code)
		Param(3) = makeparam("@DATE"		,adDBTimeStamp	,adParamInput	,20	,str_now_date)

		Rtn	= arrGetRsSP(DBcon, "usp_AI역량검사쿠폰_조회_발급", Param, "", "")(0,0)

		If Rtn = "S" Then
			Dim strSql, arrRsUserInfo, rs_cellphone, rs_email
			strSql = "SELECT 휴대폰 FROM 개인회원정보 WITH(NOLOCK) WHERE 개인아이디 = '" & user_id & "'"
			arrRsUserInfo = arrGetRsSql(DBCon, strSql, "", "")

			If isArray(arrRsUserInfo) Then
				rs_cellphone	= arrRsUserInfo(0,0)
			End If

			'문자 발송
			ConnectDB DBCon2, Application("DBInfo_etc")

				Dim now_time, msg, strSql4, smsid
				now_time = year(now) & Right("0"&month(now),2) & Right("0"&day(now),2) & Right("0"&hour(now),2) & Right("0"&minute(now),2) & Right("0"&second(now),2)
				
				msg = "안녕하세요 " & site_name & " 운영 사무국 입니다." & vbCrlf & vbCrlf
				msg = msg & "AI역량검사를 진행하실 수 있는 쿠폰번호와 유의사항에 대해 안내 드립니다." & vbCrlf & vbCrlf
				msg = msg & "■ 쿠폰 번호: " & str_coupon_code & "" & vbCrlf
				msg = msg & "■ 발급 일시: " & str_now_date & "" & vbCrlf
				msg = msg & "※ 쿠폰은 인당 1회만 발급되며, 발급일시로부터 24시간 이내 반드시 사용해야 합니다." & vbCrlf
				msg = msg & "※ 미사용시, 쿠폰은 소멸되어 검사를 진행할 수 없으며 검사 재신청도 불가합니다." & vbCrlf
				msg = msg & "※ 원활한 진행을 위해 참여 전 접속 휴대폰의 카메라, 스피커, 마이크가 정상 작동되는지 체크해 주세요." & vbCrlf

				Set Rs = Server.CreateObject("ADODB.RecordSet")
				strSql4 = "select max(CMP_MSG_ID) as cmid from arreo_sms where not (left(CMP_MSG_ID, 5) = 'ALARM') "
				Rs.Open strSql4, DBCon2, 0, 1
				If Not (Rs.BOF Or Rs.EOF) Then
					smsid = rs("cmid") + 1

					sql2 = "Insert Into arreo_sms (CMP_MSG_ID, CMP_USR_ID, ODR_FG, SMS_GB, USED_CD, MSG_GB, WRT_DTTM, SND_DTTM, SND_PHN_ID, RCV_PHN_ID, CALLBACK, SUBJECT, SND_MSG, EXPIRE_VAL, SMS_ST, RSLT_VAL, RSRVD_ID, RSRVD_WD)" &_
							" Values ('" & smsid & "', '00000', '2', '1', '00', 'M', '" & now_time & "', '" & now_time & "', 'daumhr', '" & Replace(Replace(rs_cellphone, " ", ""),"-","") & "', '" & Replace(Replace(site_callback_phone, " ", ""),"-","") & "', '" & site_name & "', '" & msg & "', 0, '0', 99,'','');"
					DBCon2.Execute(sql2)
				End If
				Rs.Close

			DisconnectDB DBCon2	


			rtn_msg = "쿠폰이 발급되었습니다.\n회원가입 시 등록한 휴대폰번호로 쿠폰번호가 발송됩니다."
		Else
			rtn_msg = site_name & " 운영 사무국으로 연락주시기 바랍니다."
		End If	

	DisconnectDB DBCon

	Response.write "<script type='text/javascript'>"
	Response.write "alert('" & rtn_msg & "');"
	Response.write "location.href = './guid.asp';"
	Response.write "</script>"
	Response.end
End If
%>