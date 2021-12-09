window.__datePickerArray = {};
;(function(w,$){
    w.customTags = $.fn.extend({
        'customTags': function($careerHTML) {
            var $this = $(this);
            var user = navigator.userAgent;
            var userArray = [
                ['ie ie8', user.indexOf('MSIE 8.0') != -1],
                ['ie ie9', user.indexOf('MSIE 9.0') != -1],
                ['ie ie10', user.indexOf('MSIE 10.0') != -1],
                ['ie ie11', user.indexOf('Trident/7.0') != -1],
                ['android', user.indexOf('Android') != -1],
                ['iphone', user.indexOf('iPhone') != -1],
                ['mobile', user.indexOf('Mobile') != -1]
            ];
            if (!$this.find('html').is('[class^="ie"]')) {
                for (var i = 0; i < userArray.length; i++) {
                    if (userArray[i][1]) {
                        $this.find('html').addClass(userArray[i][0]);
                        continue;
                    }
                }
            }
            $this.find('table, ul , dl, ol').each(function() {
                if ($(this).is('ul')) {
                    $(this).find('li:first').addClass('first');
                    $(this).find('li:last').addClass('last');
                }
            });
            ;(function(){
                /*
                * 커리어사이트 재직기간 추가를 위한 스크립트
                * /wwwconf/include/tools/js/career_calculator_renew_2016.js
                * 상단경로에서 에프터콜백개념으로 UI랩핑 진행
                */
                var $target = $careerHTML;
                if($target && $target.length){
                    var groupLength = 4; //career_calculator_renew_2016.js 뿌려주는 마크업기준 span 4개씩
                    $target.each(function(){
                        var $this = $(this);
                        var $cols = $this.find('>span');
                        var count = 0;
                        for (var i = 0; i < $cols.length; i+=groupLength) {
                            $cols.slice(i,i+groupLength).wrapAll('<div class="groupRow'+(count++)+'"></div>');
                        }
                        $this.find('[class^="groupRow"]').each(function(idx){
                            var $_this = $(this);
                            if(idx === 0 || idx === 1){
                                var $selectbox = $_this.find('.selectbox.s1');
                                var $txt = $_this.find('.txt:eq(0)');
                                var $selectbox2 = $_this.find('.selectbox.s2');
                                var $txt2 = $_this.find('.txt:eq(1)');
                                $_this.append('<div class="groupInner0"></div>');
                                $_this.append('<div class="groupInner1"></div>');
                                $_this.find('.groupInner0').prepend($selectbox,$txt);
                                $_this.find('.groupInner1').prepend($selectbox2,$txt2);
                            }
                        });
                    });
                }
            })();
            /* 셀렉트 */
            ;
            (function($) {
                var customSelectWrap = 'mmCstSelectWrap';
                var $html = '<div class="' + customSelectWrap + '"></div>';
                var $span = '<div class="virSelect"><span class="virSelectTxt"></span><span class="attacSelect"></span></div>';
                var $selectValRetuFun = function($this) {
                    var $thisVal = $this.find('option:selected').text();
                    var $thisSpan = $this.closest('.' + customSelectWrap).find('.virSelectTxt');
                    $thisSpan.text($thisVal).attr('data-value', $this.val());
                };
                $this.find('select.fnCustomSelect').each(function() {
                    if ($(this).closest('.'+customSelectWrap).length == 0) {
                        $(this).wrap($html);
                        $(this).closest('.' + customSelectWrap).append($span);
                    }
                    $selectValRetuFun($(this));
                });
                $this.find('select.fnCustomSelect').change(function() {
                    $selectValRetuFun($(this));
                });
            })(jQuery);
            /* fakfile */
            var fakFileVal = function($this) {
                var $thisVal = $this.val();
                var fak = $thisVal.lastIndexOf('\\') + 1;
                var txt = $thisVal != '' ? $thisVal.substring(fak, $thisVal.length) : '<span>파일을 등록해주세요.</span>';
                var $input = $this.closest('.fakFile').find('.fkf_input');
                $input.html(txt);
            };
            $this.find('.fakFile input[type="file"]').on({
                'change': function(e) {
                    fakFileVal($(this));
                },
            });
            $this.find('.fakFile input[type="file"]').each(function() {
                fakFileVal($(this));
            });
    		/* 범용 Swiper슬라이드*/
            ;(function(){
    			var $target = $this.find('.fnSlickSlider');
    			$target.each(function(){
    				var $this = $(this);
    				var params = $this.data('params');
                    var swiperSlideOptions = {};
    				if($.fn.uiSwiper){
    					$this.uiSwiper({
    						slideObj : $.extend(true, swiperSlideOptions, params)
    					});
    				}
    			});
                var $fnNotSlickSliderStatic = $this.find('.fnNotSlickSliderStatic');
                $fnNotSlickSliderStatic.each(function(){
                    var $this = $(this);
                    var $activeTarget = $this.find('.tp.active');
                    if($activeTarget.length){
                        $this[0].scrollLeft = $activeTarget[0].offsetLeft;
                    }
                });
    		})();

            $this.find('.fnDatePicker').each(function(){
                if($(this).data('name')){
                __datePickerArray[$(this).data('name')] = $(this).find('.ip input').datepicker();
                }
            });
            $this.find('.fnCustFort').each(function(){
                var $this = $(this);
                var data = $this.data('format');
                var n_data = data.replace(/([0-9]{4})-([0-9]{1,2})-([0-9]{2}).+/g, '$2.$3');
                $this.text('~ '+n_data)
            });
            ;(function(){
                if(!$this.find('html').is('.mobile')){
                    $this.find('a[href="javascript:;"]').each(function(){
                        var $this = $(this);
                        $this.removeAttr('href');
                    });
                }
            })();
            return $this;
        },
    });
})(window, jQuery || $);
