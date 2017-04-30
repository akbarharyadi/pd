
$(document).on('turbolinks:load ready', function () {
    if (!ace.vars['touch']) {
        $('.chosen-select').chosen({ allow_single_deselect: true });
        $(window)
            .off('resize.chosen')
            .on('resize.chosen', function () {
                $('.chosen-select').each(function () {
                    var $this = $(this);
                    $this.next().css({ 'width': $this.parent().width() });
                })
            }).trigger('resize.chosen');
        $(document).on('settings.ace.chosen', function (e, event_name, event_val) {
            if (event_name != 'sidebar_collapsed') return;
            $('.chosen-select').each(function () {
                var $this = $(this);
                $this.next().css({ 'width': $this.parent().width() });
            })
        });
        
    };
    $('.date-picker').datepicker({
					autoclose: true,
					todayHighlight: true
				})
				//show datepicker when clicking on the icon
				.next().on(ace.click_event, function(){
					$(this).prev().focus();
				});

    $('.range-picker').daterangepicker({
					'applyClass' : 'btn-sm btn-success',
					'cancelClass' : 'btn-sm btn-default',
                    autoUpdateInput: false,
					locale: {
						applyLabel: 'Apply',
						cancelLabel: 'Cancel',
					}
				}, function(start, end) {
                    $('.range-picker').val(start.format('DD-MM-YYYY') + ' s/d ' + end.format('DD-MM-YYYY'));
                    $('.smart-listing-controls').submit();
                })
				.prev().on(ace.click_event, function(){
					$(this).prev().focus();
				});


    money_fields = $('input[data-role=money]')
    money_fields.autoNumeric('init', {
        digitGroupSeparator        : '.',
        decimalCharacter           : ',',
    });

    money_fields.keydown(function(e){
        if(e.keyCode == 13){
            $(this).autoNumeric('set', $(this).autoNumeric('get'))
        }
    });

});
  
