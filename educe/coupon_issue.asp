<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/inc/function/aspJSON1.17.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
'Response.write "<script>"
'Response.write "alert('�ڶ�ȸ�� ����Ǿ����ϴ�.\n������ �ּż� �����մϴ�.');"
'Response.write "location.href = './guid.asp';"
'Response.write "</script>"
'Response.end

ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim sql_couponCnt, couponCnt

	sql_couponCnt = ""
	sql_couponCnt = sql_couponCnt & "SELECT COUNT(*) "
	sql_couponCnt = sql_couponCnt & "  FROM AI�����˻����� AS A "
	sql_couponCnt = sql_couponCnt & " INNER JOIN ��������� AS B ON A.���ξ��̵� = B.���̵� "
	sql_couponCnt = sql_couponCnt & " WHERE A.���ξ��̵� IS NOT NULL "
	sql_couponCnt = sql_couponCnt & "   AND B.�̸��� NOT LIKE '%@career.co.kr' "
	sql_couponCnt = sql_couponCnt & "   AND B.���̵� NOT IN ('yesol12_wk') "

	couponCnt = arrGetRsSql(DBCon, sql_couponCnt, "", "")(0,0)

	If couponCnt >= 100 Then
		Response.write "<script>"
		Response.write "alert('���� �߱��� �����Ǿ����ϴ�.\n������ �ּż� �����մϴ�.');"
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
	Rtn				= arrGetRsSP(DBcon, "usp_AI�����˻�����_��ȸ_�߱�", Param, "", "")(0,0)
	str_user_id		= Replace(user_id,"_wk","")
	str_now_date	= FormatDateTime(Now(),2) & " " & FormatDateTime(Now(),4) & ":" & Second(Now())
	
	
	If Len(Rtn) > 1 Then
		str_coupon_code = Rtn

		'base64encode
		str_EnCodeValue = EnCodeValue("user_id=" & str_user_id & "&coupon_code=" & str_coupon_code & "&date=" & str_now_date)
	Else
		If Rtn = "E" Then
			rtn_msg = "������ �δ� 1ȸ�� �߱޵˴ϴ�.\n" & user_name & "���� �̹� �߱޹��� ������ �����մϴ�."
		Else
			'Rtn = F
			rtn_msg = "�ٽ� �õ��� �ּ���."
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

'json �Ľ�
Set oJSON = New aspJSON
oJSON.loadJSON(json_coupon_issue)
json_result	= oJSON.data("result")
json_msg	= oJSON.data("msg")

'Response.write "json_result : " & json_result & "<br>"
'Response.write "json_msg : " & json_msg & "<br>"

'������(json_result:Y) ���� �߼�
If json_result = "N" Then
	rtn_msg = "�ٽ� �õ��� �ּ���."
Else
	ConnectDB DBCon, Application("DBInfo_FAIR")

		ReDim Param(3)
		Param(0) = makeparam("@GUBUN"		,adChar			,adParamInput	,1	,"U")
		Param(1) = makeparam("@USER_ID"		,adVarChar		,adParamInput	,20	,user_id)
		Param(2) = makeparam("@COUPON_CODE"	,adChar			,adParamInput	,14	,str_coupon_code)
		Param(3) = makeparam("@DATE"		,adDBTimeStamp	,adParamInput	,20	,str_now_date)

		Rtn	= arrGetRsSP(DBcon, "usp_AI�����˻�����_��ȸ_�߱�", Param, "", "")(0,0)

		If Rtn = "S" Then
			Dim strSql, arrRsUserInfo, rs_cellphone, rs_email
			strSql = "SELECT �޴��� FROM ����ȸ������ WITH(NOLOCK) WHERE ���ξ��̵� = '" & user_id & "'"
			arrRsUserInfo = arrGetRsSql(DBCon, strSql, "", "")

			If isArray(arrRsUserInfo) Then
				rs_cellphone	= arrRsUserInfo(0,0)
			End If

			'���� �߼�
			ConnectDB DBCon2, Application("DBInfo_etc")

				Dim now_time, msg, strSql4, smsid
				now_time = year(now) & Right("0"&month(now),2) & Right("0"&day(now),2) & Right("0"&hour(now),2) & Right("0"&minute(now),2) & Right("0"&second(now),2)
				
				msg = "�ȳ��ϼ��� " & site_name & " � �繫�� �Դϴ�." & vbCrlf & vbCrlf
				msg = msg & "AI�����˻縦 �����Ͻ� �� �ִ� ������ȣ�� ���ǻ��׿� ���� �ȳ� �帳�ϴ�." & vbCrlf & vbCrlf
				msg = msg & "�� ���� ��ȣ: " & str_coupon_code & "" & vbCrlf
				msg = msg & "�� �߱� �Ͻ�: " & str_now_date & "" & vbCrlf
				msg = msg & "�� ������ �δ� 1ȸ�� �߱޵Ǹ�, �߱��Ͻ÷κ��� 24�ð� �̳� �ݵ�� ����ؾ� �մϴ�." & vbCrlf
				msg = msg & "�� �̻���, ������ �Ҹ�Ǿ� �˻縦 ������ �� ������ �˻� ���û�� �Ұ��մϴ�." & vbCrlf
				msg = msg & "�� ��Ȱ�� ������ ���� ���� �� ���� �޴����� ī�޶�, ����Ŀ, ����ũ�� ���� �۵��Ǵ��� üũ�� �ּ���." & vbCrlf

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


			rtn_msg = "������ �߱޵Ǿ����ϴ�.\nȸ������ �� ����� �޴�����ȣ�� ������ȣ�� �߼۵˴ϴ�."
		Else
			rtn_msg = site_name & " � �繫������ �����ֽñ� �ٶ��ϴ�."
		End If	

	DisconnectDB DBCon

	Response.write "<script type='text/javascript'>"
	Response.write "alert('" & rtn_msg & "');"
	Response.write "location.href = './guid.asp';"
	Response.write "</script>"
	Response.end
End If
%>