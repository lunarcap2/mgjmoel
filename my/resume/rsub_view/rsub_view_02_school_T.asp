<!-- container -->
<script>
	$(document).ready(function () {
		$('.fnDialogSchSelectButton').click(function () {
			$('[data-layerpop="fnDialogSchSelect"]').cmmLocLaypop({
				parentAddClass: 'dialogSchSelect',
			});
		});
	});
</script>

<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<!-- if 학력사항:S -->
			<% If isArray(arrSchool) Then %>
			<div class="carrList borderNone">
				<div class="innerWrap">
					<!-- 학력사항 forEach : S-->
					<%
					For i=0 To UBound(arrSchool,2)
						Dim sch_idx, sch_nm, sch_sYY, sch_sMM, sch_eYY, sch_eMM, sch_kind_nm, sch_etype, sch_etype_nm, sch_major
						sch_etype_nm = ""

						sch_idx		= arrSchool(0,i)
						sch_kind	= arrSchool(2,i)
						sch_nm		= arrSchool(3,i)
						sch_sYY		= arrSchool(7,i)
						sch_sMM		= arrSchool(8,i)
						sch_eYY		= arrSchool(10,i)
						sch_eMM		= arrSchool(11,i)
						sch_etype	= arrSchool(12,i)
						sch_major	= arrSchool(6,i)

						Select Case sch_etype
							Case "3" : sch_etype_nm = "재학"
							Case "4" : sch_etype_nm = "휴학"
							Case "5" : sch_etype_nm = "중퇴"
							Case "7" : sch_etype_nm = "졸업(예)"
							Case "8" : sch_etype_nm = "졸업"
						End Select

						If sch_kind = "3" Then
							sch_kind_nm = "고등학교"
						ElseIf sch_kind = "4" Or sch_kind = "5" Then
							sch_kind_nm = "대학(교)"
							sch_kind	= "4"
						ElseIf sch_kind = "6" Then
							sch_kind_nm = "대학원"
						End If

					%>
					<div class="fnSchollSortParse" data-params="<%=sch_kind%>">
						<div class="mmTit borderBottom MT40 <"><%=sch_kind_nm%></div>
						<div class="mmLstArea tp3">
							<div class="mmlstUl">
								<div class="mmLstTp">
									<div class="txts">
										<a href="javascript:;" onclick="fn_detail('<%=sch_kind%>','','<%=sch_idx%>');">
											<div class="tt mmColorBlue lg FWB inline"><%=sch_nm%></div>
											<div class="mmLbsWrap inline">
												<span class="mmLbs">
													<% If sch_kind <> "3" Then %>
													<%=sch_major%> /
													<% End If %>

													<%=sch_etype_nm%>
													</span>
											</div>
											<div class="st MT15 mmColorGray">
												<% If sch_nm <> "대입검정고시" Then %>
												입학 : <%=sch_sYY%>년 <%=sch_sMM%>월<span class="ln"></span>
												졸업 : <%=sch_eYY%>년 <%=sch_eMM%>월
												<% Else %>
												합격 : <%=sch_eYY%>년 <%=sch_eMM%>월
												<% End If %>
											</div>
										</a>

										<div class="right">
											<!--<a href="#;" class="mmIcoDelBtns" onclick="$(this).closest('.fnSchollSortParse').remove();" title="삭제"></a>-->
											<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=sch_idx%>','<%=rsubGubun%>');" title="삭제"></a>
										</div>
									</div>
								</div>
							</div>
							<div class="mmHr"></div>
						</div>
					</div>
					<% Next %>
					<!-- 학력사항 forEach : E-->
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="#" class="mmBtns navy FWB fnDialogSchSelectButton"><small class="MR10">+</small>학력사항 추가</a>
			</div>
			<!-- if 학력사항:E -->
			<!-- else 학력사항 :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">학력사항</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">작성된 학력사항이 없습니다.<br>등록해 주세요.</div>
							<div class="mmBtnsWrap MT30">
								<a href="#" class="mmBtns blue2 FWB fnDialogSchSelectButton"><small class="MR10">+</small>학력 추가하기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<% End If %>
			<!-- else 경력사항 :E -->

			<!-- 학교선택 팝업 :S -->
			<!-- 팝업 : S -->
			<div class="cmm_layerpop cmmLocLaypop" data-layerpop="fnDialogSchSelect">
				<div class="dialogSchSelectInner">
					<a href="javascript:;" class="layClosebtn MT30" title="팝업닫기"></a>
					<div class="schSelArea MT55">
						<div class="mmRow allPadding">
							<div class="mmCol6">
								<a href="#;" class="bx" onclick="fn_move('1','6');">대학원</a>
							</div>
							<div class="mmCol6">
								<a href="#;" class="bx" onclick="fn_move('1','5');">대학(4년)</a>
							</div>
							<div class="mmCol6">
								<a href="#;" class="bx" onclick="fn_move('1','4');">대학(2,3년)</a>
							</div>
							<div class="mmCol6">
								<a href="#;" class="bx" onclick="fn_move('1','3');">고등학교</a>
							</div>
						</div>
					</div>
					<div class="mmCmmLst indent indent15 TXTL MT70">
						<div class="cmmtp mmColorRed">*대부분의 구직자분들이 고등학교부터입력을 합니다.</div>
					</div>
				</div>
			</div>
			<!-- 팝업 : E -->
			<!-- 학교선택 팝업 :E -->


		</div>
		<!-- 이력서등록수정관련:S -->
	</div>
</div>
<!-- //container -->
