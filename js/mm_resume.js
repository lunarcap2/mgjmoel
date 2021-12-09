$(document).ready(function(){
    var $this = $(this);
    $this.find('.fnTabsli').click(function(){
        var $self = $(this);
        var index = $self.index();
        $this.find('.fnTabsli').removeClass('active');
        $self.addClass('active');
        $this.find('.fnTabsDiv').removeClass('active');
        $this.find('.fnTabsDiv:eq('+index+')').addClass('active');
    });
});
