
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

    $('.easy-pie-chart.percentage').each(function(){
					var $box = $(this).closest('.infobox');
					var barColor = $(this).data('color') || (!$box.hasClass('infobox-dark') ? $box.css('color') : 'rgba(255,255,255,0.95)');
					var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#E2E2E2';
					var size = parseInt($(this).data('size')) || 50;
					$(this).easyPieChart({
						barColor: barColor,
						trackColor: trackColor,
						scaleColor: false,
						lineCap: 'butt',
						lineWidth: parseInt(size/10),
						animate: ace.vars['old_ie'] ? false : 1000,
						size: size
					});
				});

    $.resize.throttleWindow = false;
			
			  var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'210px'});
			  var data = [
				{ label: "Pajak Hotel",  data: parseInt($('#1101').text())},
				{ label: "pajak Restoran",  data: parseInt($('#1102').text())},
				{ label: "Pajak Hiburan",  data: parseInt($('#1103').text())},
				{ label: "Pajak Reklame",  data: parseInt($('#1104').text())},
				{ label: "Pajak Penerangan Jalan",  data: parseInt($('#1105').text())},
				{ label: "Pajak Parkir",  data: parseInt($('#1107').text())},
				{ label: "Pajak Air Tanah",  data: parseInt($('#1108').text())},
				{ label: "Pajak Burung Walet",  data: parseInt($('#1109').text())},
				{ label: "Pajak MBLB",  data: parseInt($('#1111').text())},
			  ]
			  function drawPieChart(placeholder, data, position) {
			 	  $.plot(placeholder, data, {
					series: {
						pie: {
							show: true,
							tilt:0.8,
							highlight: {
								opacity: 0.25
							},
							stroke: {
								color: '#fff',
								width: 2
							},
							startAngle: 2
						}
					},
					legend: {
						show: true,
						position: position || "ne", 
						labelBoxBorderColor: null,
						margin:[-30,15]
					}
					,
					grid: {
						hoverable: true,
						clickable: true
					}
				 })
			 }
			 drawPieChart(placeholder, data);
			
			 /**
			 we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
			 so that's not needed actually.
			 */
			 placeholder.data('chart', data);
			 placeholder.data('draw', drawPieChart);
			
			
			  //pie chart tooltip example
			  var $tooltip = $("<div class='tooltip top in'><div class='tooltip-inner'></div></div>").hide().appendTo('body');
			  var previousPoint = null;
			
			  placeholder.on('plothover', function (event, pos, item) {
				if(item) {
					if (previousPoint != item.seriesIndex) {
						previousPoint = item.seriesIndex;
						var tip = item.series['label'] + " : " + item.series['percent']+'%';
						$tooltip.show().children(0).text(tip);
					}
					$tooltip.css({top:pos.pageY + 10, left:pos.pageX + 10});
				} else {
					$tooltip.hide();
					previousPoint = null;
				}
				
			 });

    
        $(document).one('ajaxloadstart.page', function(e) {
					$tooltip.remove();
				});
			
			
			
			
				var data = [{
                        label: "Pajak Hotel",
                        data: [
                            [1, 18.9], 
                            [2, 18.7], 
                            [3, 18.4], 
                            [4, 19.3], 
                            [5, 19.5], 
                            [6, 19.3], 
                            [7, 19.4], 
                            [8, 20.2], 
                            [9, 19.8], 
                            [10, 19.9], 
                            [11, 20.4], 
                            [12, 20.1]]
                    },{
                        label: "Pajak Restoran",
                        data: [
                            [1, 12.9], 
                            [2, 28.7], 
                            [3, 14.4], 
                            [4, 14.3], 
                            [5, 12.5], 
                            [6, 13.3], 
                            [7, 14.4], 
                            [8, 25.2], 
                            [9, 16.8], 
                            [10, 19.9], 
                            [11, 60.4], 
                            [12, 10.1]]
                    },];

			
				var sales_charts = $('#sales-charts').css({'width':'100%' , 'height':'220px'});
				$.plot("#sales-charts", data, {
					hoverable: true,
					shadowSize: 0,
					series: {
						lines: { show: true },
						points: { show: true }
					},
					xaxis: {
						mode: "categories",
				        tickLength: 0,
                        axisLabel: "Bulan Ke-"
					},
					yaxis: {
						ticks: 10,
						tickDecimals: 2,
                        axisLabel: "Rupiah"
					},
					grid: {
						backgroundColor: { colors: [ "#fff", "#fff" ] },
						borderWidth: 1,
						borderColor:'#555'
					},
                    legend: { show: true, container: '#legendholder', noColumns:5 }
				});
              
});
  
