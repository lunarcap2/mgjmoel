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

<!-- ��� -->
<!--#include virtual = "/include/gnb/topMenu.asp"-->
<!-- //��� -->
<div id="contents" class="sub_page">
  <div class="contents" style="padding:0 0 0">
    <div class="visual_area ai">
      <h2>AI �����˻�</h2>
    </div>
  </div>
  <div class="content">
		<div class="con_box">
			<div class="innerWrap">
            	<div class="as_ai MB80">
                <div style="height: 0.25rem; background: #0072bb;" class="MT50"></div>
                <div class="FONT18 colorBlack LINEHEIGHT18 MT20">
                    <span class="FWB">���ེ�� inFACE</span>�� ä���� ������ ��ȸ�� �ֱ����� ������� ��¿� �����ϱ� ���� ���ߵ� <span class="FWB">AI ä��ַ��</span> �Դϴ�.``
                    inFACE���� ��ȭ �� ����� ����Ǿ� �ִµ� Ư��, �������� AI ����� ���ԵǾ� �ֽ��ϴ�.
                    ���⿡�� <span class="FWB">�ڿ��� ó��(NLP)�� �ȸ��νı�� (Vision Analysis), ����м����(PI, Personality Insight)</span> ���� �ֽ��ϴ�.
                </div>
				<div style="height: 1px; background: #0072bb;" class="MT20"></div>
                <div class="crow ">
                    <div class="ccol12 TXTC MT50">
                        <img src="/images/imgAi001.png" style="width: 15.563rem;" class="amm" alt="" />
                        <div class="ami">������</div>
                        <div class="amic">
                            �ΰ����� NLP(Natural Language Processing)<br />
                            ����� ä��, AI�������� ������ �亯 ������<br />
                            �м��Ͽ� ������ ���մϴ�. ���� Vision Analysis,<br />
                            Voice Analysis, Verbal Analysis���� ����<br />
                            �������� ����, �µ� ���� �м��մϴ�.

                        </div>
                    </div>
                    <div class="ccol12 TXTC MT50">
                        <img src="/images/imgAi002.png" style="width: 15.563rem;" class="amm" alt="" />
                        <div class="ami">������</div>
                        <div class="amic">
                            �ΰ����� PI(Personality Insight) ����� ����<br />
                            ������ �������� ������ �����򰡸� ����<br />
                            �������� ������ ���ϰ� �˴ϴ�. �̷��� ������<br />
                            �������� AI�������� ������ ������ �����մϴ�.


                        </div>
                    </div>

					          <!--<div class="ccol12 TXTC MT50" style="position: relative;">
                        <img src="/images/imgAi005.png" style="width: 17rem;" class="amm" alt="" />
                        <div class="ami">�ڼҼ� <span style="color:#fff20e;">�ۼ�</span></div>
                        <div class="amic">
                            �� �ַ�ǿ��� �����ϴ� �ڱ�Ұ��� �ۼ� ���̵��
                            <div class="UNDERLINE FWB">30������ ������ ������ ���̾ƿ��� �����ϰ�,</div>
                            �׿� �°� �հ� ���ø� ������ �ۼ��� ������ �帳�ϴ�.

                        </div>
                    </div>
                    <div class="ccol12 TXTC MT50" style="position: relative;">
                        <img src="/images/imgAi006.png" style="width: 17rem;" class="amm" alt="" />
                        <div class="ami">AI �� /�м�</div>
                        <div class="amic">
                            60������ �� �����ͷ� ������ ����� Ȱ����
                             <div class="FWB">�ڼҼ� �ϼ��� ������ �����մϴ�.</div>
                             ������ �ۼ������� ���������� Ȯ���� �� �ֽ��ϴ�.
                        </div>
                    </div>
                    <div class="ccol12 TXTC MT50">
                        <img src="/images/imgAi007.png" style="width: 17rem;" class="amm" alt="" />
                        <div class="ami">�ڼҼ� <span style="color:#fff20e;">÷��</span></div>
                        <div class="amic">
                            ������ ǥ���� ���� ǥ��, �հ��ڼҼ���<br />
                            ǥ������, ���� �Ǽ��ϰ� �Ǵ� ����� ���� ����<br />
                            ���� �����μ� ���� ������ �յΰ�<br />
                            <div class="UNDERLINE FWB">���� ������ �� �� �ִ� ��ȸ�� �����մϴ�.</div>
                        </div>
                    </div>-->
                </div>
                <div class="TXTC MT60">
                    <% If g_LoginChk <> "1" Then %>
                    <a href="/my/login.asp" class=""><img src="/images/imgAi008.png" alt="�����߱� �ٷΰ���" /></a>
					<% Else %>
					<a href="./coupon_issue.asp" class=""><img src="/images/imgAi008.png" alt="�����߱� �ٷΰ���" /></a>
					<% End If %>
                </div>
                <div style="height: 1px; background: #ddd;" class="MT95"></div>
                <div class="FONT26 colorGry-1 FWB MT30 " style="font-size:1.825rem !important">
                    AI �����˻� �������
                    <a href="http://guide.reina.solutions/data/inFACE_%EC%9D%91%EC%8B%9C%EC%9E%90_%EA%B0%80%EC%9D%B4%EB%93%9C.pdf" class="FLOATR ML20" target="_blank"><img src="/images/imgAi004.png" style="width: 12.75rem;" alt="" /></a>
                </div>

                <div class="ca_smart_grid">
                    <!--<div class="cmm_tit">AI �����˻� �������</div>-->
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
              								<li>* �Է��Ͻ� ID/PW�� �����Ӱ� �Է��� �ּ���.</li>
              								<li>* �Է� �� �������� �ϱ� ��ư�� Ŭ���ϸ�  In FACE �ۿ��� ������ �����մϴ�.</li>
              								<li>* AI �����˻�_In FACE�� ������ 1ȸ �˻縸 �����մϴ�.</li>
              								<li>* ������ ������ �ڶ�ȸ ���� �Ŀ��� In FACE �ۿ��� �˻��� Ȯ���� �����մϴ�.</li>
              								<li>* �� ���� ��, ���� ������ ī�޶�, ����ũ �׽�Ʈ�� ������ �ּ���.</li>
              							</ul>
              						</dl>
					             </div>

                        <div class="cmmLst indent indent10 MT30">
                            <div class="cmmtp" style="color:#ec385e; font-weight:bold; margin-top:-20px;">�� �߱޵� ������ 24�ð� �̳� ������ ���� ���, ȸ���Ǿ� ����� �� �����ϴ�.</div>
                        </div>
				        </div> <!--ca_smart_grid -->

            </div>
			</div>
		</div>
	</div><!-- .content -->


  <!-- �ϴ� -->
<div id="footer">
	<div class="footer_area">
		<div class="footer_box">
			<img src="/images/safe_img.png" alt="���������� û������ �¶��� ä��ڶ�ȸ ���� Ȩ�������� [������� Ŀ����]�� ���� �� ���������� ����ϰ� �ֽ��ϴ�.Copyrights�� ������� Ŀ����. All rights reserved.">
			<p>
				2021 ���������庴 �¶��� ����ڶ�ȸ ���� Ȩ��������
				[������� Ŀ����]�� ���� �� ���������� ����ϰ� �ֽ��ϴ�.
				Copyrights&copy; ������� Ŀ����. All rights reserved.
			</p>
		</div><!-- .util-area -->
	</div><!-- .inner-wrap -->
</div>
<!-- //�ϴ� -->
