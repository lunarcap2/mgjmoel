<%@  codepage="949" language="VBScript" %>

<%
	Option Explicit
	Session.CodePage = 949
	Response.ChaRset = "EUC-KR"


	Dim jid : jid = Request("jid")			' ä��������Ϲ�ȣ
	Dim rid : rid = Request("rid")			' �̷¼���Ϲ�ȣ
	Dim applyno								' �Ի�������ȣ
	
	'***** �ùٸ��� ���� ������ȣ
	If jid = "" or isNumeric(jid) = false Then
		response.write "<html><head></head><body><script type='text/javascript'>" & vbcrlf &_
						"	alert('�����ȣ�� �ùٸ��� �ʽ��ϴ�.');" & vbcrlf &_
						"	parent.$('div#applyWrap').css('display','none');" & vbcrlf &_
						"</script></body></html>" & vbcrlf
		response.end
	end if

	dim sqlstr, sp_name, i, arrAppData
	Dim l_title : l_title = Request.Form("input_title")					' ��������
	Dim l_name : l_name = Request.Form("l_name")						' �����ڸ�
	Dim l_year : l_year = Request("birth_year")							' ������ ����
	dim l_month : l_month = strfix(request.form("birth_month"),"varchar","-")
	dim l_day : l_day = strfix(request.form("birth_day"),"varchar","-")
	Dim l_tel : l_tel = Request.Form("l_tel")							' ��ȭ��ȣ
	dim phone1 : phone1 = request.form("phone1")						' ��ȭ��ȣ (��ȸ��)
	dim phone2 : phone2 = request.form("phone2")						' ��ȭ��ȣ (��ȸ��)
	dim phone3 : phone3 = request.form("phone3")						' ��ȭ��ȣ (��ȸ��)
	' if phone1 <> "" and phone2 <> "" and phone3 <> "" then
		l_tel = phone1 & "-" & phone2 & "-" & phone3
	' end if
	dim phone_flag : phone_flag = strfix(request.form("phone_flag"),"varchar","1")			' ��ȭ��ȣ ����
	
	Dim l_year2 : l_year2 = l_year '// 2014-12-22

	l_year = right(l_year,2)
	
	Dim l_hp : l_hp = Request.Form("l_hp")								' �޴�����ȣ
	dim user_cell1 : user_cell1 = request.form("user_cell1")			' �޴�����ȣ (��ȸ��)
	dim user_cell2 : user_cell2 = request.form("user_cell2")			' �޴�����ȣ (��ȸ��)
	dim user_cell3 : user_cell3 = request.form("user_cell3")			' �޴�����ȣ (��ȸ��)
	if user_cell1 <> "" and user_cell2 <> "" and user_cell3 <> "" then
		l_hp = user_cell1 & "-" & user_cell2 & "-" & user_cell3
	end if
	dim user_cell_flag : user_cell_flag = strfix(request.form("user_cell_flag"),"varchar","1")	' �޴�����ȣ ����
	
	Dim l_email : l_email = request.form("l_email")						' �̸���
	dim email1 : email1 = request.form("email1")						' �̸��� (�Է�)
	dim email2 : email2 = request.form("email2")						' �̸��� (�Է�)
	if email1 <> "" and email2 <> "" then
		l_email = email1 & "@" & email2
	end if
	dim email_flag : email_flag = strfix(request.form("email_flag"),"varchar","1")			' �̸��� ����
	
	dim l_gender : l_gender = request.form("gender")					' ����
	dim l_sex : l_sex = request.form("l_sex")							' ���� (��ȸ��)
	if l_gender = "" then	l_gender = l_sex
	
	dim final_school : final_school = request.form("final_school")		' �����з��ڵ�
	dim exp_flag : exp_flag = strfix(request.form("experience_flag"),"varchar","1")		' ��¿���
	dim exp_year : exp_year = strfix(request.form("experience_year"),"int",0)			' ��±Ⱓ ��
	dim exp_month : exp_month = strfix(request.form("experience_month"),"int",0)		' ��±Ⱓ ��
	dim addcomment : addcomment = request.form("addcomment")			' ���޳���
	if addcomment = "" then	addcomment = "-"

	dim l_company_id : l_company_id = Request.Form("company_id")
	dim l_company_name : l_company_name = Request.Form("company_name")


	'Dim fnm
	Dim guin_title : guin_title = Request.Form("guin_title")
	Dim p_salary
	Dim new_salary : new_salary = Request.Form("new_salary")	' �������
	Dim mailme : mailme = Request.Form("mailme")				' ���Ϲ߼ۿ��� (�⺻ Y)
	Dim mojip : mojip = Request.Form("mojip")					' �����о�
	dim filelist : filelist = request.form("filelist")

	dim appnomem : appnomem = request.form("appnomem")
	dim appmethod : appmethod = request.form("appmethod")
	dim appformtype : appformtype = request.form("appformtype")

	dim onlienemail_chk : onlienemail_chk  = request.Form("onlienemail_chk")
	dim rs_resumegb : rs_resumegb = "" ' �����̷¼� ���� 'F' 2017-08-03 YYS
	

	'// ������ �̷¼� ���� ÷�θ� �Ұ�����
	dim rq_profile_file_chk : rq_profile_file_chk = request.form("profile_file_chk")

	dim ansnum(4)	' ������������ ��ȣ
	dim answer(4)	' ������������ �� (�ִ� 5��)
	for i=0 to 4
		ansnum(i) = request.form("ansnum_"&i)
		answer(i) = request.form("answer_"&i)	'replace(request.form("answer_"&i), "'", "''")
	next

	Dim k_month					'�̷¼� ��¿���
	Dim e_title					'�̷¼� Ÿ��Ʋ
	Dim resume_final_school		'�̷¼� �����з�
	Dim resume_email_addr		'�̷¼� ���ڿ���
	Dim resume_address			'�̷¼� �ּ�
	dim certifi					'����
	dim resume_salary			'�̷¼� ��������ڵ�
	
	dim l_contact : l_contact = request.form("l_contact") ' ��ȭ���ɽð�

	dim use_gubun
	if mailme = "Y" then
		use_gubun = "MAILME"
	else
		use_gubun = "ONLINE"
	end If

	if not (appformtype="A" or appformtype="D") then	rid = ""
	
	if appnomem=false and user_id="" then
		response.write "<html><head></head><body><script type='text/javascript'>" & vbcrlf &_
						"	alert('ȸ�������� �ùٸ��� �ʽ��ϴ�.\n�ٽ� �α����� �ֽʽÿ�.');" & vbcrlf &_
						"	top.goLogin(1);" & vbcrlf &_
						"</script></body></html>" & vbcrlf
		response.end
	end if

    Dim l_rGubun            '�̷¼�����
