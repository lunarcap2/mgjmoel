<%
	Dim date_cy, date_ly, date_bly
	date_cy		= year(date) -1
	date_ly		= date_cy -1
	date_bly	= date_ly -1

	Dim capital_cy, capital_ly, capital_bly '�ں���
	Dim sales_cy, sales_ly, sales_bly '�����
	Dim income_cy, income_ly, income_bly '��������
	Dim ranking_cy, ranking_ly, ranking_bly '���������
	capital_cy		= Ccur(arrNice_1(0, 0)) / 10
	capital_ly		= Ccur(arrNice_1(1, 0)) / 10
	capital_bly		= Ccur(arrNice_1(2, 0)) / 10
	sales_cy		= Ccur(arrNice_1(3, 0)) / 10
	sales_ly		= Ccur(arrNice_1(4, 0)) / 10
	sales_bly		= Ccur(arrNice_1(5, 0)) / 10
	income_cy		= Ccur(arrNice_1(6, 0)) / 10
	income_ly		= Ccur(arrNice_1(7, 0)) / 10
	income_bly		= Ccur(arrNice_1(8, 0)) / 10
	ranking_cy		= arrNice_1(12, 0)
	ranking_ly		= arrNice_1(13, 0)
	ranking_bly		= arrNice_1(14, 0)

	Dim capital_rate, sales_rate, income_rate
	If capital_ly <> 0 Then capital_rate = (capital_cy - capital_ly) / capital_ly * 100
	If sales_ly <> 0 Then sales_rate = (sales_cy - sales_ly) / sales_ly * 100
	If income_ly <> 0 Then income_rate = (income_cy - income_ly) / income_ly * 100

	capital_rate = FormatNumber(capital_rate, 2)
	sales_rate = FormatNumber(sales_rate, 2)
	income_rate = FormatNumber(income_rate, 2)
	
	Dim capital_updown, sales_updown, income_updown
	Select Case Sgn(capital_rate)
		Case 0	: capital_updown = "middle"
		Case 1	: capital_updown = "up"
		Case -1 : capital_updown = "down"
	End Select
	Select Case Sgn(sales_rate)
		Case 0	: sales_updown = "middle"
		Case 1	: sales_updown = "up"
		Case -1	: sales_updown = "down"
	End Select
	Select Case Sgn(income_rate)
		Case 0	: income_updown = "middle"
		Case 1	: income_updown = "up"
		Case -1	: income_updown = "down"
	End Select

	Dim bizGubun, bizIPO
	bizGubun = "�Ϲݱ��"
	If IsArray(arrNice_7) Then
		If arrNice_7(2, 0) = "Y" Then bizGubun = "����è�Ǿ�"
		If arrNice_7(1, 0) = "Y" Then bizGubun = "���ұ��"
		If arrNice_7(0, 0) = "Y" Then bizGubun = "�߰߱��"

		Select Case arrNice_7(7, 0)
			Case "1" : bizGubun = "����"
			Case "2" : bizGubun = "�����"
			Case "3" : bizGubun = "������"
		End Select
	Else 
		' ���� �����ڰ� ������ ��� �з��� ���� ��� �ſ��򰡱�� ���� ��� �з��� ��ü
		Select Case arrNice_0(13, 0)
			Case "1" bizGubun = "����"
			Case "2" bizGubun = "�߼ұ��"
			Case "3" bizGubun = "�߰߱��"
			Case "4" bizGubun = "��Ÿ"
			Case "5" bizGubun = "���ƴ�� �߰߱��"
		End Select
	End If

	' �ֿ�������(GoodsName, BizField) �� ��� ���� üũ
	Dim strGoodsName : strGoodsName = ""
	If Not isnull(arrNice_0(16, 0)) Then 
		strGoodsName = arrNice_0(16, 0)
	Else 
		If Not isnull(arrNice_0(24, 0)) Then 
			strGoodsName = arrNice_0(24, 0)
		Else 
			strGoodsName = "-"
		End If 
	End If 

	' Ȩ������ URL ��� üũ
	Dim strBizHomePage
	If arrNice_0(31, 0) <> "" Then 
		If InStr(arrNice_0(31, 0),"http") > 0 Then
			strBizHomePage	= arrNice_0(31, 0)
		Else
			strBizHomePage	= "http://"& arrNice_0(31, 0)
		End If
	End If
%>

<link rel="stylesheet" type="text/css" href="/css/billboard.css?<%=publishUpdateDt%>"/>
<script type="text/javascript" src="/js/billboard.js?<%=publishUpdateDt%>"></script>
<script type="text/javascript" src="/js/billboard.pkgd.min.js?<%=publishUpdateDt%>"></script>

