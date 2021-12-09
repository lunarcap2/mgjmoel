<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<!-- if 경력사항:S -->
			<% If isArray(arrLanguageUse) Or isArray(arrLanguageExam) Then %>
			<div class="carrList MT40">				
				<div class="innerWrap">
					<% If isArray(arrLanguageUse) Then %>
					<div class="mmTit borderBottom"> 회화 능력 </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl lastBorder">
							<!-- 경력사항 forEach : S-->
							<% For i=0 To UBound(arrLanguageUse,2)
								Dim lan_idx, lan_kinds, lan_ability
								lan_idx		= arrLanguageUse(0,i)
								use_lan		= getLanguageCode(arrLanguageUse(1,i))
								use_ability	= arrLanguageUse(2,i)

								Select Case use_ability
									Case "1" : use_ability = "상"
									Case "2" : use_ability = "중"
									Case "3" : use_ability = "하"
								End Select
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','1','<%=lan_idx%>');">
										<div class="tt mmColorBlue FWB inline MR10"><%=use_lan%></div>
										<div class="mmLbsWrap inline">
											<span class="mmLbs blue2"><%=use_ability%></span>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('1','<%=lan_idx%>','<%=rsubGubun%>');" title="삭제"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- 경력사항 forEach : E-->
						</div>
					</div>
					<% End If %>

					<% If isArray(arrLanguageExam) Then %>
					<div class="mmTit borderBottom MT60"> 공인 시험 </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- 경력사항 forEach : S-->
							<%
							If isArray(arrLanguageExam) Then
								For i=0 To UBound(arrLanguageExam,2)
									Dim exam_idx, exam_lan, exam_kinds, exam_ability, exam_ability_gb, exam_dt
									exam_idx		= arrLanguageExam(0,i)
									exam_lan		= getLanguageCode(arrLanguageExam(1,i))
									exam_kinds		= getLanguageExamCodeNm(arrLanguageExam(2,i))
									exam_ability	= arrLanguageExam(3,i)
									exam_ability_gb	= arrLanguageExam(6,i)
									exam_dt			= arrLanguageExam(4,i) & "년 " & arrLanguageExam(5,i) & "월"

									Select Case exam_ability_gb
										Case "1" : exam_ability_gb = "점"
										Case "2" : exam_ability_gb = "급"
									End Select
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','2','<%=exam_idx%>');">
										<div class="tt mmColorBlue FWB"><%=exam_lan%></div>
										<div class="st MT15 mmColorGray">
											<span class="mmColorBlack FWB"><%=exam_kinds%></span> <span class="ln"><%=exam_ability&exam_ability_gb%></span> <span class="ln"><%=exam_dt%></span>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('2','<%=exam_idx%>','<%=rsubGubun%>');" title="삭제"></a>
									</div>
								</div>
							</div>
							<%
								Next
							End If
							%>
							<!-- 경력사항 forEach : E-->
						</div>
					</div>
					<% End If %>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','');"><small class="MR10">+</small>어학 능력 추가</a>
			</div>
			<!-- if 경력사항:E -->
			<!-- else 경력사항 :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">어학 능력</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">작성된 어학 능력이 없습니다.<br>등록해 주세요.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','');"><small class="MR10">+</small>어학 능력 추가</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<% End If %>
			<!-- else 경력사항 :E -->


		</div>
		<!-- 이력서등록수정관련:S -->
	</div>
</div>
<!-- //container -->