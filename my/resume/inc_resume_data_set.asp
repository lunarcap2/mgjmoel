<%
'프로필
Dim p_birth, p_birthYY, p_birthMM, p_birthDD, p_jumin_code, p_phone, p_phone1, p_phone2, p_phone3, p_email, p_email1, p_email2, p_userName, p_address, p_userPhoto, p_userPhotoURL, p_resumeTitle, p_selfIntro, p_gender, p_age
Dim p_imgbtn : p_imgbtn = "사진 등록"
Dim p_headertit	: p_headertit = "이력서 등록"

If isArray(arrComm) Then
	'이력서 공통정보
	p_userName		= arrComm(0, 0)								'이름
	p_phone			= arrComm(8, 0)								'휴대폰
	p_email			= arrComm(10, 0)							'이메일
	p_address		= arrComm(13, 0)							'주소
	p_userPhoto		= arrComm(19, 0)							'사진
	p_birthYY		= arrComm(1, 0)								'주민년
	p_birthMM		= arrComm(2, 0)								'주민월
	p_birthDD		= arrComm(3, 0)								'주민일
	p_jumin_code	= arrComm(4, 0)								'성별
Else
	'개인회원정보
	p_userName		= arrUser(0, 0)								'이름
	p_phone			= arrUser(7, 0)								'휴대폰
	p_email			= arrUser(8, 0)								'이메일
	p_address		= arrUser(10, 0)							'주소
	p_userPhoto		= arrUser(11, 0)							'사진
	p_birthYY		= Left(arrUser(1,0),2)						'주민년
	p_birthMM		= Mid(arrUser(1,0),3,2)						'주민월
	p_birthDD		= Right(arrUser(1,0),2)						'주민일
	p_jumin_code	= arrUser(2,0)								'성별
End If

'사진
If p_userPhoto <> "" Then
	Dim strDT : strDT = Year(Now()) & Month(Now()) & Day(Now()) & Hour(Now()) & Minute(Now()) & Second(Now())

	p_userPhotoURL	= "http://www2.career.co.kr/hdrive/fair/mypic/" & p_userPhoto & "?" & strDT
	p_imgbtn		= "사진수정"
Else
	p_userPhoto = ""
End If

'이메일
If p_email <> "" Then
	p_email1	= Split(p_email, "@")(0)
	p_email2	= Split(p_email, "@")(1)
End If

'휴대폰
If p_phone <> "" Then
	p_phone1	= Split(p_phone, "-")(0)
	p_phone2	= Split(p_phone, "-")(1)
	p_phone3	= Split(p_phone, "-")(2)
End If

If p_jumin_code <> "" Then
	'성별
	If p_jumin_code = "1" Or p_jumin_code = "3" Then
		p_gender = "남"
	ElseIf p_jumin_code = "2" Or p_jumin_code = "4" Then
		p_gender = "여"
	End If
	
	'나이
	If p_jumin_code = "1" Or p_jumin_code = "2" Then
		p_birthYY	= "19" & p_birthYY
	Else 
		p_birthYY = "20" & p_birthYY
	End If

	p_age	= year(date) - p_birthYY +1 & "세"
	p_birth	= p_birthYY & "." & p_birthMM & "." & p_birthDD
End If

If isArray(arrResume) Then
	If rid <> 0 Then p_resumeTitle = arrResume(2, 0)
	p_selfIntro = arrResume(32, 0)
	p_headertit	= "이력서 수정"
End If

'학력
Dim final_school
If isArray(arrResume) And isArray(arrSchool) Then
	For i=0 To UBound(arrSchool,2)
		If arrSchool(2,i) = arrResume(7,0) Then
			Dim univ_etype_nm
			Select Case arrSchool(12, i)
				Case "3" : univ_etype_nm = "재학"
				Case "4" : univ_etype_nm = "휴학"
				Case "5" : univ_etype_nm = "중퇴"
				Case "7" : univ_etype_nm = "졸업(예)"
				Case "8" : univ_etype_nm = "졸업"
			End Select

			final_school = arrSchool(3,i) & " " & univ_etype_nm
		End If
	Next
Else
	final_school = "입력된 내용이 없습니다."
End If

'경력
Dim total_career
If IsArray(arrResume) Then
	Dim total_career_YY, total_career_MM
	If arrResume(11,0) = 0 Then
		total_career = "신입"
	Else
		total_career = career_month(arrResume(11,0))
	End If
Else
	total_career = "입력된 내용이 없습니다."
End If

