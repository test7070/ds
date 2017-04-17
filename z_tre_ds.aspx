<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			t_carteam = "";
			t_acomp = "";
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_tre_ds');
			});
			function q_gfPost() {
				q_gt('carteam', '', 0, 0, 0, "");
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'carteam':
						var as = _q_appendData("carteam", "", true);
						for ( i = 0; i < as.length; i++) {
							t_carteam = t_carteam + (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						q_gt('acomp', '', 0, 0, 0);
						break;
					case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_acomp += ',' + as[i].acomp;
                        }
                        loadFinish();
                        break;
				}
			}
			function loadFinish(){
				$('#q_report').q_report({
					fileName : 'z_tre_ds',
					options : [{
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					}, {//   1
						type : '1',   
						name : 'date'
					}, {//   2
						type : '2',
						name : 'tgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {//   3
						type : '2',
						name : 'driver',
						dbf : 'driver',
						index : 'noa,namea',
						src : 'driver_b.aspx'
					}, {//   4
						type : '8', //select
						name : 'xcarteam',
						value : t_carteam.split(',')
					}, {//   5
                        type : '5',
                        name : 'xacomp',
                        value : t_acomp.split(',')
                    }, {//   6   [10]
                        type : '6',
                        name : 'xtreno'
                    }]
				});
				q_popAssign();
                q_langShow();

				$('#txtDate1').mask('999/99/99');
				$('#txtDate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();
				$('#chkXcarteam').children('input').attr('checked', 'checked');
				$('#btnOk').hide();
                $('#btnOk2').click(function(e) {
                    switch($('#q_report').data('info').radioIndex) {
                        case 0:
                            $('#cmbPaperSize').val('LETTER');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 1:
                            $('#cmbPaperSize').val('LETTER');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 2:
                            $('#cmbPaperSize').val('A5');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 3:
                            $('#cmbPaperSize').val('A5');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 4:
                            $('#cmbPaperSize').val('');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 5:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                    }
                    $('#btnOk').click();
                });
			}
			function q_boxClose(t_name) {
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">

		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
			    <input type="button" id="btnOk2" style="float:left;font-size:16px;font-weight: bold;color: blue;cursor: pointer;width:50px;height:30px;" value="查詢"/>
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>

	</body>
</html>