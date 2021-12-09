<%
If isArray(arrDetail) Then
	Dim act_nm, act_type, act_sYY, act_sMM, act_eYY, act_eMM, act_con
	act_nm		= arrDetail(9,0)
	act_type	= arrDetail(3,0)
	act_sYY		= arrDetail(5,0)
	act_sMM		= arrDetail(6,0)
	act_eYY		= arrDetail(7,0)
	act_eMM		= arrDetail(8,0)
	act_con		= arrDetail(11,0)
End If

If Len(act_sMM) = "1" Then act_sMM = "0" & act_sMM
If Len(act_eMM) = "1" Then act_eMM = "0" & act_eMM

Dim act_sDT, act_eDT
If isDate(act_sYY & "-" & act_sMM) Then act_sDT = act_sYY & "." & act_sMM
If isDate(act_eYY & "-" & act_eMM) Then act_eDT = act_eYY & "." & act_eMM
%>

<script type="text/javascript">
	$(document).ready(function () {
		var _act_type = '<%=act_Type%>';

		//인턴.대외활동 구분
		$('[name="select_rac_type"] option').each(function(i) {
			if(this.value == _act_type) {
				$('[name="select_rac_type"]').initSelectbox(i);
			}
		});
	});

	function fn_rac_s_div(obj) {
		if (obj.value.length == 7) {
			$("#rac_syear").val(obj.value.substr(0, 4));
			$("#rac_smonth").val(obj.value.substr(5, 2));
		} else {
			$("#rac_syear").val("");
			$("#rac_smonth").val("");
		}
	}
	function fn_rac_e_div(obj) {
		if (obj.value.length == 7) {
			$("#rac_eyear").val(obj.value.substr(0, 4));
			$("#rac_emonth").val(obj.value.substr(5, 2));
		} else {
			$("#rac_eyear").val("");
			$("#rac_emonth").val("");
		}
	}

	function _loc_fn_resume_save() {
		//로컬에서 한번더 벨리데이션체크후 기존 벨리데이션 실행
		if(!$('[name="rac_organization"]').val()){
			alert('기관 및 단체명을 입력해 주세요.');
			return false;
		}
		if(!$('[name="rac_type"]').val()){
			alert('인턴.대외활동을 선택해 주세요.');
			return false;
		}
		if(!$('[name="rac_sdate"]').val()){
			alert('시작년월을 입력해주세요');
			return false;
		}
		if(!$('[name="rac_edate"]').val()){
			alert('시작년월을 입력해주세요');
			return false;
		}
		if(!$('[name="rac_content"]').val()){
			alert('활동내용을 입력해주세요');
			return false;
		}
		<% If rsub_seq_no <> "" Then %>
		fn_resume_update();
		<% Else %>
			<% If rtype = "C" Then %>
			fn_resume_save2();
			<% Else %>
			fn_resume_save_imsi();
			<% End If %>
		<% End If %>
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap MT30">
				<div class="innerWrap">
					<div class="mmTit">활동기간</div>
					<div class="mmResumeVarTable borderNone">
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="rac_type" name="rac_type" value="<%=act_type%>" />
								<input type="hidden" id="rac_type_text" name="rac_type_text" value=" " />
								<input type="hidden" id="rac_syear" name="rac_syear" value="<%=act_sYY%>" />
								<input type="hidden" id="rac_smonth" name="rac_smonth" value="<%=act_sMM%>" />
								<input type="hidden" id="rac_eyear" name="rac_eyear" value="<%=act_eYY%>" />
								<input type="hidden" id="rac_emonth" name="rac_emonth" value="<%=act_eMM%>" />
								<input type="hidden" id="rac_location" name="rac_location" value=" " />

								<input type="hidden" id="rac_seq" name="rac_seq" value="<%=rsub_seq_no%>">

								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" name="rac_organization" placeholder="기관 및 단체명을 입력해 주세요." value="<%=act_nm%>" />
										</div>
									</div>
								</div>
								<div class="mmCol12">
									<select class="fnCustomSelect" name="select_rac_type" onchange="fn_sel_value_set(this, 'rac_type');">
										<option value="">인턴.대외활동을 선택해 주세요.</option>
										<option value="1">인턴</option>
										<option value="2">아르바이트</option>
										<option value="3">교내활동</option>
										<option value="4">동아리</option>
										<option value="5">자원봉사</option>
										<option value="6">대외활동</option>
										<option value="7">사회활동</option>
									</select>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" name="rac_sdate" placeholder="시작년월" value="<%=act_sDT%>" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_rac_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" name="rac_edate" placeholder="종료년월" value="<%=act_eDT%>" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_rac_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>

							<!-- 활동내용 및 직무관련 서술 : S-->
							<div class="mmTit MT55">활동내용 및 직무관련 서술</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<textarea name="rac_content" placeholder="활동 내용은(상황-과정-결과) 순으로 서술하는 것이 좋습니다."><%=act_con%></textarea>
										</div>
									</div>
								</div>
							</div>
							<!-- 활동내용 및 직무관련 서술 : E-->
						</div>

						<div class="mmBtnsWrap MT70 TXTC">
							<div class="mmRow">
								<div class="mmCol6">
									<a href="javascript:;" class="mmBtns navy outline FWB" onclick="fn_move();">취소하기</a>
								</div>
								<div class="mmCol6">
									<a href="javascript:;" class="mmBtns navy FWB" onclick="_loc_fn_resume_save();">저장하기</a>
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
