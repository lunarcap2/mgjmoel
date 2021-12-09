<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	Dim consultant_id, consultant_day, consultant_time, rtn
	consultant_id	= Request("set_interview_id")
	consultant_day	= Request("set_interview_day")
	consultant_time	= Request("set_interview_time")


	'1) ���»� ������ ��û ���� ���̺� ���� ����
	ConnectDB DBCon, Application("DBInfo_FAIR")
	
	ReDim Param(5)
	Param(0) = makeparam("@CONSULTANT_ID", adVarChar, adParamInput, 20, consultant_id)
	Param(1) = makeparam("@CONSULTANT_DAY", adVarChar, adParamInput, 10, consultant_day)
	Param(2) = makeparam("@CONSULTANT_TIME", adVarChar, adParamInput, 2, consultant_time)
	Param(3) = makeparam("@USER_ID", adVarChar, adParamInput, 20, user_id)
	Param(4) = makeParam("@RTN", adChar, adParamOutput, 1, "")
	Param(5) = makeParam("@SEQ", adInteger, adParamOutput, 4, "")
	
	Call execSP(DBCon, "USP_ä����_��û", Param, "", "")
	rtn		= getParamOutputValue(Param, "@RTN")
	cs_Seq	= getParamOutputValue(Param, "@SEQ")

	DisconnectDB DBCon


	'2) ��û���� DB ���� ���� �� �ȳ� ����/���� �߼�
	If rtn="O" Then ' ���� ������ - O: ����, N: ���� ��� �ߺ� ��û, C: ���� �Ͻ� �ߺ� ��û, X: ��û ����		

		'2-1) ������ ��û ���� ����
	ConnectDB DBCon, Application("DBInfo_FAIR")
		
		spName2 = "usp_ä����_����_��û������ȸ"
		ReDim param2(2)
		Param2(0) = makeparam("@CONS_REQ_SEQ",		adInteger, adParamInput, 4, cs_Seq)
		Param2(1) = makeparam("@CONSULTANT_DAY",	adVarChar, adParamInput, 10, consultant_day)
		Param2(2) = makeparam("@CONSULTANT_TIME",	adVarChar, adParamInput, 2, consultant_time)

		arrRs = arrGetRsSP(DBCon, spName2, param2, "", "")
		If isArray(arrRs) Then 
			rs_ConsReqNm			= arrRs(0, 0)	' ��û�ڸ�
			rs_ConsReqPhone			= arrRs(1, 0)	' ��û�� �޴�����ȣ
			rs_ConsReqMail			= arrRs(2, 0)	' ��û�� �����ּ�
			rs_ConsReqDt			= arrRs(3, 0)	' �������
			rs_ConsReqYoil			= arrRs(4, 0)	' ������
			rs_ConsReqTm			= arrRs(5, 0)	' ���ð���
			rs_ConsOntactUrlCd		= arrRs(6, 0)	' ���URL�ڵ�
			rs_ConsOntactUrl_Guest	= arrRs(7, 0)	' ȭ�� ä���� ���� ��û�� URL
			rs_ConsBizId			= arrRs(8, 0)	' ȭ�� ä���� ȸ����̵�
			rs_ConsBizNm			= arrRs(9, 0)	' ȭ�� ä���� ȸ���
		End If 
		
		rs_ConsReqTm = rs_ConsReqTm&" (25��)"

	DisconnectDB DBCon
		
		' ��û�� �޴���,������ �־�� �ȳ� ����/������ ������ ����
		If (isnull(rs_ConsReqPhone) = false) Then
		
			'2-2) ���� �߼�
			ConnectDB DBCon2, Application("DBInfo_etc")

				Dim now_time, msg, strSql, smsid
				now_time = year(now) & Right("0"&month(now),2) & Right("0"&day(now),2) & Right("0"&hour(now),2) & Right("0"&minute(now),2) & Right("0"&second(now),2)
				
				msg = "�ȳ��ϼ��� "&site_short_name&" � �繫�� �Դϴ�."& vbCrlf & vbCrlf
				msg = msg & "��û�Ͻ� ä���� ���� �� ���� URL ���� �ȳ� �帳�ϴ�."& vbCrlf & vbCrlf
				msg = msg & "�� ä���� ��û ����� : "&rs_ConsBizNm&""& vbCrlf
				msg = msg & "�� ȭ�� ä���� �Ͻ� : "&rs_ConsReqDt&rs_ConsReqYoil&" "&rs_ConsReqTm&""& vbCrlf
				msg = msg & "�� URL : "&rs_ConsOntactUrl_Guest&""& vbCrlf & vbCrlf
				msg = msg & "�� ȭ�� ä���� ���񽺴� ũ��(Chrome) �������� �������� ��쿡�� �̿� �����մϴ�."& vbCrlf	 & vbCrlf	
				msg = msg & "�� �ȵ���̵� ��� �޴������� ȭ�� ä���� ��ũ�� �������� �� �������� ���� �ȳ� ���� �߻� �� �Ʒ� ������ ���� �⺻ ������ ������ ������ �ּ���."& vbCrlf
				msg = msg & "�� Androidȯ�� ��⿡ ���� ���� �� �� ���� ����� ����Ͽ� Google ������ ã���ϴ�."& vbCrlf
				msg = msg & "�� ����� ���� ���� ���ϴ�."& vbCrlf
				msg = msg & "�� ���ø����̼� ������ �����ϴ�.(LG���� ��� �Ϲ�> �� �� ����)"& vbCrlf
				msg = msg & "�� �⺻ ���� ���մϴ�."& vbCrlf
				msg = msg & "�� ������ ���� ���մϴ�."& vbCrlf
				msg = msg & "�� Chrome�� ���մϴ�."& vbCrlf & vbCrlf				
				msg = msg & "�� �ش� URL�� ä���� ���Ͽ� ���Ͽ� ���� ���Ǵ� ��û�Ͻ� ���ڿ� �ð��� ���� ���� �ٶ��ϴ�."& vbCrlf
				msg = msg & "�� ũ���� ������ ���ͳ��ͽ��÷η�(IE) ���� ������������ ȭ�� ä���� ���񽺰� �������� �ʽ��ϴ�."& vbCrlf
				msg = msg & "�� PC/�޴����� ����Ͽ� ȭ�� ä���㿡 ���� �����ϸ�, ȸ�� ���� �� �����Ͻ� ���� �ּҷε� �ȳ� ������ �߼۵Ǿ����� PC�� ȭ�� ä���� �濡 ���� �� �����Ͻø� �˴ϴ�."& vbCrlf
				msg = msg & "�� ��Ȱ�� ������ ���� ȭ�� ä���� ���� �� ���� �޴����� ī�޶�, ����Ŀ, ����ũ�� ���� �۵��Ǵ��� üũ�� �ּ���."& vbCrlf
				msg = msg & "�� �޴������� ȭ�� ä���㿡 ������ ��� ȭ���� ���η� �Ͽ� ���� �ٶ��ϴ�."& vbCrlf & vbCrlf

				Set Rs = Server.CreateObject("ADODB.RecordSet")
				strSql = "select max(CMP_MSG_ID) as cmid from arreo_sms where not (left(CMP_MSG_ID, 5) = 'ALARM') "
				Rs.Open strSql, DBCon2, 0, 1
				If Not (Rs.BOF Or Rs.EOF) Then
					smsid = rs("cmid") + 1

					sql2 = "insert into arreo_sms (CMP_MSG_ID, CMP_USR_ID, ODR_FG, SMS_GB, USED_CD, MSG_GB, WRT_DTTM, SND_DTTM, SND_PHN_ID, RCV_PHN_ID, CALLBACK, SUBJECT, SND_MSG, EXPIRE_VAL, SMS_ST, RSLT_VAL, RSRVD_ID, RSRVD_WD)" &_
							" values ('" & smsid & "', '00000', '2', '1', '00', 'M', '" & now_time & "', '" & now_time & "', 'daumhr', '" & Replace(Replace(rs_ConsReqPhone, " ", ""),"-","") & "', '0220066131', '�����ڵ����׷� ���»� ����ä�� ���� ���ȳ�', '" & msg & "', 0, '0', 99,'','');"
					DBCon2.Execute(sql2)
				End If
				Rs.Close

			DisconnectDB DBCon2

		End If
		
		If (isnull(rs_ConsReqMail) = false) Then
		
			'2-3) ���� �߼�
			Dim mailForm, iConf, mailer
			mailForm = "<html>"&_
			"<head>"&_
			"<title>"& site_name &"</title>"&_
			"<meta content=""text/html; charset=euc-kr"" http-equiv=""Content-Type"" />"&_
			"<meta http-equiv=""X-UA-Compatible"" content=""IE=Edge"">"&_
			"</head>"&_
			"<body style=""text-align: center; padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font-family: Dotum, '����', Times New Roman, sans-serif; background: #ffffff; color: #666; font-size: 12px; padding-top: 0px"">"&_
			"<table border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"" style=""width:838px;border:solid 1px #e4e4e4; border-top:0 none; border-bottom:0 none;table-layout: fixed;"">"&_
				"<colgroup>"&_
					"<col style=""width:20px;"">"&_
					"<col style=""width:699px;"">"&_
					"<col style=""width:20px;"">"&_
				"</colgroup>"&_
				"<tbody>"&_
					"<tr>"&_
						"<td style=""width:20px;""></td>"&_
						"<td style=""width:798px;padding:20px 0;border-collapse: inherit;background:#f0f0f0;border:1px dashed #c10e2c;text-align:center;"">"&_
							"<p style=""font-size:20px;line-height:1.8;letter-spacing: -1px;color:#000;"">"&_
								"�ȳ��ϼ���. "&site_short_name&" � �繫�� �Դϴ�.<br>"&_
								"<strong>��û�Ͻ� ä���� ���� �� ���� URL ���� �ȳ� �帳�ϴ�.</strong><br>"&_
							"</p>"&_
							"<table border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">"&_
								"<colgroup>"&_
									"<col style=""width:35%;"">"&_
									"<col style=""width:65%;"">"&_
								"</colgroup>"&_
								"<tbody>"&_
									"<tr>"&_
										"<th style=""width:30%;padding:20px;vertical-align:top;font-size:17px;text-align:right;"">On-tact ä���� ��û �����</th>"&_
										"<td style=""width:70%;padding:20px 0;vertical-align:top;font-size:17px;"">" & rs_ConsBizNm & "</td>"&_
									"</tr>"&_
									"<tr>"&_
										"<th style=""width:30%;padding:20px;vertical-align:top;font-size:17px;text-align:right;"">On-tact ä���� �Ͻ�</th>"&_
										"<td style=""width:70%;padding:20px 0;vertical-align:top;font-size:17px;"">" & rs_ConsReqDt&rs_ConsReqYoil & " " & rs_ConsReqTm & "</td>"&_
									"</tr>"&_
									"<tr>"&_
										"<th style=""width:30%;padding:20px;vertical-align:top;font-size:17px;text-align:right;"">On-tact ä���� �ּ�</th>"&_
										"<td style=""width:70%;padding:20px 0;vertical-align:top;font-size:17px;"">"&_
											"<a href=""" & rs_ConsOntactUrl_Guest & """ target=""_blank"">�ٷΰ���</a>"&_
											"<br><br>" & rs_ConsOntactUrl_Guest & "</td>"&_
									"</tr>"&_
									"<tr>"&_
										"<td colspan=""2"" style=""padding:20px 20px 0 30px;"">"&_
											"<p style=""font-size:15px;line-height:1.5;letter-spacing:0;color:#000;text-align:left;"">"&_
												"�� On-tact ä���� �ּҴ� ��� ���Ͽ� ���Ͽ� ������ ���˴ϴ�. ä�����Ͻø� Ȯ���ϰ� �ð���<br>&nbsp;&nbsp;&nbsp;���� ������ �ּ���.<br>"&_
												"�� ���� �� On-tact ä���� �ַ�ǿ��� ���� ����� ī�޶�, ����Ŀ, ����ũ�� ���� �۵��ϴ���<br>&nbsp;&nbsp;&nbsp;������ �̸� ������ �ּ���.<br>"&_
												"�� ���ͳ� �ͽ��÷η�(IE)������ On-tact ä���� ���񽺰� �������� �ʽ��ϴ�.<br>&nbsp;&nbsp;&nbsp;�ַ���� ����ȭ �� Chrome(ũ��)�� ���ؼ� ������ �ּ���."&_
											"</p>"&_
										"</td>"&_
									"</tr>"&_
									"<tr>"&_
										"<td colspan=""2"" style=""padding:20px 20px 0 20px;text-align:right;"">"&_
											"<a href=""https://www.google.com/intl/ko/chrome/"" target=""_blank"">Chrome �ٿ�ε�</a>&nbsp;"&_
											"<a href=""https://hmgpartnerjob.career.co.kr/board/notice_view.asp?seq=10"" target=""_blank"">Chrome�� �⺻ �������� �����ϴ� ���</a>"&_
										"</td>"&_
									"</tr>"&_
								"</tbody>"&_
							"</table>"&_
						"</td>"&_
						"<td style=""width:20px;""></td>"&_
					"</tr>"&_
				"</tbody>"&_
			"</table>"&_
			"</body>"&_
			"</html>"

			Set mailer	= Server.CreateObject("CDO.Message")
			Set iConf	= mailer.Configuration
			With iConf.Fields
			.item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
			.item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "C:\inetpub\mailroot\Pickup"
			.item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "127.0.0.1"
			.item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
			.update
			End With 

			mailer.From = "expo@career.co.kr"
			mailer.To	= rs_ConsReqMail
			mailer.Subject	= "["&site_name&"] ȭ������ �����ϴ� ���»� ä���� ���� �ȳ� �帳�ϴ�."
			mailer.HTMLBody	= mailForm
			mailer.BodyPart.Charset="ks_c_5601-1987"
			mailer.HTMLBodyPart.Charset="ks_c_5601-1987"
			mailer.Send
			Set mailer = Nothing
	
		End If

	End If 
%>
<script>
	var rtn = "<%=rtn%>";
	if (rtn == "O") {
		alert("ä���� ��û�� �Ϸ�Ǿ����ϴ�.\nȸ������ �� ����� �޴����� �����ּҷ� ������� �ȳ� �޽����� �߼۵Ǿ����� Ȯ�� �ٶ��ϴ�.");
	}else if (rtn == "N"){	
		alert("�ش� ����� ä������ ��û�� �̷��� �����մϴ�.\nä������ ��� �� 1ȸ�� ��û�� �����ϴ� �ٸ� �������\n�ٽ� ������ �ּ���.");	
	}else if (rtn == "C"){
		alert("�̹� �ش� ����/�ð��� �������� ��û�� �̷��� �����մϴ�.\n�ٸ� ���ڷ� ��û�� �ּ���.");			
	}else{
		alert("�����Ͻ� ����/�ð����� �ش� ��� ������ ��û�� �����Ǿ����ϴ�.\n�ٸ� ���ڷ� ��û�� �ּ���.");						
	}
	location.href = "/jobs/consult_list.asp";
</script>