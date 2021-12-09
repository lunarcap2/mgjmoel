<%
If isArray(arrDetail) Then
	Dim car_nm, car_nm_hdn, car_sYY, car_sMM, car_eYY, car_eMM, car_ing, car_dept, car_part_skill, car_salary
	car_nm		= arrDetail(2,0)
	car_nm_hdn	= arrDetail(23,0)
	car_sYY		= arrDetail(8,0)
	car_sMM		= arrDetail(9,0)
	car_eYY		= arrDetail(10,0)
	car_eMM		= arrDetail(11,0)
	car_ing		= arrDetail(7,0)
	car_dept	= arrDetail(4,0)
	car_skill	= arrDetail(6,0)
	car_salary	= arrDetail(17,0)
End If

If car_nm_hdn	= "" Then car_nm_hdn	= "1"
If car_ing		= "" Then car_ing		= "1"

Dim car_sDT, car_eDT
If isDate(car_sYY & "-" & car_sMM) Then car_sDT = car_sYY & "." & car_sMM
If isDate(car_eYY & "-" & car_eMM) Then car_eDT = car_eYY & "." & car_eMM
%>

<script type="text/javascript">
	var jc1 = '';

	$(document).ready(function () {
		var _car_nm_hdn = '<%=car_nm_hdn%>';
		var _car_ing	= '<%=car_ing%>';
		
		//회사명 비공개
		if(_car_nm_hdn == '0') {
			$('#chk_career_hidden').attr('checked',true);
		}
		
		//재직중
		if(_car_ing == '2') {
			$('#C2').attr('checked',true);
		}
	});

	function fn_career_s_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents(".cloneTargetDivision").find("#experience_syear").val(obj.value.substr(0, 4));
			$(obj).parents(".cloneTargetDivision").find("#experience_smonth").val(obj.value.substr(5, 2));
		} else {
			$(obj).parents(".cloneTargetDivision").find("#experience_syear").val("");
			$(obj).parents(".cloneTargetDivision").find("#experience_smonth").val("");
		}
	}

	function fn_career_e_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents(".cloneTargetDivision").find("#experience_eyear").val(obj.value.substr(0, 4));
			$(obj).parents(".cloneTargetDivision").find("#experience_emonth").val(obj.value.substr(5, 2));
		} else {
			$(obj).parents(".cloneTargetDivision").find("#experience_eyear").val("");
			$(obj).parents(".cloneTargetDivision").find("#experience_emonth").val("");
		}
	}

	function fn_career_hidden_chk(obj) {
		if ($(obj).is(":checked")) {
			$(obj).parents(".cloneTargetDivision").find("#com_close_hdn").val("0");
		} else {
			$(obj).parents(".cloneTargetDivision").find("#com_close_hdn").val("1");
		}
	}

	function fn_career_sel_hdn(obj) {
		if($(obj).is(":checked")) {
			$(obj).parents(".cloneTargetDivision").find("#experience_eyear").val("");
			$(obj).parents(".cloneTargetDivision").find("#experience_emonth").val("");
			$(obj).parents(".cloneTargetDivision").find("#experience_edate").val("");
			$(obj).parents(".cloneTargetDivision").find('#experience_nowstatus_hdn').val('2');

			$(obj).parents(".cloneTargetDivision").find("#experience_edate").attr('disabled',true);

		}
		else {
			$(obj).parents(".cloneTargetDivision").find('#experience_nowstatus_hdn').val('1');

			$(obj).parents(".cloneTargetDivision").find("#experience_edate").attr('disabled',false);
		}
	}

	function fn_career_jc(_val) {
		$('#contents').attr('style','display:none;');
		$('#rsub_jc').attr('style','display:none;');

		$('#frm_resume').attr('onsubmit','return false;');

		if(_val == 'jc') {
			$('#rsub_step2').val('jc');
			$('#rsub_jc').attr('style','display:block;');

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
			<div class="resumCreateWrap MT30">
				<div class="innerWrap">

					<div class="mmResumeVarTable borderNone">
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="experience_syear" name="experience_syear" value="<%=car_sYY%>" />
								<input type="hidden" id="experience_smonth" name="experience_smonth" value="<%=car_sMM%>" />
								<input type="hidden" id="experience_eyear" name="experience_eyear" value="<%=car_eYY%>" />
								<input type="hidden" id="experience_emonth" name="experience_emonth" value="<%=car_eMM%>" />
								<input type="hidden" id="experience_nowstatus_hdn" name="experience_nowstatus_hdn" value="<%=car_ing%>" />
								<input type="hidden" id="com_close_hdn" name="com_close_hdn" value="<%=car_nm_hdn%>" />

								<input type="hidden" id="openis_hdn" name="openis_hdn" value="" />
								<input type="hidden" id="experience_salary5" name="experience_salary5" value="" />
								<input type="hidden" id="experience_duty" name="experience_duty" value="" />
								<input type="hidden" id="experience_corp_id" name="experience_corp_id" value="" />

								<div class="mmCol12 absRight absRight200">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=car_nm%>" id="experience_corp_name" name="experience_corp_name" placeholder="회사명을 입력해주세요" onkeyup="fn_kwSearchItem(this, 'company')" autocomplete="off"/>
										</div>
										<!-- 검색결과 창 : S -->
										<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->
										<div class="result_box" id="id_result_box">
										</div>
										<!-- 검색결과 창 : E -->
									</div>
									<div class="absTarget">
										<div class="mmCmmInput radiochk sm">
											<input type="checkbox" id="chk_career_hidden" onclick="fn_career_hidden_chk(this)" />
											<label for="chk_career_hidden" class="lb FWB">회사명 비공개</label>
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=car_sDT%>" id="experience_sdate" name="experience_sdate" placeholder="입사년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_career_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=car_eDT%>" id="experience_edate" name="experience_edate" placeholder="퇴사년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_career_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>
							<div class="MT30">
								<div class="mmCmmInput radiochk sm">
									<input type="checkbox" id="C2" onclick="fn_career_sel_hdn(this);" />
									<label for="C2" class="lb FWB">재직중</label>
								</div>
							</div>
							<div class="mmTit MT55">부서/직책</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=car_dept%>" name="experience_dept" placeholder="근무부서/직책을 입력해 주세요." />
										</div>
									</div>
								</div>
							</div>

							<!-- 직급/직책 : S
							<div class="mmTit MT55">직급/직책</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol6">
									<select class="fnCustomSelect">
										<option value="">직급 선택</option>
									</select>
								</div>
								<div class="mmCol6">
									<select class="fnCustomSelect">
										<option value="">직책 선택</option>
									</select>
								</div>
							</div>
							직급/직책 : E-->

							<!-- 직무 : S
							<div class="mmTit MT55">직무</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip" onclick="fn_career_jc('jc');">
											<div class="vInput">
												<div class="plhmsg">직무를 선택해 주세요.</div>
												<div class="mmBreadCom" id="div_jc" style="display: none;">
													<div class="tp">
														<span class="lb"></span>
														<div class="txts">
															<div class="tt"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							직무 : E-->

							<!-- 담당업무 : S-->
							<div class="mmTit MT55">담당 업무</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<textarea name="rca_part_skill" value="" placeholder="담당 업무를 입력해 주세요."><%=car_skill%></textarea>
										</div>
									</div>
								</div>
							</div>
							<!-- 담당업무 : E-->

							<!-- 프로젝트 수행경력 : S
								리스트가 있을때 : S
							<div class="carrList borderNone MT55">
								<div class="mmTit borderBottom">
									프로젝트 수행경력
									<span class="mmsTit sm right mmColorActiun">전체 경력년수 (16년 1개월)</span>
								</div>
								<div class="mmLstArea tp3">
									<div class="mmlstUl">
										경력사항 forEach : S
										<div class="mmLstTp">
											<div class="txts">
												<div class="tt mmColorBlue FWB">제오젠</div>
												<div class="st MT15">
													<span class="mmColorBlack FWB">입사</span> 2019년 07월 ~ <span
														class="mmColorBlack FWB">퇴사</span> 2020년 03월 <span
														class="mmColorBlue2">(9개월)</span>
												</div>
											</div>
										</div>
										경력사항 forEach : E
									</div>
								</div>
							</div>
								리스트가 있을때 : S
								리스트가 없을때 : S
							<div class="mmTit MT55">프로젝트 수행경력</div>
							<div class="mmResumeNoResult MT20">
								<div class="noResultBox MT20">
									<div class="inner">
										<div class="txts">프로젝트 수행경력이<br> 있을 경우에만 작성해 주세요. </div>
										<div class="mmBtnsWrap MT30">
											<a href="#" class="mmBtns blue2"><small class="MR10">+</small>작성하기</a>
										</div>
									</div>
								</div>
							</div>
								리스트가 없을때 : S
							프로젝트 수행경력 : E-->

							<!-- 연봉 : S-->
							<div class="mmTit MT55">연봉</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12 absRight absRight100">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" class="TXT" value="<%=car_salary%>" name="experience_salary_txt" placeholder="실 수령 연봉 금액을 입력해 주세요." />
										</div>
									</div>
									<div class="absTarget TXTR">
										<span class="mmColorBlack mmFontSize21 FWB MR20">만원</span>
									</div>
								</div>
							</div>
							<!-- 연봉 : E-->
						</div>

						<div class="mmBtnsWrap MT70 TXTC">
							<div class="mmRow">
								<div class="mmCol6">
									<a href="javascript:;" class="mmBtns navy outline FWB" onclick="fn_move();">취소하기</a>
								</div>
								<div class="mmCol6">
									<% If rsub_seq_no <> "" Then %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_update();">저장하기</a>
									<% Else %>
										<% If rtype = "C" Then %>
										<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save2();">저장하기</a>
										<% Else %>
										<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save_imsi();">저장하기</a>
										<% End If %>
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

<div id="rsub_jc" class="sub_page" style="display:none;">
<!--#include file="./rsub_regist_03_career_jc.asp"-->
</div>
