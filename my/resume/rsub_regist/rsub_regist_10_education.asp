<%
If isArray(arrDetail) Then
	Dim edu_nm, edu_agency, edu_sYY, edu_sMM, edu_eYY, edu_eMM
	edu_nm		= arrDetail(7,0)
	edu_agency	= arrDetail(2,0)
	edu_sYY		= arrDetail(3,0)
	edu_sMM		= arrDetail(4,0)
	edu_eYY		= arrDetail(5,0)
	edu_eMM		= arrDetail(6,0)
End If

Dim edu_sDT, edu_eDT
If isDate(edu_sYY & "-" & edu_sMM) Then edu_sDT = edu_sYY & "." & edu_sMM
If isDate(edu_eYY & "-" & edu_eMM) Then edu_eDT = edu_eYY & "." & edu_eMM
%>

<script type="text/javascript">
	function fn_education_s_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#academy_syear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#academy_smonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#academy_syear').val('');
			$(obj).parents('.cloneTargetDivision').find('#academy_smonth').val('');
		}
	}
	function fn_education_e_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#academy_eyear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#academy_emonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#academy_eyear').val('');
			$(obj).parents('.cloneTargetDivision').find('#academy_emonth').val('');
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

					<div class="mmResumeVarTable borderNone" name="div_education">
						<!-- 클론영역:S -->
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="academy_syear" name="academy_syear" value="<%=edu_sYY%>" />
								<input type="hidden" id="academy_smonth" name="academy_smonth" value="<%=edu_sMM%>" />
								<input type="hidden" id="academy_eyear" name="academy_eyear" value="<%=edu_eYY%>" />
								<input type="hidden" id="academy_emonth" name="academy_emonth" value="<%=edu_eMM%>" />

								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=edu_nm%>" name="academy_name" placeholder="교육명을 입력해 주세요." />
										</div>
									</div>
								</div>
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=edu_agency%>" name="academy_org_name" placeholder="교육기관을 입력해 주세요." />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=edu_sDT%>" name="academy_sdate" placeholder="시작년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_education_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=edu_eDT%>" name="academy_edate" placeholder="종료년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_education_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>
							
							<% If rsub_seq_no = "" Then %>
							<div class="mmBtnsWrap MT30 TXTC">
								<div class="mmRow">
									<div class="mmCol7">
										<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_append('<%=rsubGubun%>', this);"><small class="MR10">+</small>교육이수 추가하기</a>
									</div>
								</div>
							</div>
							<% End If %>

							<div class="mmHr MT35"></div>
						</div>
						<!-- 클론영역:E -->
					</div><!-- mmResumeVarTable -->
					<div class="mmBtnsWrap MT80 TXTC">
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


				</div>
			</div>
		</div>
		<!-- 이력서등록수정관련:S -->
	</div>
</div>
<!-- //container -->
