<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	Dim consultant_id, consultant_day, consultant_time, rtn
	consultant_id	= Request("set_interview_id")
	consultant_day	= Request("set_interview_day")
	consultant_time	= Request("set_interview_time")


	'1) 협력사 취업상담 신청 관리 테이블에 정보 저장
	ConnectDB DBCon, Application("DBInfo_FAIR")
	
	ReDim Param(5)
	Param(0) = makeparam("@CONSULTANT_ID", adVarChar, adParamInput, 20, consultant_id)
	Param(1) = makeparam("@CONSULTANT_DAY", adVarChar, adParamInput, 10, consultant_day)
	Param(2) = makeparam("@CONSULTANT_TIME", adVarChar, adParamInput, 2, consultant_time)
	Param(3) = makeparam("@USER_ID", adVarChar, adParamInput, 20, user_id)
	Param(4) = makeParam("@RTN", adChar, adParamOutput, 1, "")
	Param(5) = makeParam("@SEQ", adInteger, adParamOutput, 4, "")
	
	Call execSP(DBCon, "USP_채용상담_신청", Param, "", "")
	rtn		= getParamOutputValue(Param, "@RTN")
	cs_Seq	= getParamOutputValue(Param, "@SEQ")

	DisconnectDB DBCon


	'2) 신청정보 DB 저장 성공 시 안내 문자/메일 발송
	If rtn="O" Then ' 리턴 구분자 - O: 성공, N: 같은 기업 중복 신청, C: 같은 일시 중복 신청, X: 신청 마감		

		'2-1) 컨설팅 신청 정보 추출
	ConnectDB DBCon, Application("DBInfo_FAIR")
		
		spName2 = "usp_채용상담_개인_신청정보조회"
		ReDim param2(2)
		Param2(0) = makeparam("@CONS_REQ_SEQ",		adInteger, adParamInput, 4, cs_Seq)
		Param2(1) = makeparam("@CONSULTANT_DAY",	adVarChar, adParamInput, 10, consultant_day)
		Param2(2) = makeparam("@CONSULTANT_TIME",	adVarChar, adParamInput, 2, consultant_time)

		arrRs = arrGetRsSP(DBCon, spName2, param2, "", "")
		If isArray(arrRs) Then 
			rs_ConsReqNm			= arrRs(0, 0)	' 신청자명
			rs_ConsReqPhone			= arrRs(1, 0)	' 신청자 휴대폰번호
			rs_ConsReqMail			= arrRs(2, 0)	' 신청자 메일주소
			rs_ConsReqDt			= arrRs(3, 0)	' 상담일자
			rs_ConsReqYoil			= arrRs(4, 0)	' 상담요일
			rs_ConsReqTm			= arrRs(5, 0)	' 상담시간대
			rs_ConsOntactUrlCd		= arrRs(6, 0)	' 상담URL코드
			rs_ConsOntactUrl_Guest	= arrRs(7, 0)	' 화상 채용상담 입장 신청자 URL
			rs_ConsBizId			= arrRs(8, 0)	' 화상 채용상담 회사아이디
			rs_ConsBizNm			= arrRs(9, 0)	' 화상 채용상담 회사명
		End If 
		
		rs_ConsReqTm = rs_ConsReqTm&" (25분)"

	DisconnectDB DBCon
		
		' 신청자 휴대폰,메일이 있어야 안내 문자/메일이 나갈수 있음
		If (isnull(rs_ConsReqPhone) = false) Then
		
			'2-2) 문자 발송
			ConnectDB DBCon2, Application("DBInfo_etc")

				Dim now_time, msg, strSql, smsid
				now_time = year(now) & Right("0"&month(now),2) & Right("0"&day(now),2) & Right("0"&hour(now),2) & Right("0"&minute(now),2) & Right("0"&second(now),2)
				
				msg = "안녕하세요 "&site_short_name&" 운영 사무국 입니다."& vbCrlf & vbCrlf
				msg = msg & "신청하신 채용상담 일정 및 참여 URL 정보 안내 드립니다."& vbCrlf & vbCrlf
				msg = msg & "■ 채용상담 신청 기업명 : "&rs_ConsBizNm&""& vbCrlf
				msg = msg & "■ 화상 채용상담 일시 : "&rs_ConsReqDt&rs_ConsReqYoil&" "&rs_ConsReqTm&""& vbCrlf
				msg = msg & "■ URL : "&rs_ConsOntactUrl_Guest&""& vbCrlf & vbCrlf
				msg = msg & "※ 화상 채용상담 서비스는 크롬(Chrome) 브라우저로 접속했을 경우에만 이용 가능합니다."& vbCrlf	 & vbCrlf	
				msg = msg & "※ 안드로이드 기반 휴대폰에서 화상 채용상담 링크로 접속했을 때 보안인증 관련 안내 문구 발생 시 아래 순서를 따라 기본 브라우저 설정을 변경해 주세요."& vbCrlf
				msg = msg & "▶ Android환경 기기에 따라 다음 중 한 가지 방법을 사용하여 Google 설정을 찾습니다."& vbCrlf
				msg = msg & "① 기기의 설정 앱을 엽니다."& vbCrlf
				msg = msg & "② 애플리케이션 관리를 누릅니다.(LG폰일 경우 일반> 앱 및 관리)"& vbCrlf
				msg = msg & "③ 기본 앱을 탭합니다."& vbCrlf
				msg = msg & "④ 브라우저 앱을 탭합니다."& vbCrlf
				msg = msg & "⑤ Chrome을 탭합니다."& vbCrlf & vbCrlf				
				msg = msg & "※ 해당 URL은 채용상담 당일에 한하여 접속 허용되니 신청하신 일자와 시간에 맞춰 입장 바랍니다."& vbCrlf
				msg = msg & "※ 크롬을 제외한 인터넷익스플로러(IE) 등의 브라우저에서는 화상 채용상담 서비스가 지원되지 않습니다."& vbCrlf
				msg = msg & "※ PC/휴대폰을 사용하여 화상 채용상담에 참여 가능하며, 회원 가입 시 기재하신 메일 주소로도 안내 메일이 발송되었으니 PC로 화상 채용상담 방에 입장 시 참고하시면 됩니다."& vbCrlf
				msg = msg & "※ 원활한 진행을 위해 화상 채용상담 참여 전 접속 휴대폰의 카메라, 스피커, 마이크가 정상 작동되는지 체크해 주세요."& vbCrlf
				msg = msg & "※ 휴대폰으로 화상 채용상담에 참여할 경우 화면을 가로로 하여 접속 바랍니다."& vbCrlf & vbCrlf

				Set Rs = Server.CreateObject("ADODB.RecordSet")
				strSql = "select max(CMP_MSG_ID) as cmid from arreo_sms where not (left(CMP_MSG_ID, 5) = 'ALARM') "
				Rs.Open strSql, DBCon2, 0, 1
				If Not (Rs.BOF Or Rs.EOF) Then
					smsid = rs("cmid") + 1

					sql2 = "insert into arreo_sms (CMP_MSG_ID, CMP_USR_ID, ODR_FG, SMS_GB, USED_CD, MSG_GB, WRT_DTTM, SND_DTTM, SND_PHN_ID, RCV_PHN_ID, CALLBACK, SUBJECT, SND_MSG, EXPIRE_VAL, SMS_ST, RSLT_VAL, RSRVD_ID, RSRVD_WD)" &_
							" values ('" & smsid & "', '00000', '2', '1', '00', 'M', '" & now_time & "', '" & now_time & "', 'daumhr', '" & Replace(Replace(rs_ConsReqPhone, " ", ""),"-","") & "', '0220066131', '현대자동차그룹 협력사 수시채용 마당 상담안내', '" & msg & "', 0, '0', 99,'','');"
					DBCon2.Execute(sql2)
				End If
				Rs.Close

			DisconnectDB DBCon2

		End If
		
		If (isnull(rs_ConsReqMail) = false) Then
		
			'2-3) 메일 발송
			Dim mailForm, iConf, mailer
			mailForm = "<html>"&_
			"<head>"&_
			"<title>"& site_name &"</title>"&_
			"<meta content=""text/html; charset=euc-kr"" http-equiv=""Content-Type"" />"&_
			"<meta http-equiv=""X-UA-Compatible"" content=""IE=Edge"">"&_
			"</head>"&_
			"<body style=""text-align: center; padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font-family: Dotum, '돋움', Times New Roman, sans-serif; background: #ffffff; color: #666; font-size: 12px; padding-top: 0px"">"&_
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
								"안녕하세요. "&site_short_name&" 운영 사무국 입니다.<br>"&_
								"<strong>신청하신 채용상담 일정 및 참여 URL 정보 안내 드립니다.</strong><br>"&_
							"</p>"&_
							"<table border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">"&_
								"<colgroup>"&_
									"<col style=""width:35%;"">"&_
									"<col style=""width:65%;"">"&_
								"</colgroup>"&_
								"<tbody>"&_
									"<tr>"&_
										"<th style=""width:30%;padding:20px;vertical-align:top;font-size:17px;text-align:right;"">On-tact 채용상담 신청 기업명</th>"&_
										"<td style=""width:70%;padding:20px 0;vertical-align:top;font-size:17px;"">" & rs_ConsBizNm & "</td>"&_
									"</tr>"&_
									"<tr>"&_
										"<th style=""width:30%;padding:20px;vertical-align:top;font-size:17px;text-align:right;"">On-tact 채용상담 일시</th>"&_
										"<td style=""width:70%;padding:20px 0;vertical-align:top;font-size:17px;"">" & rs_ConsReqDt&rs_ConsReqYoil & " " & rs_ConsReqTm & "</td>"&_
									"</tr>"&_
									"<tr>"&_
										"<th style=""width:30%;padding:20px;vertical-align:top;font-size:17px;text-align:right;"">On-tact 채용상담 주소</th>"&_
										"<td style=""width:70%;padding:20px 0;vertical-align:top;font-size:17px;"">"&_
											"<a href=""" & rs_ConsOntactUrl_Guest & """ target=""_blank"">바로가기</a>"&_
											"<br><br>" & rs_ConsOntactUrl_Guest & "</td>"&_
									"</tr>"&_
									"<tr>"&_
										"<td colspan=""2"" style=""padding:20px 20px 0 30px;"">"&_
											"<p style=""font-size:15px;line-height:1.5;letter-spacing:0;color:#000;text-align:left;"">"&_
												"※ On-tact 채용상담 주소는 상담 당일에 한하여 접속이 허용됩니다. 채용상담일시를 확인하고 시간에<br>&nbsp;&nbsp;&nbsp;맞춰 입장해 주세요.<br>"&_
												"※ 입장 시 On-tact 채용상담 솔루션에서 접속 기기의 카메라, 스피커, 마이크가 정상 작동하는지<br>&nbsp;&nbsp;&nbsp;사전에 미리 점검해 주세요.<br>"&_
												"※ 인터넷 익스플로러(IE)에서는 On-tact 채용상담 서비스가 지원되지 않습니다.<br>&nbsp;&nbsp;&nbsp;솔루션이 최적화 된 Chrome(크롬)을 통해서 접속해 주세요."&_
											"</p>"&_
										"</td>"&_
									"</tr>"&_
									"<tr>"&_
										"<td colspan=""2"" style=""padding:20px 20px 0 20px;text-align:right;"">"&_
											"<a href=""https://www.google.com/intl/ko/chrome/"" target=""_blank"">Chrome 다운로드</a>&nbsp;"&_
											"<a href=""https://hmgpartnerjob.career.co.kr/board/notice_view.asp?seq=10"" target=""_blank"">Chrome을 기본 브라우저로 설정하는 방법</a>"&_
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
			mailer.Subject	= "["&site_name&"] 화상으로 진행하는 협력사 채용상담 일정 안내 드립니다."
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
		alert("채용상담 신청이 완료되었습니다.\n회원가입 시 등록한 휴대폰과 메일주소로 상담일정 안내 메시지가 발송되었으니 확인 바랍니다.");
	}else if (rtn == "N"){	
		alert("해당 기업에 채용상담을 신청한 이력이 존재합니다.\n채용상담은 기업 당 1회만 신청이 가능하니 다른 기업으로\n다시 선택해 주세요.");	
	}else if (rtn == "C"){
		alert("이미 해당 일자/시간에 취업상담을 신청한 이력이 존재합니다.\n다른 일자로 신청해 주세요.");			
	}else{
		alert("선택하신 일자/시간대의 해당 기업 취업상담 신청이 마감되었습니다.\n다른 일자로 신청해 주세요.");						
	}
	location.href = "/jobs/consult_list.asp";
</script>