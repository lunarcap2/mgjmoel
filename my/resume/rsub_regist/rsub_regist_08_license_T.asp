<%
If isArray(arrDetail) Then
	Dim lic_nm, lic_agency, lic_sYY, lic_sMM
	lic_nm		= arrDetail(2,0)
	lic_agency	= arrDetail(3,0)
	lic_sYY		= arrDetail(4,0)
	lic_sMM		= arrDetail(5,0)
End If

Dim lic_DT
If isDate(lic_sYY & "-" & lic_sMM) Then lic_DT = lic_sYY & "." & lic_sMM
%>

<script type="text/javascript">
	function fn_license_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#license_year').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#license_month').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#license_year').val('');
			$(obj).parents('.cloneTargetDivision').find('#license_month').val('');
		}
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap ">
				<div class="innerWrap">

					<div class="mmResumeVarTable borderNone" name="div_license">
						<!-- 클론영역:S -->
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" name="license_code" value="" />
								<input type="hidden" id="license_year" name="license_year" value="<%=lic_sYY%>" />
								<input type="hidden" id="license_month" name="license_month" value="<%=lic_sMM%>" />

								<div class="mmCol12 ">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=lic_nm%>" id="license_name" name="license_name" placeholder="자격증명을 입력해 주세요." onkeyup="fn_kwSearchItem(this, 'license')" autocomplete="off" />
										</div>
										<!-- 검색결과 창 : S -->
										<!-- 상위 클래스 .mmCmmInput 안에 자식으로 있어야함 -->
										<div class="result_box" id="id_result_box">
										</div>
										<!-- 검색결과 창 : E -->
									</div>
								</div>
								<div class="mmCol12 ">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=lic_agency%>" name="license_org" placeholder="발행기관을 입력해 주세요." />
										</div>
									</div>
								</div>
								<div class="mmCol12">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=lic_DT%>" name="license_date" placeholder="취득년월" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_license_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>

							<% If rsub_seq_no = "" Then %>
							<div class="mmBtnsWrap MT30 TXTC">
								<div class="mmRow">
									<div class="mmCol7">
										<a href="#" class="mmBtns blue2 FWB" onclick="fn_append('<%=rsubGubun%>', this);"><small class="MR10">+</small>자격증 추가하기</a>
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