%>
<!--#include virtual="/common/common.asp"-->
<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual="/wwwconf/function/common/base_util.asp"-->

<!--include virtual="/wwwconf/conf/job_site_info.asp"-->
<!--include virtual="/wwwconf2/code/code_function_resume.inc"-->
<!--include virtual="/wwwconf2/code/code_function.inc"-->
<!--include virtual="/wwwconf/code/code_function.asp"-->
<!--include virtual="/wwwconf/code/code_function_ac.asp"-->
<!--include virtual="/wwwconf/code/code_function_jc.asp"-->
<!--include virtual="/wwwconf/code/code_resume.asp"-->
<!--include virtual="/wwwconf/code/code_resume_foreign_ac.asp"-->
<!--include virtual="/wwwconf/function/resume_function.asp"-->
<!--include virtual="/wwwconf2/function/resume_function.inc"-->
<!--include virtual="/wwwconf/query_lib/user/ResumeInfo.asp"-->


<% if rid <> "" and (appformtype="A" or appformtype="D") then %>
<!--include virtual="/wwwconf/function/resume/getApplyMyResumeFileForm2014.asp"-->
<!--include virtual="/wwwconf/function/resume/getApplyMyEmailForm.asp"--> 
<!--include virtual="/wwwconf/include/user/resume/getResumeViewDBInfo2014.asp"-->

<!--include virtual="/wwwconf/function/resume/setResumeViewDataBind2014.asp"-->
<!--include virtual="/wwwconf/function/resume/getResumeEmailForm.asp"-->
<!--include virtual="/wwwconf/function/resume/getApplyCompanyOnlineForm.asp"-->
<!--include virtual="/wwwconf/function/resume/getApplyCompanyEmailForm.asp"-->
<!--include virtual="/wwwconf/function/resume/getApplyNoRegiCompanyForm.asp"--> 
<% end if %>

<!--#include virtual="/wwwconf/query_lib/user/MemberCertInfo.asp"-->

