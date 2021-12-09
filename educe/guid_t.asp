<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<%

%>
<!--#include virtual = "/include/header/header.asp"-->
<script type="text/javascript">

</script>

<link rel="stylesheet" type="text/css" href="../css/cmm.css">
</head>

<body>

<!-- 상단 -->
<!--#include virtual = "/include/gnb/topMenu.asp"-->
<!-- //상단 -->
<div id="contents" class="sub_page">
  <div class="contents" style="padding:0 0 0">
    <div class="visual_area ai">
      <h2>AI 역량검사</h2>
    </div>
  </div>
  <div class="content">
		<div class="con_box">
			<div class="innerWrap">
            	<div class="as_ai MB80">
                <div style="height: 0.25rem; background: #0072bb;" class="MT50"></div>
                <div class="FONT18 colorBlack LINEHEIGHT18 MT20">
                    <span class="FWB">에듀스의 inFACE</span>는 채용의 공정한 기회를 주기위한 기업들의 노력에 부응하기 위해 개발된 <span class="FWB">AI 채용솔루션</span> 입니다.``
                    inFACE에는 고도화 된 기술이 적용되어 있는데 특히, 여러가지 AI 기술이 포함되어 있습니다.
                    여기에는 <span class="FWB">자연어 처리(NLP)와 안면인식기술 (Vision Analysis), 성향분석기술(PI, Personality Insight)</span> 등이 있습니다.
                </div>
				<div style="height: 1px; background: #0072bb;" class="MT20"></div>
                <div class="crow ">
                    <div class="ccol12 TXTC MT50">
                        <img src="/images/imgAi001.png" style="width: 15.563rem;" class="amm" alt="" />
                        <div class="ami">면접평가</div>
                        <div class="amic">
                            인공지능 NLP(Natural Language Processing)<br />
                            기술을 채용, AI면접관이 응시자 답변 내용을<br />
                            분석하여 역량을 평가합니다. 또한 Vision Analysis,<br />
                            Voice Analysis, Verbal Analysis등을 통해<br />
                            응시자의 역량, 태도 등을 분석합니다.

                        </div>
                    </div>
                    <div class="ccol12 TXTC MT50">
                        <img src="/images/imgAi002.png" style="width: 15.563rem;" class="amm" alt="" />
                        <div class="ami">성향평가</div>
                        <div class="amic">
                            인공지능 PI(Personality Insight) 기술을 통해<br />
                            정밀한 문항으로 구성된 성향평가를 토대로<br />
                            응시자의 성향을 평가하게 됩니다. 이러한 성향을<br />
                            바탕으로 AI면접관이 적절한 질문을 선택합니다.


                        </div>
                    </div>

					          <!--<div class="ccol12 TXTC MT50" style="position: relative;">
                        <img src="/images/imgAi005.png" style="width: 17rem;" class="amm" alt="" />
                        <div class="ami">자소서 <span style="color:#fff20e;">작성</span></div>
                        <div class="amic">
                            본 솔루션에서 제시하는 자기소개서 작성 가이드는
                            <div class="UNDERLINE FWB">30여개의 주제별 각각의 레이아웃을 제시하고,</div>
                            그에 맞게 합격 예시를 제시해 작성에 도움을 드립니다.

                        </div>
                    </div>
                    <div class="ccol12 TXTC MT50" style="position: relative;">
                        <img src="/images/imgAi006.png" style="width: 17rem;" class="amm" alt="" />
                        <div class="ami">AI 평가 /분석</div>
                        <div class="amic">
                            60만건의 빅 데이터로 딥러닝 기술을 활용한
                             <div class="FWB">자소서 완성도 점수를 제시합니다.</div>
                             본인의 작성수준을 직관적으로 확인할 수 있습니다.
                        </div>
                    </div>
                    <div class="ccol12 TXTC MT50">
                        <img src="/images/imgAi007.png" style="width: 17rem;" class="amm" alt="" />
                        <div class="ami">자소서 <span style="color:#fff20e;">첨삭</span></div>
                        <div class="amic">
                            부족한 표현에 대한 표시, 합격자소서의<br />
                            표절여부, 자주 실수하게 되는 맞춤법 서비스 등을<br />
                            제공 함으로서 실전 제출을 앞두고<br />
                            <div class="UNDERLINE FWB">최종 점검을 할 수 있는 기회를 제공합니다.</div>
                        </div>
                    </div>-->
                </div>
                <div class="TXTC MT60">
                    <% If g_LoginChk <> "1" Then %>
                    <a href="/my/login.asp" class=""><img src="/images/imgAi008.png" alt="쿠폰발급 바로가기" /></a>
					<% Else %>
					<a href="./coupon_issue.asp" class=""><img src="/images/imgAi008.png" alt="쿠폰발급 바로가기" /></a>
					<% End If %>
                </div>
                <div style="height: 1px; background: #ddd;" class="MT95"></div>
                <div class="FONT26 colorGry-1 FWB MT30 " style="font-size:1.825rem !important">
                    AI 역량검사 참여방법
                    <a href="http://guide.reina.solutions/data/inFACE_%EC%9D%91%EC%8B%9C%EC%9E%90_%EA%B0%80%EC%9D%B4%EB%93%9C.pdf" class="FLOATR ML20" target="_blank"><img src="/images/imgAi004.png" style="width: 12.75rem;" alt="" /></a>
                </div>

                <div class="ca_smart_grid">
                    <!--<div class="cmm_tit">AI 역량검사 참여방법</div>-->
            					<div class="cmm_stit underline"></div>
              					<ul class="lst">
              						<li class="tp tp1"><span class="txts"></span></li>
              						<li class="tp tp2"><span class="txts"></li>
              						<li class="tp tp3"><span class="txts"></li>
              						<li class="tp tp4"><span class="txts"></li>
                          <li class="tp tp5"><span class="txts"></li>
                          <li class="tp tp6"><span class="txts"></li>
              					</ul>

                        <div class="consul_moth2" style="display:block;">
              						<dl class="apply1">
              							<ul>
              								<li>* 입력하신 ID/PW는 자유롭게 입력해 주세요.</li>
              								<li>* 입력 후 계정생성 하기 버튼을 클릭하면  In FACE 앱에서 접속이 가능합니다.</li>
              								<li>* AI 역량검사_In FACE는 계정당 1회 검사만 가능합니다.</li>
              								<li>* 생성된 계정은 박람회 종료 후에도 In FACE 앱에서 검사결과 확인이 가능합니다.</li>
              								<li>* 앱 실행 시, 앱의 설명대로 카메라, 마이크 테스트를 진행해 주세요.</li>
              							</ul>
              						</dl>
					             </div>

                        <div class="cmmLst indent indent10 MT30">
                            <div class="cmmtp" style="color:#ec385e; font-weight:bold; margin-top:-20px;">※ 발급된 쿠폰이 24시간 이내 사용되지 않은 경우, 회수되어 사용할 수 없습니다.</div>
                        </div>
				        </div> <!--ca_smart_grid -->

            </div>
			</div>
		</div>
	</div><!-- .content -->


  <!-- 하단 -->
<div id="footer">
	<div class="footer_area">
		<div class="footer_box">
			<img src="/images/safe_img.png" alt="공공데이터 청년인턴 온라인 채용박람회 공식 홈페이지는 [취업포털 커리어]가 제작 및 유지보수를 담당하고 있습니다.Copyrightsⓒ 취업포털 커리어. All rights reserved.">
			<p>
				2021 전역예정장병 온라인 취업박람회 공식 홈페이지는
				[취업포털 커리어]가 제작 및 유지보수를 담당하고 있습니다.
				Copyrights&copy; 취업포털 커리어. All rights reserved.
			</p>
		</div><!-- .util-area -->
	</div><!-- .inner-wrap -->
</div>
<!-- //하단 -->
