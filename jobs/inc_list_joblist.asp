<div class="recruit_wrap">
	<%
	If isArray(ArrRs) Then
		For i = 0 To UBound(ArrRs, 2)
		Dim rs_id_num, rs_company_id, rs_company_name, rs_company_name_code, rs_subject, rs_sex_code, rs_school_code, rs_career_code, rs_apply_start_date, rs_view_count, rs_apply_selected, rs_apply_end, rs_apply_end_date, rs_area_code, rs_career_month, rs_career_over, rs_jc_code, rs_item_option, rs_site_gubun, rs_ipo, rs_company_kind, rs_item_option2, rs_tct_flag, rs_position_group, rs_position_title, rs_workplace, rs_modify_date, rs_runmber, rs_register_gubun, rs_school_over, rs_work_type, rs_salary_code, rs_subway_code, rs_biz_code, rs_applyUrl

		rs_id_num				= ArrRs(0, i)	'��Ϲ�ȣ
		rs_company_id			= ArrRs(1, i)	'ȸ����̵�
		rs_company_name			= ArrRs(2, i)	'ȸ���
		rs_company_name_code	= ArrRs(3, i)	'ȸ���1
		rs_subject				= ArrRs(4, i)	'������������
		rs_sex_code				= ArrRs(5, i)	'����
		rs_school_code			= ArrRs(6, i)	'�з��ڵ�
		rs_career_code			= ArrRs(7, i)	'����ڵ�
		rs_apply_start_date		= ArrRs(8, i)	'(null)����������
		rs_view_count			= ArrRs(9, i)	'��ȸ��
		rs_apply_selected		= ArrRs(10, i)	'�������
		rs_apply_selected = split(rs_apply_selected, ",")
		rs_apply_end			= ArrRs(11, i)	'������������
		rs_apply_end_date		= ArrRs(12, i)	'(null)����������
		rs_area_code			= ArrRs(13, i)	'�����ڵ�
		rs_career_month			= ArrRs(14, i)	'��¿���
		rs_career_over			= ArrRs(15, i)	'������Ѽ�
		rs_jc_code				= ArrRs(16, i)	'�����ڵ�
		rs_item_option			= ArrRs(17, i)	'�����ۿɼ�
		rs_site_gubun			= ArrRs(18, i)	'����Ʈ����
		rs_ipo					= ArrRs(19, i)	'���忩��
		'rs_?					= ArrRs(20, i)	'�����ڷῩ��
		rs_company_kind			= ArrRs(21, i)	'�����ڵ�
		rs_item_option2			= ArrRs(22, i)	'�����ۿɼ�2
		rs_tct_flag				= ArrRs(23, i)	'���ñٹ�����
		rs_position_group		= ArrRs(24, i)	'����
		rs_position_title		= ArrRs(25, i)	'��å
		rs_workplace			= ArrRs(26, i)	'�ٹ��μ�
		'rs_?					= ArrRs(27, i)	'ȸ�������
		'rs_?					= ArrRs(28, i)	'������
		'rs_?					= ArrRs(29, i)	'����Ŀ����
		rs_modify_date			= ArrRs(30, i)	'������
		rs_runmber				= ArrRs(31, i)	'�����ο�
		rs_register_gubun		= ArrRs(32, i)	'��ϼ���
		rs_school_over			= ArrRs(33, i)	'�з��̻�
		rs_work_type			= ArrRs(34, i)	'(null)�ٹ�����
		'rs_?					= ArrRs(35, i)	'�λ��
		'rs_?					= ArrRs(36, i)	'��۴�
		'rs_?					= ArrRs(37, i)	'(null)��亯
		'rs_?					= ArrRs(38, i)	'(null)��亯
		rs_salary_code			= ArrRs(39, i)	'�����ڵ�
		'rs_?					= ArrRs(40, i)	'����è�Ǿ𿩺�
		'rs_?					= ArrRs(41, i)	'WORK_TP_ICD
		rs_subway_code			= ArrRs(42, i)	'����ö�ڵ�
		rs_biz_code				= ArrRs(43, i)	'����ڹ�ȣ
		rs_applyUrl				= ArrRs(44, i)	'����Ʈ����URL
		If InStr(rs_applyUrl, "http") = 0 Then rs_applyUrl = "http://" & rs_applyUrl

		'��ũ��/���ã��, �߰�/���� ����, ����2�� ����Ʈ, �������
		Dim chk_scrap, chk_attention
		Dim arrRsView, arrRsScrap, arrRsAttention, arrRsArea
		chk_scrap		= ""
		chk_attention	= ""

		ConnectDB DBCon, Application("DBInfo_FAIR")
			Dim SpName, mode, bizNum
			' ä����� ���� �� ������� ��ȸ�� ����ڹ�ȣ ����
			SpName="W_ä������_����_��ȸ"

			ReDim param(2)
			param(0)=makeParam("@id_num", adInteger, adParamInput, 4, rs_id_num)
			param(1)=makeParam("@mode", adVarChar, adParamOutput, 4, "")
			param(2)=makeParam("@bizNum", adVarChar, adParamOutput, 10, "")

			Call execSP(DBCon, SpName, param, "", "")
			mode	= getParamOutputValue(param, "@mode")	' ä����� ����(ing : ����, cl: ����)
			bizNum	= getParamOutputValue(param, "@bizNum") ' ä����� ��� ��� ����ڹ�ȣ

			'�������
			strSql = ""
			strSql = strSql & " SELECT"
			strSql = strSql & " �¶���Ŀ������,�¶����������,�¶����ڻ���"
			strSql = strSql & " ,�̸���Ŀ������,�̸����������,�̸����ڻ���"
			strSql = strSql & " FROM ä������_�����ΰ����� WITH(NOLOCK)"
			strSql = strSql & " WHERE ä��������Ϲ�ȣ = " & rs_id_num
			strSql = strSql & " UNION ALL"
			strSql = strSql & " SELECT NULL, NULL, NULL, NULL, NULL, NULL"
			arrRsView = arrGetRsSql(DBCon, strSql, "", "")

			'ä������ 2��
			arrRsArea = arrGetRsSql(DBCon, "SELECT TOP 1 ���������ڵ�, �����ڵ� FROM ä������2 WITH(NOLOCK) WHERE ��Ϲ�ȣ = "& rs_id_num &" ORDER BY ������ȣ", "", "")

			If user_id <> "" Then
				'��ũ�� ����
				 arrRsScrap = arrGetRsSql(DBCon,"SELECT ���ξ��̵� FROM ��ũ��ä������ WITH(NOLOCK)  WHERE ���ξ��̵� = '" & user_id & "' AND �������� = '0' and ä��������Ϲ�ȣ = '" &  rs_id_num & "'", "", "")
				if isArray(arrRsScrap) then
					chk_scrap = "Y"
				end If

				'���ɱ�� ����
				arrRsAttention = arrGetRsSql(DBCon,"SELECT ���ξ��̵� FROM ���ΰ��ɱ�� WITH(NOLOCK)  WHERE ���ξ��̵� = '" & user_id & "' AND ����ڵ�Ϲ�ȣ = '" & rs_company_id & "'", "", "")
				if isArray(arrRsAttention) then
					chk_attention = "Y"
				end If
			End If


			ReDim param(0)
			param(0) = makeParam("@BizNum", adVarchar, adParamInput, 10, bizNum)

			Dim arrRsComInfo
			SpName = "USP_COMPANY_INFO_VIEW"
			arrRsComInfo = arrGetRsSP(dbCon, spName, param, "", "")

			' ����з� ����
			Dim RsCom_BizIPO, RsCom_BizScale, RsCom_MediYN, RsCom_StrYN, RsCom_HdChampYN, RsCom_BIGYN
			If isArray(arrRsComInfo) Then
				RsCom_BizIPO	= arrRsComInfo(3, 0)	' ���忩��(IPO)
				RsCom_BizScale	= arrRsComInfo(4, 0)	 '�������(bizScale)

				RsCom_MediYN	= arrRsComInfo(17, 0)	' �߰߱��(Y/N)
				RsCom_StrYN		= arrRsComInfo(18, 0)	' ���ұ��(Y/N)
				RsCom_HdChampYN	= arrRsComInfo(19, 0)	' ����è�Ǿ�(Y/N)
				RsCom_BIGYN		= arrRsComInfo(16, 0)	' ���� ������(1: ����, 2: �����, 3: ������, NULL: �ش����)
			Else
				RsCom_BizIPO	= ""
				RsCom_BizScale	= ""

				RsCom_MediYN	= ""
				RsCom_StrYN		= ""
				RsCom_HdChampYN	= ""
				RsCom_BIGYN		= ""
			End If

			' ��� ���� ǥ��
			Dim bizIPO : bizIPO	= ""
			bizIPO = getIPOCodeName(RsCom_BizIPO)
			bizIPO = Replace(Replace(Replace(bizIPO, "(", ""), ")", ""),"��Ÿ","")

			' ��� �з� ǥ��
			Dim bizGubun : bizGubun	= ""
			If isnull(RsCom_MediYN) And isnull(RsCom_StrYN) And isnull(RsCom_HdChampYN) And isnull(RsCom_BIGYN) Then
				' ���� �����ڰ� ������ ��� �з��� ���� ��� �ſ��򰡱�� ���� ��� �з��� ��ü
				Select Case RsCom_BizScale
					Case "0" bizGubun = "�������"
					Case "1" bizGubun = "����"
					'Case "2" bizGubun = "��Ÿ"
					Case "3" bizGubun = "�߰߱��"
				End Select
			Else
				If RsCom_HdChampYN = "Y" Then bizGubun = "����è�Ǿ�"
				If RsCom_StrYN = "Y" Then bizGubun = "���ұ��"
				If RsCom_MediYN = "Y" Then bizGubun = "�߰߱��"
				Select Case RsCom_BIGYN
					Case "1" bizGubun = "����"
					Case "2" bizGubun = "�����"
					Case "3" bizGubun = "������"
				End Select
			End If

		DisconnectDB DBCon
	%>
	<dl>
		<dt>
			<a href="./view.asp?id_num=<%=rs_id_num%>"><%=rs_company_name%></a>
			<div class="comp_type">
				<% If bizGubun <> "" Then %><span class="tp tp1"><%=bizGubun%></span><% End If %>
				<% If bizIPO <> "" Then %><span class="tp tp2"><%=bizIPO%></span><% End If %>
			</div>
		</dt>
		<dd>
			<a href="./view.asp?id_num=<%=rs_id_num%>"><%=rs_subject%></a>
			<a href="javascript:void(0)" class="scrap <% If chk_scrap = "Y" Then %> on <% End If %>" onclick="fn_scrap('<%=g_LoginChk%>','<%=rs_id_num%>',this); return false;"><span>��ũ��</span></a>
			<div class="recruit_info">
				<span>
					<%
					Dim str_end_date
					Select Case rs_apply_end
						Case "1" : str_end_date = "~" & Right(rs_apply_end_date, 5) & "(" & getWeekDay(weekDay(rs_apply_end_date)) & ")"
						Case "2" : str_end_date = "ä��� ����"
						Case "3" : str_end_date = "���ä��"
					End Select
					%>
					<%=str_end_date%>
				</span>
				<span><%=getExp(rs_career_code)%></span>
				<span><%=getSchool3(rs_school_code)%></span>
				<% If isArray(arrRsArea) Then %>
				<span><%=getAcName(arrRsArea(0, ii))%> &gt; <%=getAcName(arrRsArea(1, ii))%></span>
				<% End If %>
			</div>

			<% If rs_apply_selected(5) = "1" Then %>
			<a href="<%=rs_applyUrl%>" class="btn blue">Ȩ������ ����</a>
			<% ElseIf arrRsView(1, 0) = "Y" Or arrRsView(3, 0) = "Y" Then %>
			<a href="./view.asp?id_num=<%=rs_id_num%>" class="btn blue">���� ���</a>
			<% ElseIf arrRsView(2, 0) = "Y" Or arrRsView(4, 0) = "Y" Then %>
			<a href="./view.asp?id_num=<%=rs_id_num%>" class="btn blue">�ڻ� ���</a>
			<% Else %>
			<a href="./view.asp?id_num=<%=rs_id_num%>" class="btn blue">�¶��� ����</a>
			<% End If %>
		</dd>
	</dl>
	<%
		Next
	Else
	%>
	<dl>�˻������ �����ϴ�.</dl>
	<%
	End If
	%>
	<!--
	<ul class="paging_area">
		<li class="btn prev"><a>����</a></li>
		<li><strong>1</strong></li>
		<li><a href="javascript:fnGolist(2);">2</a></li>
		<li><a href="javascript:fnGolist(3);">3</a></li>
		<li><a href="javascript:fnGolist(4);">4</a></li>
		<li><a href="javascript:fnGolist(5);">5</a></li>
		<li class="btn next"><a href="javascript:fnGolist(6);">����</a></li>
	</ul>
	-->

	<!--����¡-->
	<% Call putPage(Page, stropt, totalPage) %>
</div><!--recruit_wrap -->
