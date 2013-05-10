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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "tgg";
            var q_readonly = [['txtWorker'],['']];
            var bbmNum = [['txtDueday',10,0],['txtCredit',10,0]];
            var bbmMask = [['txtChkdate','999/99/99'],['txtStartdate','999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 20;
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });
			function currentData() {
			}
			currentData.prototype = {
				data : [],
				/*排除的欄位,新增時不複製*/
				exclude : [],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in curData.exclude) {
							if (fbbm[i] == curData.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
            	q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('tgg.typea'));
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
                q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				
				$("#cmbTypea").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#cmbTrantype").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#combPaytype").change(function(e) {
                	if(q_cur==1 || q_cur==2)
					 $('#txtPaytype').val($('#combPaytype').find(":selected").text()); 
				});
                $("#txtPaytype").focus(function(e) {
  					var n=$(this).val().match(/[0-9]+/g);
  					var input = document.getElementById ("txtPaytype");
		            if (typeof(input.selectionStart) != 'undefined' && n != null) {	  
		                input.selectionStart = $(this).val().indexOf(n);
		                input.selectionEnd =$(this).val().indexOf(n)+n.length+1;
		            }
				});
                $('#lblConn').click(function() {
                    t_where = "noa='" + $('#txtNoa').val() + "'";
                    q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('lblConn'));
                });

            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }  
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        if (q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('tgg_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
            function btnIns() {
            	if($('#Copy').is(':checked')){
            		curData.copy();
            	}
                _btnIns();
            	if($('#Copy').is(':checked')){
            		curData.paste();
            	}
            	$('#Copy').removeAttr('checked');
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtNoa').attr('readonly','readonly');
                $('#txtComp').focus();
            }

            function btnPrint() {
                q_box('z_tggtran.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "90%", "600px", q_getMsg("popPrint"));
            }
            function btnOk() {
                if($('#txtChkdate').val().length>0 && !q_cd($('#txtChkdate').val()))
            		alert(q_getMsg('lblChkdate')+'錯誤。');  
            	if($('#txtStartdate').val().length>0 && !q_cd($('#txtStartdate').val()))
            		alert(q_getMsg('lblStartdate')+'錯誤。');
            		
            	if (dec($('#txtCredit').val()) > 9999999999)
                    t_err = t_err + q_getMsg('msgCreditErr') + '\r'; 
                    		           
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                $('#txtWorker' ).val(r_name);
                var t_noa = trim($('#txtNoa').val());
                if (t_noa.length == 0)
                    q_gtnoa(q_name, t_noa);
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
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
			#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 250px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 700px;
                /*margin: -1px;        
                border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='nick' style="text-align: center;">~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan="3"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNick' class="lbl"> </a></td>
						<td><input id="txtNick" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBoss' class="lbl"> </a></td>
						<td><input id="txtboss" type="text" class="txt c1"/> </td>
						<td><span> </span><a id='lblHead' class="lbl"> </a></td>
						<td><input id="txthead" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td><input id="txtStatus" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan="2"><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMobile" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblConn" class="lbl btn" > </a></td>
						<td><input id="txtConn" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblConntel' class="lbl"> </a></td>
						<td><input id="txtConntel" type="text" class="txt c1"/>	</td>
						<td><span> </span><a id='lblConnfax' class="lbl"> </a></td>
						<td><input id="txtConnfax" type="text" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea"  class="txt c1"> </select></td>
						<td><span> </span><a id='lblTeam' class="lbl"> </a></td>
						<td><input id="txtTeam"   type="text"  class="txt c1"/>	</td>
						<td><span> </span><a id="lblGrp"  class="lbl btn"> </a></td>
						<td>
							<input id="txtGrpno" type="text" style="float:left; width:40%;"/>
							<input id="txtGrpname" type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_fact' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_fact" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_fact"  type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_comp' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_comp" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_comp"  type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_invo' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_invo" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_invo"  type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_home' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_home" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_home"  type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr class="tr12">
						<td><span> </span><a class="lbl">E-mail</a></td>
						<td colspan="5"><input id="txtEmail" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCredit" class="lbl btn"> </a></td>
						<td><input id="txtCredit" type="text" class="txt num c1" />	</td>
						<td><span> </span><a id="lblSales" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" style="float:left; width:40%;"/>
							<input id="txtSales" type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblService' class="lbl"> </a></td>
						<td colspan="3"><input id="txtService"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblUacc4' class="lbl btn"> </a></td>
						<td><input id="txtUacc4" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblChkdate' class="lbl"> </a></td>
						<td><input id="txtChkdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblStartdate' class="lbl"> </a></td>
						<td><input id="txtStartdate" type="text" class="txt c1" />	</td>
						<td><span> </span><a id='lblUacc1' class="lbl btn"> </a></td>
						<td><input id="txtUacc1"    type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDueday' class="lbl"> </a></td>
						<td><input id="txtDueday" type="text" class="txt num c1"/>	</td>
						<td><span> </span><a id='lblGetdate' class="lbl"> </a></td>
						<td><input id="txtGetdate" type="text" class="txt c1"/>	</td>
						<td><span> </span><a id='lblUacc2' class="lbl btn"> </a></td>
						<td><input id="txtUacc2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td><select id="combPaytype" style="float:left; width:20px;"> </select>
							<span> </span><a id='lblTrantype' class="lbl"> </a>
						</td>
						<td><select id="cmbTrantype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblUacc3' class="lbl btn"> </a></td>
						<td><input id="txtUacc3"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><textarea id="txtMemo" style="width:100%; height:100px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td align="right">
							<input id="Copy" type="checkbox" />
							<span> </span><a id="lblCopy" class="lbl"></a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
