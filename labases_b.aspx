<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
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
            var q_name = 'labases', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
            var t_sqlname = 'labases_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;
            var decbbs = [];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtCh_money',10,0,1],['txtCh_health',10,0,1]];
            var bbmMask = [];
            var bbsMask = [];

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if (!q_paraChk())
                    return;
                main();
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);

            }
            function mainPost() {
                q_getFormat();
                bbsMask = [['txtBirthday', r_picd], ['txtIndate', r_picd], ['txtOutdate', r_picd]];
                q_mask(bbsMask);
            }
            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    	$('#txtBirthday_' + j).datepicker();
		                $('#txtIndate_' + j).datepicker();
		                $('#txtOutdate_' + j).datepicker();
                        $('#txtId_' + j).change(function() {
                        	$(this).val($(this).val().toUpperCase());
                        	if ($(this).val().length > 0 && checkId($(this).val())!=1){
                        		Lock();
			            		alert(q_getMsg('lblId_s')+'錯誤。');
			            		Unlock();
			            		return;
			            	}
                        });
                    }
                }
                _bbsAssign();
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['namea']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;

            }

            function btnModi() {
                var t_key = q_getHref();
                if (!t_key)
                    return;
                _btnModi(1);
            }

            function boxStore() {
            }

            function refresh() {
                _refresh();
            }

            function sum() {
            }

            function q_gtPost(t_postname) { 
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
            }
			function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe
            }
            .tbbs {
                font-size: 12pt;
                color: blue;
                text-align: left;
                border: 1PX lightgrey solid;
                width: 100%;
                height: 100%;
            }
            .txt.c1 {
                width: 95%;
            }
            .td1 {
                width: 10%;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style="width: 100%;" >
				<tr style='color:white; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<!--<td align="center" style="width: 5%;"><a id='lblNoq'></a></td>-->
					<td align="center" class="td1"><a id='lblPrefix_s'> </a></td>
					<td align="center" class="td1"><a id='lblNamea_s'> </a></td>
					<td align="center" class="td1"><a id='lblBirthday_s'> </a></td>
					<td align="center" class="td1"><a id='lblId_s'> </a></td>
					<td align="center" class="td1"><a id='lblCh_money_s'> </a></td>
					<td align="center" class="td1"><a id='lblAs_health_s'> </a></td>
					<td align="center" class="td1"><a id='lblIndate_s'> </a></td>
					<td align="center" class="td1"><a id='lblOutdate_s'> </a></td>
					<!--<td align="center" ><a id='lblMemo'></a></td>-->
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
					<td >
					<input class="txt c1"  id="txtPrefix.*" type="text" />
					<input class="txt c1" id="txtNoq.*" type="hidden" />
					<input id="txtNoa.*" type="hidden" />
					</td>
					<td >
					<input class="txt c1" id="txtNamea.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtBirthday.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtId.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtCh_money.*" type="text" style="text-align: right;" />
					</td>
					<td >
					<input class="txt c1" id="txtAs_health.*" type="text" style="text-align: right;" />
					</td>
					<td >
					<input class="txt c1" id="txtIndate.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtOutdate.*" type="text"/>
					</td>
					<!--<td ><input class="txt c1" id="txtMemo.*" type="text"/></td>-->
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