<%
	 g_debug = False


	'// ���������� �Ǿ����� �Ի������� �Ұ���ó��
	Dim strQuery, arrRsApplyCnt
	If (appformtype="A" Or appformtype="D") Then
		strQuery = ""
		strQuery = strQuery & " SELECT COUNT(A.��Ϲ�ȣ) AS CNT"
		strQuery = strQuery & " FROM ���ͳ��Ի����� AS A WITH(NOLOCK)"
		strQuery = strQuery & " INNER JOIN ������������ AS B WITH(NOLOCK)"
		strQuery = strQuery & " ON A.ä��������Ϲ�ȣ = B.ä���Ϲ�ȣ"
		strQuery = strQuery & " AND A.��Ϲ�ȣ = B.�Ի�������Ϲ�ȣ"
		strQuery = strQuery & " WHERE 1=1"
		strQuery = strQuery & " AND A.ä��������Ϲ�ȣ = ? "
		strQuery = strQuery & " AND A.���ξ��̵� = ? "
		strQuery = strQuery & " AND A.�̷¼���Ϲ�ȣ = ? "
		strQuery = strQuery & " AND ISNULL(����, '') <> '1'"

		ReDim parameter(2)
		parameter(0)	= makeParam("@ä���Ϲ�ȣ", adInteger, adParamInput, 4, jid)
		parameter(1)	= makeParam("@���ξ��̵�", adVarchar, adParamInput, 20, user_id)
		parameter(2)	= makeParam("@�̷¼���ȣ", adInteger, adParamInput, 4, rid)
	Else
		strQuery = ""
		strQuery = strQuery & " SELECT COUNT(A.��Ϲ�ȣ) AS CNT"
		strQuery = strQuery & " FROM ���ͳ��Ի����� AS A WITH(NOLOCK)"
		strQuery = strQuery & " INNER JOIN ������������ AS B WITH(NOLOCK)"
		strQuery = strQuery & " ON A.ä��������Ϲ�ȣ = B.ä���Ϲ�ȣ"
		strQuery = strQuery & " AND A.��Ϲ�ȣ = B.�Ի�������Ϲ�ȣ"
		strQuery = strQuery & " WHERE 1=1"
		strQuery = strQuery & " AND A.ä��������Ϲ�ȣ = ? "
		strQuery = strQuery & " AND A.���ξ��̵� = ? "
		strQuery = strQuery & " AND A.�̷¼���Ϲ�ȣ IS NULL "
		strQuery = strQuery & " AND ISNULL(����, '') <> '1'"

		ReDim parameter(1)
		parameter(0)	= makeParam("@ä���Ϲ�ȣ", adInteger, adParamInput, 4, jid)
		parameter(1)	= makeParam("@���ξ��̵�", adVarchar, adParamInput, 20, user_id)
	End If

	ConnectDB dbCon, Application("DBInfo_FAIR")
	arrRsApplyCnt = arrGetRsParam(dbCon, strQuery, parameter, "", "")(0, 0)
	DisconnectDB dbCon

	If CInt(arrRsApplyCnt) > 0 Then 
		Response.write "<script>alert('�ش������ ���������� �̹� �Ϸ�Ǿ� ������ �� �� �����ϴ�.'); history.back();</script>"
		Response.End 
	End If 


	'// 
	'// 2015-05-11
	'// ��ϼ��� 27, ȸ����̵� = '' ���ް��� ���� �߰�
	'// 
	dim com_name, job_title, job_close_type, job_close_date, job_source, job_id, job_reg_services
	Dim r_upfile_name, r_upfile_url, r_savefile_name
	sqlstr = "select a.ȸ���, a.������������, a.������������, a.����������, b.�����ó, a.ȸ����̵�, a.��ϼ��� from ä������ a left outer join ä������2  b on a.��Ϲ�ȣ = b.��Ϲ�ȣ where a.��Ϲ�ȣ = ?"
	
	ConnectDB dbCon, Application("DBInfo_FAIR")
	redim parameter(0)
	parameter(0) = makeParam("@��Ϲ�ȣ", adInteger, adParamInput, 4, jid)
	arrAppData = arrGetRsParam(dbCon, sqlstr, parameter, "", "")
	DisconnectDB dbCon

	if isArray(arrAppData) then
		com_name = arrAppData(0,0)
		job_title = arrAppData(1,0)
		job_close_type = arrAppData(2,0)
		job_close_date = arrAppData(3,0)
        job_source = arrAppData(4,0)
        job_id = arrAppData(5,0)
        job_reg_services = arrAppData(6,0)		'// 2015-05-11 ��ϼ��� 27, ȸ����̵� = '' ���ް��� ���� �߰�

		com_name = replace(com_name, "(��)", "��")
		If job_reg_services = "27" And job_id = "" Then '//27=���ް���(�����) '//22= W : ������� A : �������Է°���
			job_source = "2" '���ް���
		Else
			If job_source <> "������" Then	'// 2016-09-12 ������ ���� �߰�
				job_source = "1" '��������
			End If
		End If

	Else
		Response.write "<script>alert('�ش���� �����Ǿ��ų� �������� �ʴ� �����Դϴ�.'); history.back();</script>"
		Response.End 
	end if
	


	Dim toeic, toefl, teps, jpt
	' Ŀ�������� ���
	if rid <> "" and user_id <> "" and (appformtype="A" or appformtype="D") then
		ConnectDB dbCon, Application("DBInfo_FAIR")
		
		' �̷¼����������� �ݿ�
		sqlstr = "update �̷¼��������� set ��ȭ��ȣ = ?, ��ȭ��ȣ���� = ?, �޴��� = ?, �޴������� = ?, ���ڿ��� = ?, ���ڿ������ = ? where ���ξ��̵� = ?"
		redim parameter(6)
		parameter(0) = makeParam("@��ȭ��ȣ", adVarchar, adParamInput, 20, l_tel)
		parameter(1) = makeParam("@��ȭ��ȣ����", adChar, adParamInput, 1, phone_flag)
		parameter(2) = makeParam("@�޴���", adVarchar, adParamInput, 20, l_hp)
		parameter(3) = makeParam("@�޴�������", adChar, adParamInput, 1, user_cell_flag)
		parameter(4) = makeParam("@���ڿ���", adVarchar, adParamInput, 50, l_email)
		parameter(5) = makeParam("@���ڿ������", adChar, adParamInput, 1, email_flag)
		parameter(6) = makeParam("@���ξ��̵�", adVarchar, adParamInput, 20, user_id)
		
		call execSqlParam(dbCon, sqlstr, parameter, "", "")

		
		Dim sqlstr_f, arrAppData_f
		sqlstr_f = "SELECT ISNULL(�̷¼�����,'') from �̷¼� where ��Ϲ�ȣ = ? and �ܰ� = '5' and ���ξ��̵� = ?"
		redim parameter_f(1)
		parameter_f(0) = makeParam("@��Ϲ�ȣ", adInteger, adParamInput, 4, rid)
		parameter_f(1) = makeParam("@���ξ��̵�", adVarchar, adParamInput, 20, user_id)
		arrAppData_f = arrGetRsParam(dbCon, sqlstr_f, parameter_f, "", "")

		if isArray(arrAppData_f) then
			rs_resumegb = arrAppData_f(0,0)
		End If

	' Ŀ������ �ƴ� ��� ȸ������ ��ȸ
	elseif user_id <> "" and appformtype <> "A" and appformtype <> "D" then	
		sqlstr = "select isnull(a.�����з��ڵ�,b.�����з��ڵ�), isnull(b.����ڵ�,'1'), isnull(b.��¿���,0), b.��������ڵ�, a.�ֹι�ȣ��, a.�ֹι�ȣ��, a.�ֹι�ȣ��, b.�̷¼����� from ����ȸ������ a (nolock) left outer join �̷¼� b (nolock) on a.���ξ��̵� = b.���ξ��̵� and b.�⺻�̷¼� = '1' where a.���ξ��̵� = ?"
		ConnectDB dbCon, Application("DBInfo_FAIR")
		redim parameter(0)
		parameter(0) = makeParam("@���ξ��̵�", adVarChar, adParamInput, 20, user_id)
		arrAppData = arrGetRsParam(dbCon, sqlstr, parameter, "", "")
		
		if isArray(arrAppData) then
			if l_year = "" then	l_year = arrAppData(4,0)
			if l_month = "" then	l_month = arrAppData(5,0)
			if l_day = "" then	l_day = arrAppData(6,0)
            if l_rGubun = "" then	l_rGubun = arrAppData(7,0)
		end if
	end if


	if l_year = "" then
		Response.write "<script>alert('�������� �� ���������� ������� �ʾҰų� �ٸ��� �ʽ��ϴ�.\n\n���������� �Է� �� �ٽ� �õ��� �ֽʽÿ�.'); history.back();</script>"
		Response.End 
	end If
	
    Function getAge(yyyy)
        If IsNumeric(yyyy) And yyyy <> "" Then
            getAge = (Year(Date()) - yyyy)+1
        Else
            getAge = "-"
        End If
    End Function

	' ���� �Ի����� ����
	'***** ������ ���� ��ó��
	dim mail_title,mail_fromer,charge_email,company_id,company_name
	charge_email=Request.Form("charge_email")
	company_id=Request.Form("company_id")
	company_name=replace(Request.Form("company_name"),"(��)","��")

	if charge_email <> "" then
		dim arrmail
		arrmail = split(charge_email, ";")

		if ubound(arrmail,1) = 0 then
			if ubound(split(charge_email, "@")) > 1 then
				Response.write "<script>alert('�߸��� ���� ���� �Դϴ�.'); history.back();</script>"
				Response.End 
			end if
		else
			if ubound(split(arrmail(0), "@")) > 1 or ubound(split(arrmail(1), "@")) > 1 Then
				Response.write "<script>alert('�߸��� ���� ���� �Դϴ�.'); history.back();</script>"
				Response.End 
			end if
		end If
	Else 
		charge_email = "expo@career.co.kr"	'2016-01-09 ä������ ���� ������� �߰� (ä����� ��� ����� �̸��� �ʼ���)
	end if
	
	dim usrid : usrid = user_id
	if usrid = "" then	usrid = "unknown"	' ��ȸ��
	
	Dim age : age = getAge(l_year2)

	dim aplcode : aplcode = "1"
	'if instrrev("DEF",appformtype) > 0 then	aplcode = "2"

	'// 
	'// 2015-06-10
	'// tab Ŭ���ϸ� �¶����Ի��������� ��������ڵ尡 ����Ǿ� �Ķ���� �߰�
	'// 

	If onlienemail_chk = "A" Then '// �¶���
		aplcode = "1"
	Else
		aplcode = "2" '// �̸���
	End If 
	
	' response.write "usrid=" & usrid & "<br/>"
	' response.write "new_salary=" & new_salary & "<br/>"
	' response.write "exp_flag=" & exp_flag & "<br/>"
	' response.write "final_school=" & final_school & "<br/>"
	' response.write "l_gender=" & l_gender & "<br/>"
	' response.write "age=" & age & "<br/>"
	 
	' response.write "company_id=" & company_id & "<br/>"
	' response.write "appformtype=" & appformtype & "<br/>"
	' response.write "l_name=" & l_name & "<br/>"
	' response.write "l_email=" & l_email & "<br/>"
	' response.write "l_tel=" & l_tel & "<br/>"
	' response.write "l_hp=" & l_hp & "<br/>"
	' response.write "exp_months=" & (strfix(exp_year,"int",0) * 12 + strfix(exp_month,"int",0)) & "<br/>"
	' response.write "l_month=" & l_month & "<br/>"
	' response.write "l_day=" & l_day & "<br/>"
	' response.write "l_title=" & l_title & "<br/>"


	'/// �������� ���� �߰� 2017-01-24 : 1�г� ��Ϲ�ȣ, ���̵� ���� ���� ������ ���â�� �������� (usrid, jid)
	Dim no_reinsert
	no_reinsert = "1"

	sp_name = "USP_APPLY_CHECK_HIST" '���ν��� ����: ä������ �̸��� �߰� 2017-01-06
	redim parameter(2)  
	parameter(0) = makeParam("@param1", adVarChar, adParamInput, 20, usrid)
	parameter(1) = makeParam("@param2", adInteger, adParamInput,4, jid)
	parameter(2) = makeParam("@RTN", adInteger, adParamOutput, 4, 0)

	Call execSP(dbCon, sp_name, parameter, "", "")
	no_reinsert = getParamOutputValue(parameter, "@RTN")	' 1: ��������, 0: �������

	If no_reinsert = "1" Then 
		Response.write "<script>alert('�̹� ������ ä����� �Դϴ�.\n�ش���� �������� ����� ���Ͻø� 1�� �� ������ �Ͻñ� �ٶ��ϴ�.'); history.back();</script>"
		Response.End 
	End If


	Dim apply_no, arrApplyNoData, arrApplyNoData2

	'response.write "<bR>debug:"&jpt
	'response.End

	
	'Response.write "usrid : " & usrid & "<br>"
	'Response.write "jid : " & jid & "<br>"
	'Response.write "rid : " & rid & "<br>"
	'Response.write "company_name : " & company_name & "<br>"
	'Response.write "new_salary : " & new_salary & "<br>"
	'Response.write "experience_flag : <br>"
	'Response.write "final_school : " & final_school & "<br>"
	'Response.write "l_gender : " & l_gender & "<br>"
	'Response.write "age : " & age & "<br>"
	'Response.write "toeic : " & toeic & "<br>"
	'Response.write "toefl : " & toefl & "<br>"
	'Response.write "teps : " & teps & "<br>"
	'Response.write "jpt : " & jpt & "<br>"
	'Response.write "company_id : " & company_id & "<br>"
	'Response.write "guin_title : " & guin_title & "<br>"
	'Response.write "aplcode : " & aplcode & "<br>"
	'Response.write "mojip : " & mojip & "<br>"

	'Response.write "appformtype : " & appformtype & "<br>"
	'Response.write "l_name : " & l_name & "<br>"
	'Response.write "l_email : " & l_email & "<br>"
	'Response.write "email_flag : " & email_flag & "<br>"
	'Response.write "l_tel : " & l_tel & "<br>"
	'Response.write "phone_flag : " & phone_flag & "<br>"
	'Response.write "l_hp : " & l_hp & "<br>"
	'Response.write "user_cell_flag : " & user_cell_flag & "<br>"
	'Response.write "zipcode : <br>"
	'Response.write "address : <br>"
	'Response.write "address_opn : 0 <br>"
	'Response.write "usrid : " & usrid & "<br>"
	'Response.write "exp_months : " & (strfix(exp_year,"int",0) * 12 + strfix(exp_month,"int",0)) & "<br>"
	'Response.write "l_year : " & right(l_year,2) & "<br>"
	'Response.write "l_month : " & l_month & "<br>"
	'Response.write "l_day : " & l_day & "<br>"
	'Response.write "l_title : " & l_title & "<br>"
	'Response.write "charge_email : " & charge_email & "<br>"



