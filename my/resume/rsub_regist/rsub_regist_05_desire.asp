<%
'지역코드 xml
Dim arrListArea1 '1차
arrListArea1 = getAreaList1() '/wwwconf/code/code_function_ac.asp

ReDim arrListArea2(UBound(arrListArea1)) '2차
For i=0 To UBound(arrListArea1)
	arrListArea2(i) = getArrJcList(arrListArea1(i,0))
Next

'업/직종 코드2차 전체
If isArray(arrResume) Then
	jc_code_all = arrResume(28, 0)
	ct_code_all = arrResume(29, 0)

	If jc_code_all <> "" Then
		jc_code_all = Split(jc_code_all, "|")
		jc1_set		= jc_code_all(0)
	End If

	If ct_code_all <> "" Then
		ct_code_all = Split(ct_code_all, "|")
		ct1_set		= ct_code_all(0)
	End If
End If

Dim work_style, work_style_nm, salary_amt, salary_amt_nm
If isArray(arrWorkType) Then work_style = arrWorkType(0, 0)
If isArray(arrResume) Then salary_amt = arrResume(10, 0)
%>

<script type="text/javascript">
	var jc1 = '';
	var ct1	= '';

	$(document).ready(function () {
		var work_style = "<%=work_style%>";
		var salary_amt = "<%=salary_amt%>";

		$('#sel_work_style').initSelectbox(work_style);
		$('#sel_salary_amt').initSelectbox(salary_amt);

		if (salary_amt == "98") {
			$('input:checkbox[id="C1"]').prop("checked", true);
			fn_chk_salay_code();
		}

		if(jc1 == '') {
			jc1 = '<%=jc1_set%>';
		}

		if(ct1 == '') {
			ct1 = '<%=ct1_set%>';
		}
	});

	// 면접후결정
	function fn_chk_salay_code() {
		if ($('#C1').is(":checked")) {
			$('#sel_salary_amt').attr('disabled',true);
			$('#sel_salary_amt').initSelectbox();
			$('#salary_amt').val("98");

		} else {
			$('#sel_salary_amt').attr('disabled',false);
			$('#salary_amt').val("");
		}
	}

	function fn_hope(_val) {
		$('#contents').attr('style','display:none;');
		$('#rsub_area').attr('style','display:none;');
		$('#rsub_ctjc').attr('style','display:none;');

		$('#frm_resume').attr('onsubmit','return false;');

		if(_val == 'area') {
			$('#rsub_step2').val('area');
			$('#rsub_area').attr('style','display:block;');
		}
		else if(_val == 'ctjc') {
			$('#rsub_step2').val('ctjc');
			$('#rsub_ctjc').attr('style','display:block;');

			fn_append_jc();
		}
		else {
			$('#rsub_step2').val('');
			$('#contents').attr('style','display:block;');

			$('#frm_resume').attr('onsubmit','');
		}
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap">
				<div class="innerWrap">

					<div class="mmResumeVarTable borderNone">
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision" style="border-top:0px;">
							<input type="hidden" id="work_style" name="work_style" value="<%=work_style%>" /> <!-- 고용형태 -->
							<input type="hidden" id="salary_amt" name="salary_amt" value="<%=salary_amt%>" /> <!-- 연봉코드 -->

							<div class="mmTit MT55">고용형태</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<select class="fnCustomSelect" id="sel_work_style" onchange="fn_sel_value_set(this, 'work_style');">
										<option value="">고용형태</option>
										<option value="1">정규직</option>
										<option value="2">해외취업</option>
										<option value="3">해외인턴/국제기구</option>
										<option value="4">정보화근로</option>
										<option value="5">병역특례</option>
										<option value="6">인턴직</option>
										<option value="7">계약직</option>
										<option value="9">파견직</option>
										<option value="10">위촉직</option>
										<option value="11">프리랜서</option>
									</select>
								</div>
							</div>
							<!-- 희망 연봉 : S -->
							<div class="mmTit MT55">희망 연봉</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<select class="fnCustomSelect" id="sel_salary_amt" onchange="fn_sel_value_set(this, 'salary_amt');">
										<option value="">희망연봉</option>
										<% Call putCodeToSelectOption("getSalayYear", 1, 99, "") %>
									</select>
								</div>
							</div>

							<div class="MT30">
								<div class="mmCmmInput radiochk sm">
									<input type="checkbox" id="C1" onclick="fn_chk_salay_code()" />
									<label for="C1" class="lb FWB">면접 후 결정</label>
								</div>
							</div>
							<!-- 희망 연봉 : E-->
							<!-- 희망 근무지 : S -->
							<div class="mmTit MT75">희망 근무지</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip" onclick="fn_hope('area');">
											<div class="vInput">
												<div class="mmBreadCom" id="div_hope_area">
													<% If isArray(arrArea) Then %>
													<div class="tp">
														<span class="lb"></span>
														<div class="txts">
															<% For i=0 To UBound(arrArea, 2) %>
															<div class="tt">
																<input type="hidden" name="resume_area" value="<%=arrArea(0, i)%>">
																<input type="hidden" name="resume_area_sub" value="<%=arrArea(1, i)%>">
																<%=getAcName(arrArea(0, i))%>> <%=getAcName(arrArea(1, i))%>
															</div>
															<% Next %>
														</div>
													</div>
													<% Else %>
													<div class="tp">
														<span class="lb"></span>
														<div class="txts">
															<div class="tt">
																<div class="plhmsg">희망지역을 선택해 주세요.</div>
															</div>
														</div>
													</div>
													<% End If %>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 희망 근무지 : E-->
							<!-- 희망 직무.산업 : S -->
							<div class="mmTit MT55">희망 직무.산업</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip" onclick="fn_hope('ctjc');">
											<!-- 수정 : S -->
											<!-- html append하는 id값 이동함 -->
											<div class="vInput">
												<div class="mmBreadCom" id="div_hope_ctjc">
													<% If isArray(jc_code_all) = False And isArray(ct_code_all) = False Then %>
													<div class="tp">
														<span class="lb"></span>
														<div class="txts">															
															<div class="tt">
																<div class="plhmsg">희망 직무.산업를 선택해 주세요.</div>
															</div>															
														</div>
													</div>
													<% End If %>

													<% If isArray(jc_code_all) Then %>
													<div class="tp">
														<span class="lb">직무</span>
														<div class="txts">
															<%
															For i=0 To UBound(jc_code_all)
																Dim arr_jc2_txt : arr_jc2_txt = getJobtype(jc_code_all(i))
															%>
															<div class="tt">
																<input type="hidden" name="resume_jobcode" value="<%=jc_code_all(i)%>">
																<%
																If isArray(arrJcKwd) Then
																	Dim arr_jc3_txt : arr_jc3_txt = ""
																	For ii=0 To UBound(arrJcKwd, 2)
																		If jc_code_all(i) = Left(arrJcKwd(0, ii), 4) Then
																			arr_jc3_txt = arr_jc3_txt & arrJcKwd(1, ii)

																			If ii < UBound(arrJcKwd, 2) Then
																				arr_jc3_txt = arr_jc3_txt & ", "
																			End If
																%>																
																<input type="hidden" name="jc_keyword" value="<%=arrJcKwd(0, ii)%>">
																<%
																		End If
																	Next
																End If
																%>
																<%=arr_jc2_txt%>> <%=arr_jc3_txt%>
															</div>
															<% Next %>
														</div>
													</div>
													<% End If %>

													<% If isArray(ct_code_all) Then %>
													<div class="tp">
														<span class="lb">산업</span>
														<div class="txts">
															<%
															For i=0 To UBound(ct_code_all)
																Dim arr_ct2_txt : arr_ct2_txt = getJobtype(ct_code_all(i))
															%>
															<div class="tt">
																<input type="hidden" name="resume_jobtype" value="<%=ct_code_all(i)%>">
																<%
																If isArray(arrCtKwd) Then
																	Dim arr_ct3_txt : arr_ct3_txt = ""
																	For ii=0 To UBound(arrCtKwd, 2)
																		If ct_code_all(i) = Left(arrCtKwd(0, ii), 4) Then
																			arr_ct3_txt = arr_ct3_txt & ", " & arrCtKwd(1, ii)
																%>
																<input type="hidden" name="ct_keyword" value="<%=arrCtKwd(0, ii)%>">
																<%
																		End If
																	Next
																End If
																%>
																<%=arr_ct2_txt%>> <%=arr_ct3_txt%>
															</div>
															<% Next %>
														</div>
													</div>
													<% End If %>
												</div>
											</div>
											<!-- <input type="text" placeholder="희망 직무.산업를 선택해 주세요." readonly /> -->
											<!-- 수정 : E -->
										</div>
									</div>
								</div>
							</div>
							<!-- 희망 직무.산업 : E-->
						</div>


						<div class="mmBtnsWrap MT80 TXTC">
							<div class="mmRow">
								<div class="mmCol6">
									<a href="javascript:;" class="mmBtns navy outline FWB" onclick="fn_move('<%=rsubGubun%>');">취소하기</a>
								</div>
								<div class="mmCol6">
									<% If rtype = "C" Then %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save2();">저장하기</a>
									<% Else %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save_imsi();">저장하기</a>
									<% End If %>
								</div>
							</div>
						</div>
					</div><!-- mmResumeVarTable -->


				</div>
			</div>
		</div>
		<!-- 이력서등록수정관련:S -->
	</div>
</div>
<!-- //container -->

<div id="rsub_area" class="sub_page" style="display:none;">
<!--#include file="./rsub_regist_05_desire_area.asp"-->
</div>

<div id="rsub_ctjc" class="sub_page" style="display:none;">
<!--#include file="./rsub_regist_05_desire_ctjc.asp"-->
</div>