'인턴.대외활동
Dim lately_activity
If isArray(arrActivity) Then
	Dim activity_sMM, activity_eMM, activity_sDT, activity_eDT, activity_term
	If Len(arrActivity(4,0)) = 1 Then
		activity_sMM = "0" & arrActivity(4,0)
	Else
		activity_sMM = arrActivity(4,0)
	End If

	If Len(arrActivity(6,0)) = 1 Then
		activity_eMM = "0" & arrActivity(6,0)
	Else
		activity_eMM = arrActivity(6,0)
	End If
	
	activity_sDT = arrActivity(3,0) & "-" & activity_sMM
	activity_eDT = arrActivity(5,0) & "-" & activity_eMM

	activity_term = career_month(DateDiff("m", activity_sDT, activity_eDT))

	lately_activity = arrActivity(7,0) & " " & activity_term
Else
	lately_activity = "입력된 내용이 없습니다."
End If


'외국어
Dim kind_language
If isArray(arrLanguageUse) Or isArray(arrLanguageExam) Then
	If isArray(arrLanguageUse) Then
		kind_language = "회화능력"
	End If

	If isArray(arrLanguageExam) Then
		If kind_language <> "" Then
			kind_language = kind_language & comma & "공인시험"
		Else
			kind_language = "공인시험"
		End If
	End If
Else
	kind_language = "입력된 내용이 없습니다."
End If

'해외경험
Dim lately_overseas
If isArray(arrAbroad) Then
	lately_overseas = getNationCodeTxt(arrAbroad(1,0))
Else
	lately_overseas = "입력된 내용이 없습니다."
End If

'자기소개서
Dim introduce_cnt
If isArray(arrNew_Essay) Then
	introduce_cnt = UBound(arrNew_Essay,2)+1 & "개 항목"
Else
	introduce_cnt = "입력된 내용이 없습니다."
End If

'희망근무조건
Dim desire_cnt
If isArray(arrResume) Then
	'희망연봉
	Dim salary_amt_yn : salary_amt_yn = arrResume(10, 0)
	'희망직무
	Dim jc_yn : jc_yn = arrResume(28, 0)
	'희망산업
	Dim ct_yn : ct_yn = arrResume(29, 0)

	If salary_amt_yn <> "" Then
		desire_cnt = desire_cnt + 1
	End If

	If jc_yn <> "" Then
		desire_cnt = desire_cnt + 1
	End If

	If ct_yn <> "" Then
		desire_cnt = desire_cnt + 1
	End If
End If
If isArray(arrWorkType) Then
	desire_cnt = desire_cnt + UBound(arrWorkType,2)+1
End If
If isArray(arrArea) Then
	desire_cnt = desire_cnt + 1
End If
If desire_cnt = "" Then
	desire_cnt = "입력된 내용이 없습니다."
Else
	desire_cnt = desire_cnt & "개"
End If

'자격증
Dim license_cnt
If isArray(arrLicense) Then
	license_cnt = UBound(arrLicense,2)+1 & "개"
Else
	license_cnt = "입력된 내용이 없습니다."
End If

'수상
Dim awards_cnt
If isArray(arrPrize) Then
	awards_cnt = UBound(arrPrize,2)+1 & "개"
Else
	awards_cnt = "입력된 내용이 없습니다."
End If

'교육
Dim education_cnt
If isArray(arrAcademy) Then
	education_cnt = UBound(arrAcademy,2)+1 & "개"
Else
	education_cnt = "입력된 내용이 없습니다."
End If

'포트폴리오
Dim portfolio_cnt
If isArray(arrPortfolio) Then
	portfolio_cnt = UBound(arrPortfolio,2)+1 & "개"
Else
	portfolio_cnt = "입력된 내용이 없습니다."
End If

'취업우대항목
Dim preferential_cnt
If isArray(arrPersonal) Then
	'보훈
	Dim patriotYN : patriotYN = arrPersonal(0,0)
	'장애
	Dim handicapYN : handicapYN = arrPersonal(1,0)
	'취업보호
	Dim protectYN : protectYN = arrPersonal(5,0)
	
	If patriotYN = "1" Then
		preferential_cnt = preferential_cnt + CInt(patriotYN)
	End If

	If handicapYN = "1" Then
		preferential_cnt = preferential_cnt + CInt(handicapYN)
	End If

	If protectYN = "1" Then
		preferential_cnt = preferential_cnt + CInt(protectYN)
	End If
End If
If isArray(arrMilitary) Then
	preferential_cnt = preferential_cnt + (UBound(arrMilitary,2)+1)
End If
If isArray(arrEmpSupport) Then
	Dim EmpSupportYN : EmpSupportYN = arrEmpSupport(0,0)

	If EmpSupportYN = "1" Then
		preferential_cnt = preferential_cnt + CInt(EmpSupportYN)
	End If
	
	preferential_cnt = preferential_cnt
End If
If preferential_cnt = "" Then
	preferential_cnt = "입력된 내용이 없습니다."
Else
	preferential_cnt = preferential_cnt & "개"
End If
%>