'	sp_name = "���ͳ��Ի����������Է�3"
	sp_name = "USP_APPLY_HIST_INSERT" '���ν��� ����: ä������ �̸��� �߰� 2017-01-06
	redim parameter(35)  
	parameter(0) = makeParam("RETURN_VALUE", adInteger, adParamReturnValue, 4, 0)
	parameter(1) = makeParam("@param1", adVarChar, adParamInput, 20, usrid)
	parameter(2) = makeParam("@param2", adInteger, adParamInput,4, jid)
	parameter(3) = makeParam("@param3", adInteger, adParamInput,4, rid)
	parameter(4) = makeParam("@param4", adVarChar, adParamInput, 50, company_name)
	parameter(5) = makeParam("@param5", adVarChar, adParamInput, 2, new_salary)
	parameter(6) = makeParam("@param6", adVarChar, adParamInput, 10, " ")
	parameter(7) = makeParam("@param7", adChar, adParamInput, 1, exp_flag)
	parameter(8) = makeParam("@param8", adVarChar, adParamInput, 2, final_school)
	parameter(9) = makeParam("@param9", adChar, adParamInput, 1, l_gender)
	parameter(10) = makeParam("@param10", adVarChar, adParamInput, 2, age)
	parameter(11) = makeParam("@param11", adVarChar, adParamInput, 4, toeic)
	parameter(12) = makeParam("@param12", adVarChar, adParamInput, 4, toefl)
	parameter(13) = makeParam("@param13", adVarChar, adParamInput, 4, teps)
	parameter(14) = makeParam("@param14", adVarChar, adParamInput, 4, jpt)
	parameter(15) = makeParam("@param15", adVarChar, adParamInput, 20, company_id)
	parameter(16) = makeParam("@param16", adVarChar, adParamInput, 100, guin_title)
	parameter(17) = makeParam("@param17", adChar, adParamInput, 1, aplcode)
	parameter(18) = makeParam("@param18", adInteger, adParamInput, 0, mojip)

	' �߰� �Ķ���� (201201, �Ի����� ����)
	parameter(19) = makeParam("@apltype", adChar, adParamInput, 1, appformtype)
	parameter(20) = makeParam("@user_name", adVarchar, adParamInput, 20, l_name)
	parameter(21) = makeParam("@email", adVarchar, adParamInput, 50, l_email)
	parameter(22) = makeParam("@email_opn", adChar, adParamInput, 1, email_flag)
	parameter(23) = makeParam("@phone", adVarchar, adParamInput, 20, l_tel)
	parameter(24) = makeParam("@phone_opn", adChar, adParamInput, 1, phone_flag)
	parameter(25) = makeParam("@mobile", adVarchar, adParamInput, 20, l_hp)
	parameter(26) = makeParam("@mobile_opn", adChar, adParamInput, 1, user_cell_flag)
	parameter(27) = makeParam("@zipcode", adVarchar, adParamInput, 7, " ")
	parameter(28) = makeParam("@address", adVarchar, adParamInput, 100, " ")
	parameter(29) = makeParam("@address_opn", adChar, adParamInput, 1, "0")
	parameter(30) = makeParam("@exp_months", adInteger, adParamInput, 4, (strfix(exp_year,"int",0) * 12 + strfix(exp_month,"int",0)))
	parameter(31) = makeParam("@birthYY", adVarchar, adParamInput, 4, right(l_year,2))
	parameter(32) = makeParam("@birthMM", adVarchar, adParamInput, 2, l_month)
	parameter(33) = makeParam("@birthDD", adVarchar, adParamInput, 2, l_day)
	parameter(34) = makeParam("@l_title", adVarchar, adParamInput, 250, l_title)
	parameter(35) = makeParam("@applyemail", adVarchar, adParamInput, 100, charge_email) 'ä������ �̸��� �߰� 2017-01-06
	

	Call execSP(dbCon, sp_name, parameter, "", "")
	apply_no = getParamOutputValue(parameter, "RETURN_VALUE")	' ���̹�ä������ ��Ϲ�ȣ

	'�Ի����� �̷¼� ���� (2021-02-05 �߰�)
	ReDim parameter(2)
	parameter(0) = makeParam("@USER_ID", adVarChar, adParamInput, 20, user_id)
	parameter(1) = makeParam("@RESUME_NO", adVarChar, adParamInput, 4, rid)
	parameter(2) = makeParam("@APPLY_NO", adInteger, adParamInput, 4, apply_no)
	
	sp_name = "USP_�Ի�����_�̷¼�_���"
	Call execSP(dbCon, sp_name, parameter, "", "")


	'÷������ ���� �Լ�
	Function setMailFileAttach(objMail, arrFile)

		Dim ii
		Dim fRealFileName, fUpFileName, fGubun, fRealUpFileName
		Dim execSqlStmt : execSqlStmt = ""

		execSqlStmt = ""

		'fRealFileName = ATTACH_FILE_PATH & arrFile(0) &"\"& arrFile(1)
		'fRealUpFileName = ATTACH_FILE_PATH & arrFile(0) &"\"& arrFile(2)
		fUpFileName = arrFile(2)
		fGubun = arrFile(4)

		'�̸��� ����÷��
		'objMail.AddAttachment fRealFileName, fUpFileName

		'���ϴٿ�ε带 ���� �������� ���
		execSqlStmt = execSqlStmt & "Insert into ���ͳ��Ի���������÷�� (������ȣ, ä���Ϲ�ȣ, �̷¼���Ϲ�ȣ, �Ϸù�ȣ, ���ξ��̵�, �����ϸ�, �����ϰ��, �����ϸ�, ����, �����, ����ũ��) " &_
									" select '"&apply_no&"', '"&jid&"', '"&strfix(rid,"int",0)&"', (SELECT ISNULL(MAX(�Ϸù�ȣ+1), 1) FROM ���ͳ��Ի���������÷�� (nolock) WHERE (������ȣ = '"& apply_no &"'))" &_
									", '"& user_id &"', '"& arrFile(1) &"', '"& arrFile(0) &"', '"& fUpFileName &"', '" & fGubun & "', getdate(), '" & arrFile(3) & "'; "

		'execSqlStmt = execSqlStmt & " if not EXISTS (select �����ϸ� FROM  �������弭�� with(nolock) where  �����ϸ�='"& arrFile(1) &"' and ���ξ��̵�='"& user_id &"') begin Insert into �������弭�� (���ξ��̵�, ����, ������ȣ, ����, �����ϸ�, �����ϰ��, �����ϸ�, ���ϻ�����, �����) " &_
		'							" select '"& user_id &"', '" & fGubun & "', (SELECT ISNULL(MAX(������ȣ+1), 1) FROM �������弭�� (nolock) WHERE (���ξ��̵� = '"& user_id &"'))" &_
		'							", '1', '"& arrFile(1) &"', '"& arrFile(0) &"', '"& fUpFileName &"', '" & arrFile(3) & "', getdate() ; end "

		setMailFileAttach = execSqlStmt

	End Function

	
	'����÷��
	dim arrfilelist1, arrfilelist2, strsql_in
	if filelist <> "" then
		strsql_in = ""
		arrfilelist1 = split(filelist,":")
		for i = 0 to ubound(arrfilelist1)

			arrfilelist2 = split(arrfilelist1(i),"|") '// 201412|1412159211074.gif|ĸó.GIF|113192|C
			if isArray(arrfilelist2) then
				strsql_in = strsql_in & setMailFileAttach("", arrfilelist2)
			end if
		Next
	end If
	
	if strsql_in <> "" Then
		call execSql(dbCon, strsql_in, "", "")
	end If


	dim errcnt : errcnt = dbCon.Errors.Count
	DisconnectDB dbCon
	
	If errcnt = "0" Then
		' �̸���ó��
		Dim marking
		For i=1 To Fix(Len(l_name)-1)
			marking = marking & "*"
		Next

		' ���̼���
		Dim birth_age
		If l_gender = "1" Or l_gender = "2" Then 
			birth_age = Left(Date(), 4) - l_year2 + 1
		ElseIf l_gender = "3" Or l_gender = "4" Then 
			birth_age = Left(Date(), 4) - l_year2 + 1
		End If

		' �����з¼���
		ConnectDB dbCon, Application("DBInfo_FAIR")
		Dim arrRsSchool
		sqlstr = " SELECT �б���, ������, �������� FROM �̷¼��з� WHERE ��Ϲ�ȣ = '" & rid & "' AND �з����� = '" & final_school & "' "
		arrRsSchool = arrGetRsParam(dbCon, sqlstr, "", "", "")
		
		Dim SchoolNM, DepartmentNM, GraduatedState
		If isArray(arrRsSchool) Then
			schoolNM = arrRsSchool(0,0)
			DepartmentNM = arrRsSchool(1,0)
			Select Case arrRsSchool(2,0)
				Case "3" : GraduatedState = "����"
				Case "4" : GraduatedState = "����"
				Case "5" : GraduatedState = "����"
				Case "7" : GraduatedState = "����(��)"
				Case "8" : GraduatedState = "����"
			End Select
		End If
		DisconnectDB dbCon

		' ����/��±���
		Dim strCareer
		If (strfix(exp_year,"int",0) * 12 + strfix(exp_month,"int",0)) > 0 Then
			strCareer = "���"
		Else
			strCareer = "����"
		End If

		Dim mailForm, iConf, mailer
		mailForm = "<html>"&_
					"<head>"&_
						"<title>"& site_name &"</title>"&_
						"<meta content=""text/html; charset=euc-kr"" http-equiv=""Content-Type"" />"&_
						"<meta http-equiv=""X-UA-Compatible"" content=""IE=Edge"">"&_
					"</head>"&_
					"<body style=""text-align: center; padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font-family: Dotum, '����', Times New Roman, sans-serif; background: #ffffff; color: #666; font-size: 12px; padding-top: 0px"">"&_
						"<table border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"" style=""width:738px;border:solid 1px #e4e4e4; border-top:0 none; border-bottom:0 none;table-layout: fixed;"">"&_
							"<colgroup>"&_
								"<col style=""width:20px;"">"&_
								"<col style=""width:699px;"">"&_
								"<col style=""width:20px;"">"&_
							"</colgroup>"&_
							"<tbody>"&_
								"<tr>"&_
									"<td style=""width:20px;""></td>"&_
									"<td style=""width:698px;padding:20px 0;border-collapse: inherit;background:#f0f0f0;border:1px dashed #c10e2c;text-align:center;"">"&_
										"<p style=""font-size:20px;line-height:1.8;letter-spacing: -1px;color:#000;"">"&_
											"�ȳ��ϼ���. <strong>ä������</strong>��<br>"&_
											"<strong>�������� ä����� �����ڰ� �����߽��ϴ�.</strong><br>"&_
											"���� �ٷ� �������� �̷¼��� Ȯ���� �ּ���."&_
										"</p>"&_
										"<table border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"" style=""width:100%;"">"&_
											"<colgroup>"&_
												"<col style=""width:32%;"">"&_
												"<col style=""width:68%;"">"&_
											"</colgroup>"&_
											"<tbody>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">ä�����</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & job_title & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">�̸�</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & Left(l_name,1) & marking & "(" & l_year2 & "���/" & birth_age & "��)" & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">������</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & Left(Date(), 10) & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">�����з�</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & SchoolNM & "&nbsp;" & DepartmentNM & "&nbsp;" & GraduatedState & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<th style=""width:32%;padding:10px 10px 10px 0;vertical-align:top;text-align:right;font-size:17px;"">���</th>"&_
													"<td style=""width:68%;padding:10px 0 10px 10px;vertical-align:top;text-align:left;font-size:17px;"">" & strCareer & "</td>"&_
												"</tr>"&_
												"<tr>"&_
													"<td colspan=""2"" style=""padding:10px 10px 10px 10px;text-align:center;"">"&_
														"<a href=""" & g_partner_wk & "/company/applyjob/apply.asp?jid=" & jid &"&pid=0"" target=""_blank"">"&_
															"<img border=""0"" alt=""������ �̷¼� ����"" src=""http://image.career.co.kr/career_new/event/2020/starfield/open_btn.jpg"">"&_
														"</a>"&_
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
		mailer.To	= charge_email
		mailer.Subject	= "["&site_name&"] �������� ���� �����ڰ� �����߽��ϴ�."
		mailer.HTMLBody	= mailForm
		mailer.BodyPart.Charset="ks_c_5601-1987"
		mailer.HTMLBodyPart.Charset="ks_c_5601-1987"
		mailer.Send
		Set mailer = Nothing 

		Response.write "<script>alert('�Ի������� �Ϸ�Ǿ����ϴ�.'); location.replace('/jobs/view.asp?id_num="&jid&"');</script>"
		Response.End 

	End If


%>