<div class="tab_con">
	<div class="view_box">
		<div class="tit">
			<h4>�������</h4>
		</div><!-- .tit -->
		<div class="comp-info">
			<ul class="lst1">
				<li class="i-1">
					<p class="t1">�����</p>
					<p class="t2">
						<strong><%=getCompanyMoney_strongText((Trim(sales_cy)))%></strong>
					</p>
				</li>
				<li class="i-2">
					<p class="t1">��������</p>
					<p class="t2">
						<strong><%=Left(arrNice_0(9, 0), 4)%></strong><span>��</span>
					</p>
				</li>
				<li class="i-3">
					<p class="t1">�������</p>
					<p class="t2">
						<strong><%=bizGubun%></strong>
						<span><%=getIPOCodeName(arrNice_0(11, 0))%></span>
					</p>
				</li>
				<li class="i-4">
					<p class="t1">��������</p>
					<p class="t2">
						<strong><%=FormatNumber(arrNice_0(14, 0), 0)%></strong><span>��</span>
					</p>
				</li>
			</ul>
			<ul class="lst2">
				<li>
					<strong>�����</strong>
					<span><%=arrNice_0(3, 0)%></span>
				</li>
				<li>
					<strong>��ǥ��</strong>
					<span><%=arrNice_0(5, 0)%></span>
				</li>
				<li>
					<strong>�ֿ���</strong>
					<span><%=strGoodsName%></span>
				</li>
				<li>
					<strong>ȸ����ġ</strong>
					<span><%=arrNice_0(18, 0)%></span>
				</li>
				<li class="homepage">
					<strong>Ȩ������</strong>
					<span><a href="<%=strBizHomePage%>"><%=arrNice_0(31, 0)%></a></span>
				</li>
			</ul>
		</div><!-- .comp-info -->
	</div><!--view_box -->
	
	<div class="view_box">
		<div class="tit">
			<h4>��� �� ����</h4>
		</div><!-- .tit -->
		<div class="comp-rank">
			<div class="total">
				<p class="t1"><strong><%=arrNice_0(3, 0)%></strong> <span><%=ranking_cy%></span>��</p>
				<p class="t2"><strong><%=getCompanyMoney_strongText((Trim(sales_cy)))%></strong> (<span><%=date_cy%></span>�� ����)</p>
			</div>
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="20%">
					<col width="50%">
					<col width="30%">
				</colgroup>
				<thead>
					<tr>
						<th>����</th>
						<th>�����</th>
						<th>�����</th>
					</tr>
				</thead>
				<tbody>
					<% 
						If isArray(arrNice_5) Then
							For i=0 To UBound(arrNice_5,2)
					%>
					<tr>
						<td class="t1"><%=arrNice_5(1,i)%>��</td>
						<td class="t2"><%=arrNice_5(4,i)%></td>
						<td class="t3"><%=getCompanyMoney_strongText((Trim(Ccur(arrNice_5(10, i)) / 10)))%></td>
					</tr>
					<%	
							Next
						End If 
					%>
				</tbody>
			</table>
		</div>
	</div><!--view_box -->

	<div class="view_box">
		<div class="tit">
			<h4>�繫�м�</h4>
		</div><!-- .tit -->
		<div class="ca_chart">
			<ul>
				<li>
					<div class="chart_box">
						<h5>�ں���</h5>
						<div class="chart_txt">
							<dl>
								<dt><%=date_cy%>�� �ں���</dt>
								<dd><%=getCompanyMoney_Text(capital_cy)%></dd>
							</dl>
							<dl>
								<dt>�۳���</dt>
								<dd><span class="<%=capital_updown%>"><%=capital_rate%>%</span></dd>
							</dl>
						</div>
					</div>
				</li>
				<li>
					<div class="chart_box">
						<h5>�����</h5>
						<div class="chart_txt">
							<dl>
								<dt><%=date_cy%>�� �����</dt>
								<dd><%=getCompanyMoney_Text(sales_cy)%></dd>
							</dl>
							<dl>
								<dt>�۳���</dt>
								<dd><span class="<%=sales_updown%>"><%=sales_rate%>%</span></dd>
							</dl>
						</div>
					</div>
				</li>
				<li>
					<div class="chart_box">
						<h5>��������</h5>
						<div class="chart_txt">
							<dl>
								<dt><%=date_cy%>�� �����</dt>
								<dd><%=getCompanyMoney_Text(income_cy)%></dd>
							</dl>
							<dl>
								<dt>�۳���</dt>
								<dd><span class="<%=income_updown%>"><%=income_rate%>%</span></dd>
							</dl>
						</div>
					</div>
				</li>
			</ul>
		</div><!--ca_chart -->
	</div><!--view_box -->
	
	<% If isArray(arrKangso_option23) Then %>
	<div class="view_box">
		<div class="tit">
			<h4>�����Ļ�</h4>
		</div><!-- .tit -->
		<div class="welfare-area">

			<%
				Dim ww, wf_view
				Dim wf_list : wf_list = Array( Array("wf01","��������", "13"), Array("wf02","����&middot;���� ����", "14"), Array("wf03","�系�ü� ����", "16"), Array("wf04","��Ȱ&middot;�ٹ����� ����", "18"), Array("wf05","�ް�&middot;�޹�", "12"), Array("wf06","����&middot;����", "19"), Array("wf07","ȸ�����", "15"), Array("wf08","��������ǰ", "20"), Array("wf09","���ݺ���", "11"), Array("wf10","����νü�", "17"), Array("wf02","��������", "21")  )
			%>
			<ul>
				<% For ww = 0 To ubound(wf_list)
					wf_view = ""
					Dim ii
					If isArray(arrKangso_option23) Then '�����Ļ� ����

						For ii = 0 To UBound(arrKangso_option23,2)
							If Left(Trim(arrKangso_option23(1, ii)),2) = wf_list(ww)(2) Then
								wf_view = wf_view & arrKangso_option23(2, ii) & ", "
							End If
						Next

					End If

					If Len(wf_view) > 0 Then
					wf_view = Mid(wf_view, 1, Len(wf_view)-2)
				%>
				<li class="<%=wf_list(ww)(0)%>">
					<em>icon</em>
					<p>
						<strong><%=wf_list(ww)(1)%></strong>
						<span><%=wf_view%></span>
					</p>
				</li>
				<%
					End If
				next 
				%>
				
				<% If isArray(arrKangso_option22) Then '�����Ļ� ���� %>
				<li class="last">
				<div>
					<p>
						<strong>Plus �����Ļ�</strong>
						<span>
						<% For ii = 0 To UBound(arrKangso_option22,2) %>
							<%=arrKangso_option22(2,ii)%><% If UBound(arrKangso_option22,2) > ii then %><br><% End if %>
						<% next %>
						</span>
					</p>
				</div>
				</li>
				<% End If %>

			</ul>
		</div><!-- welfare-area -->
	</div><!--view_box -->
	<% End If %>

	<% If isArray(arrRsJobsIng) Then %>
	<div class="view_box" id="div_ing_job">
		<div class="tit">
			<h4>������ ä�����</h4>
		</div><!-- .tit -->
		<div class="recruit_wrap">
			<%
			For i=0 To UBound(arrRsJobsIng, 2)

			Dim rs_apply_start_date, rs_apply_end_date, rs_apply_selected, rs_applyUrl
			rs_apply_start_date = Replace(Left(arrRsJobsIng(10, i), 10), "-", "/") '����������
			If arrRsJobsIng(12, i) <> "" Then rs_apply_end_date = Replace(Left(arrRsJobsIng(12, i), 10), "-", "/") '����������
			rs_apply_selected = arrRsJobsIng(13, i)	'�������
			rs_apply_selected = split(rs_apply_selected, ",")
			rs_applyUrl = arrRsJobsIng(14, i)	'����Ʈ����URL
			If InStr(rs_applyUrl, "http") = 0 Then rs_applyUrl = "http://" & rs_applyUrl
			
			Dim str_end_date
			Select Case arrRsJobsIng(11, i) '������������
				Case "1" : str_end_date = Right(rs_apply_end_date, 5) & "(" & getWeekDay(weekDay(rs_apply_end_date)) & ")"
				Case "2" : str_end_date = "ä��� ����"
				Case "3" : str_end_date = "���ä��"
			End Select

			'��ũ��
			Dim arrRsScrap, chk_scrap
			chk_scrap = ""
			If user_id <> "" Then
				ConnectDB DBCon, Application("DBInfo_FAIR")
				'��ũ�� ���� 
				 arrRsScrap = arrGetRsSql(DBCon,"SELECT ���ξ��̵� FROM ��ũ��ä������ WITH(NOLOCK)  WHERE ���ξ��̵� = '" & user_id & "' AND �������� = '0' and ä��������Ϲ�ȣ = '" &  arrRsJobsIng(0, i) & "'", "", "")
				if isArray(arrRsScrap) Then chk_scrap = "on"
				DisconnectDB DBCon
			End If
			%>
			<dl>
				<dd>
					<a href="/jobs/view.asp?id_num=<%=arrRsJobsIng(0, i)%>"><%=arrRsJobsIng(3, i)%></a>
					<a href="javascript:" class="scrap <%=chk_scrap%>" onclick="fn_scrap('<%=g_LoginChk%>', '<%=arrRsJobsIng(0, i)%>', this); return false;"><span>��ũ��</span></a>
					<div class="recruit_info">
						<span><%=str_end_date%></span>
						<span><%=getExp(arrRsJobsIng(5, i))%></span>
						<span><%=getSchool3(arrRsJobsIng(4, i))%></span>
						<span><%=getAcName(arrRsJobsIng(6, i))%> &gt; <%=getAcName(arrRsJobsIng(7, i))%></span>
					</div>
					<% If rs_apply_selected(5) = "1" Then %>
					<a href="<%=rs_applyUrl%>" class="btn blue" target="_blank">Ȩ������ ����</a>
					<% Else %>
					<a href="/jobs/view.asp?id_num=<%=arrRsJobsIng(0, i)%>" class="btn blue">�¶��� ����</a>
					<% End If %>
				</dd>
			</dl>
			<% Next %>
		</div>
	</div>
	<% End If %>


</div>
