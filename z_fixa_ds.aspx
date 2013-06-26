<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
            //********************************************
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            var t_carkind = null;
            var t_carteam = null;
            var t_calctypes = null;
            aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx'], ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx']);
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_fixa_ds');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_fixa_ds',
                    options : [{/*[1]-會計年度*/
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {/*[2]-使用者*/
                        type : '0',
                        name : 'xname',
                        value : r_name
                    }, {/*1-[3],[4]*/
                        type : '1',
                        name : 'date'
                    },, {/*3-[7],[8]-廠商*/
                        type : '2',
                        name : 'tgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }, {/*4-[9]-車牌*/
                        type : '6',
                        name : 'xcarno'
                    }, {/*5-[10]-板台*/
                        type : '6',
                        name : 'xcarplateno'
                    }]
                });
                q_popAssign();
                q_langShow();

                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
            }

            function q_boxClose(t_name) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>