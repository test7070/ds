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

			var q_name = "carchg";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtTreno'];
			var bbmNum = new Array(['txtMinusmoney', 10, 0], ['txtPlusmoney', 10, 0]);
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			q_copy = 1;
			//ajaxPath = ""; //  execute in Root
			aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
			, ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
			, ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx']
            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
			, ['txtMinusitemno', 'lblMinusitem', 'chgitem', 'noa,item,acc1,acc2', 'txtMinusitemno,txtMinusitem,txtAcc1,txtAcc2', 'chgitem_b.aspx']
			, ['txtPlusitemno', 'lblPlusitem', 'chgitem', 'noa,item,acc1,acc2', 'txtPlusitemno,txtPlusitem,txtAcc1,txtAcc2', 'chgitem_b.aspx']
			, ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
			q_xchg = 1;
            brwCount2 = 20;
            
			function currentData() {}
			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				include : ['txtDatea','txtCustno','txtCust','cmbCarteamno','txtMinusitemno','txtMinusitem','txtMinusmoney'
					,'txtPlusitemno','txtPlusitem','txtPlusmoney','txtAcc1','txtAcc2','txtMemo'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in curData.include) {
							if (fbbm[i] == curData.include[j]) {
								isInclude = true;
								break;
							}
						}
						if (isInclude) {
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
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});

			//////////////////   end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
				// 1=Last  0=Top
			}///  end Main()

			function mainPost() {
				bbmMask = [['txtDatea', r_picd],['txtPaydate', r_picd]];
				q_mask(bbmMask);
				q_gt('carteam', '', 0, 0, 0, "");

				$('input[type="text"]').focus(function() {
					$(this).addClass('focus_b');
				}).blur(function() {
					$(this).removeClass('focus_b');
				});

				$('#txtAcc1').change(function() {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');
                });

				$("#cmbCarteamno").focus(function() {
					var len = $("#cmbCarteamno").children().length > 0 ? $("#cmbCarteamno").children().length : 1;
					$("#cmbCarteamno").attr('size', len + "");
				}).blur(function() {
					$("#cmbCarteamno").attr('size', '1');
				});
				
				$('#txtMinusitemno').blur(function(e) {
					$('#txtMinusitem').focus();
				});
				$('#txtPlusitemno').blur(function(e) {
					$('#txtPlusitem').focus();
				});
				$('#lblAccno').click(function () {
	            	q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
	       		});
				if(q_getPara('sys.project').toUpperCase()=='DH'){
                	$('.DH_hide').hide();
                }
			}
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}   /// end Switch
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'view_tre':
						var as = _q_appendData("view_tre", "", true);
						if (as[0] != undefined) {
							var link = location.href.toLowerCase().replace('carchg_ds','tre_ds').replace(/^(.*\?)(.*;)(.*;)(.*;)(.*;).*$/,"$1$2$3$4");
							//link +=  r_userno + ";" + r_name + ";" + q_time + ";noa='" + as[0].noa+ "';" + as[0].accy;
							link +=  "noa='" + as[0].noa+ "';" + as[0].accy;
							console.log(link);
							window.open(link);
						}
						break;
					case 'car2':
						var as = _q_appendData("car2", "", true);
						if (as[0] != undefined) {
							var t_acc1 = '1123.'+as[0].carownerno;
							$('#txtAcc1').val(t_acc1);
							var t_where = "where=^^ acc1='"+t_acc1+"' ^^";
							q_gt('acc', t_where , 0, 0, 0, "", r_accy+'_1');
						}						
						break;
					case 'acc':
						var as = _q_appendData("acc", "", true);
						if (as[0] != undefined) {
							$('#txtAcc2').val(as[0].acc2);
						}						
						break;
					case 'carteam':
						var as = _q_appendData("carteam", "", true);
						var t_item = "@";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						q_cmbParse("cmbCarteamno", t_item);
						if(abbm[q_recno]!=undefined)
							$("#cmbCarteamno").val(abbm[q_recno].carteamno);
						//q_gridv('tview', browHtm, fbrow, abbm, aindex, brwNowPage, brwCount);
						q_gridv('tview', browHtm, fbrow, abbm, brwNowPage, brwCount);
						if(q_getPara('sys.project').toUpperCase()=='DH'){
		                	$('.DH_hide').hide();
		                }
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();

						if (q_cur == 1 || q_cur == 2)
							q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

						break;
				}  /// end switch
			}
			function q_popPost(id) {
				switch(id) {
					case 'txtCarno':
						if((q_cur==1 || q_cur==2) && ($('#txtMinusitem').val() == '監理部扣款')){
							t_where = '';
							if($('#txtCarno').val() != ''){
								t_where = "where=^^ carno='"+$('#txtCarno').val()+"' ^^";
								q_gt('car2', t_where , 0, 0, 0, "", r_accy);
							}
							$('#txtDriverno').focus();
						}
						break;
					case 'txtMinusitemno':
						if((q_cur==1 || q_cur==2) && ($('#txtMinusitem').val() == '監理部扣款')){
							t_where = '';
							if($('#txtCarno').val() != ''){
								t_where = "where=^^ carno='"+$('#txtCarno').val()+"' ^^";
								q_gt('car2', t_where , 0, 0, 0, "", r_accy);
							}
							$('#txtMinusitem').focus();
						}
						break;
					case 'txtPlusitemno':
						if(q_cur==1 || q_cur==2){
							$('#txtPlusitem').focus();
						}
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('carchg_ds_s.aspx', q_name + '_s', "530px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				//curData.copy();
                _btnIns();
                //curData.paste();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').focus();
				$('#txtTreno').val('');//複製時排除
				$('#txtAccno').val('');//複製時排除
				
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				sum();
			}

			function btnPrint() {
				q_box('z_carchg_ds.aspx?;;;'+r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				$('#txtDatea').val($.trim($('#txtDatea').val()));
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock();
                    return;
                }
				$('#txtWorker').val(r_name);
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if(q_getPara('sys.project').toUpperCase()=='KD' || q_getPara('sys.project').toUpperCase()=='VA'){
					//一定要輸入會計科目
					if($('#txtAcc1').val().length==0){
						alert('請輸入會計科目。');
						return;						
					}
				}
				
				sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_carchg') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}
			function q_stPost() {
                if (q_cur == 2){
                	var t_noa = $('#txtNoa').val();
                	q_gt('view_tre', "where=^^charindex('"+t_noa+"',carchgno)>0^^", 0, 0, 0, "view_tre");
                }
            }

			function sum() {
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)/// popSave
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				if(q_getPara('sys.project').toUpperCase()=='DH'){
                	$('.DH_hide').hide();
                }
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(q_cur==1 || q_cur==2){
                    $('#txtDatea').datepicker();
                    $('#txtPaydate').datepicker();
                }
                else{
                    $('#txtDatea').datepicker('destroy');
                    $('#txtPaydate').datepicker('destroy');
                }
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
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
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 950px; 
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
                width: 950px;
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
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
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black; display:none;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;" class="DH_hide"><a id='vewCarteam'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:250px; color:black;"><a id='vewItem'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMinusmoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewPlusmoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewTreno'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="noa" style="text-align: center;display:none;">~noa</td>
						<td id="carteamno=cmbCarteamno" style="text-align: center;" class="DH_hide">~carteamno=cmbCarteamno</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="driver" style="text-align: left;">~driver</td>
						<td id="minusitem plusitem" style="text-align: left;">~minusitem ~plusitem</td>
						<td id="minusmoney,0,1" style="text-align: right;">~minusmoney,0,1</td>
						<td id="plusmoney,0,1" style="text-align: right;">~plusmoney,0,1</td>
						<td id="treno" style="text-align: left;">~treno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm" >
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
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
						<td colspan="2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="DH_hide"><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td class="DH_hide"><select id="cmbCarteamno" class="txt c1"> </select></td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td><input id="txtCarno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtDriverno"  type="text" style="float:left;width:50%;" />
							<input id="txtDriver"  type="text" style="float:left;width:50%;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMinusitem" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtMinusitemno"  type="text" style="float:left;width:30%;"/>
						<input id="txtMinusitem"  type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td><input id="txtMinusmoney"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno"  type="text" style="float:left;width:30%;"/>
							<input id="txtTgg"  type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td><input id="txtPaydate"  type="text" class="txt c1" /></td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="float:left;width:30%;"/>
							<input id="txtCust"  type="text" style="float:left;width:70%;"/>
						</td>
						<td><a class="lbl" style="text-align: left;">(應付立帳匯入)</a></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPlusitem" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtPlusitemno"  type="text" style="float:left;width:30%;"/>
						<input id="txtPlusitem"  type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td><input id="txtPlusmoney"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcc1" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtAcc1"  type="text" style="float:left;width:30%;"/>
						<input id="txtAcc2"  type="text" style="float:left;width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='5'><input id="txtMemo"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker"  type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblTreno' class="lbl"> </a></td>
						<td><input id="txtTreno"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

