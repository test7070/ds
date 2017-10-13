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
            q_tables = 's';
            var q_name = "payb";
            var q_readonly = ['txtAccno','txtNoa', 'txtMoney', 'txtTax', 'txtDiscount', 'txtTotal', 'txtWorker','txtWorker2'];
            var q_readonlys = ['txtRc2no','txtTypea','txtTotal','txtMoney'];
            var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtDiscount', 10, 0, 1]];
            var bbsNum = [['txtPrice', 10, 3, 1], ['txtDiscount', 10, 0, 1], ['txtMount', 10, 3, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //ajaxPath = "";
            aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtComp,txtNick', 'tgg_b.aspx']
            );
           
           
           	var t_acomp='',t_part='';
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                
                q_gt('acomp', '', 0, 0, 0, "");
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }
            function pop(form) {
                b_pop = form;
            }
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtIndate', r_picd],['txtDatea', r_picd], ['txtPaydate', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
                $('#txtPaydate').datepicker();
                $('#txtIndate').datepicker();
                $('#txtBdate').datepicker();
                $('#txtEdate').datepicker();

                q_cmbParse("cmbCno", t_acomp);
            	q_cmbParse("cmbPartno",'@,'+ t_part,'s');
                
                $("#cmbCno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                //........................下拉選單
                q_cmbParse("cmbKind", q_getPara('payb.kind'), 's');
                q_cmbParse("cmbXpayc", q_getMsg('payc').split('&').join());
                $("#cmbXpayc").change(function(e) {
                	if(q_cur==1 || q_cur==2)
					$('#txtPayc').val($(this).find(":selected").text()); 
				});
                //.........................
                //........................單據匯入
                $('#btnFix').click(function() {
                	Lock(1,{opacity:0});
                    var t_noa = $.trim($('#txtNoa').val());
					var t_tggno = $.trim($('#txtTggno').val());
					var t_bdate = $.trim($('#txtBdate').val());
					var t_edate = $.trim($('#txtEdate').val());
					t_bdate = "'"+t_bdate+"'";
					t_edate = t_edate.length==0?"char(255)":"'"+t_edate+"'";
					if(t_tggno.length>0){
						var t_where = "" ;
						//wmoney
						t_where += " where[1]=^^ (b.noa is null or b.noa='"+t_noa+"') and a.tggno='"+t_tggno+"' and ISNULL(a.wmoney,0)!=0 and (a.datea between "+t_bdate+" and "+t_edate+")^^" ;
						//cmoney
						t_where += " where[2]=^^ (b.noa is null or b.noa='"+t_noa+"') and a.tggno='"+t_tggno+"' and ISNULL(a.cmoney,0)!=0 and (a.datea between "+t_bdate+" and "+t_edate+")^^" ;
						//dmoney
						t_where += " where[3]=^^ (b.noa is null or b.noa='"+t_noa+"') and a.tggno='"+t_tggno+"' and ISNULL(a.dmoney,0)!=0 and (a.datea between "+t_bdate+" and "+t_edate+")^^" ;
						//emoney
						t_where += " where[4]=^^ (b.noa is null or b.noa='"+t_noa+"') and a.tggno='"+t_tggno+"' and ISNULL(a.emoney,0)!=0 and (a.datea between "+t_bdate+" and "+t_edate+")^^" ;
						//tax discount				
						t_where += " where[5]=^^ (b.noa is null or b.noa='"+t_noa+"') and a.tggno='"+t_tggno+"' and (ISNULL(a.tax,0)!=0 or ISNULL(a.discount,0)!=0) and (a.datea between "+t_bdate+" and "+t_edate+")^^" ;
						//money
						t_where += " where[6]=^^ (b.noa is null or b.noa='"+t_noa+"') and a.tggno='"+t_tggno+"' and a.[money]!=0 and (a.datea between "+t_bdate+" and "+t_edate+")^^" ;
						//plusmoney
						t_where += " where[7]=^^ (b.noa is null or b.noa='"+t_noa+"') and a.tggno='"+t_tggno+"' and a.[plusmoney]!=0 and (a.datea between "+t_bdate+" and "+t_edate+")^^" ;
						//minusmoney
						t_where += " where[8]=^^ (b.noa is null or b.noa='"+t_noa+"') and a.tggno='"+t_tggno+"' and a.[minusmoney]!=0 and (isnull(a.paydate,'') between "+t_bdate+" and "+t_edate+")^^";				
                    	//money  oil&etc
						t_where += " where[9]=^^ (b.noa is null or b.noa='"+t_noa+"') and c.noa='"+t_tggno+"' and a.[money]!=0 and (a.datea between "+t_bdate+" and "+t_edate+")^^" ;
                    	q_gt('payb_fix_ds',t_where, 0, 0, 0, "", r_accy);
					}else{
						alert('請輸入'+q_getMsg('lblTgg'));	
						Unlock(1);					
					}
                });
                //........................會計傳票
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
            		
                	
                	case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
                            t_acomp = " @ ";
                            for ( i = 0; i < as.length; i++) {
                                t_acomp = t_acomp + (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                            }
                        }
                        q_gt('part', '', 0, 0, 0, "");
                        break;
                	case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            t_part = "";
                            for ( i = 0; i < as.length; i++) {
                                t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                        }
                        q_gt(q_name, q_content, q_sqlCount, 1);
                        break;
                	case 'btnDele':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnDele();
                    	Unlock(1);
                		break;
                	case 'btnModi':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
	                	_btnModi();
	                	sum();
	                	Unlock(1);
                		$('#txtMemo').focus();
                		break;
                    case 'payb_fix_ds':
                        var as = _q_appendData("payb_fix_ds", "", true);
                        if (as[0] != undefined) {
                        	for(var i=0;i<as.length;i++){
                        		as[i].mount=1;
                        		as[i].price=as[i].money;
                        	}
                        	for (var i = 0; i < q_bbsCount; i++) {
			                    $('#btnMinus_' + i).click();
			                }	
			                if(q_getPara('sys.comp').substring(0, 2) == '日光'){
			                	q_gridAddRow(bbsHtm, 'tbbs', 'txtTablea,txtRc2no,txtTypea,txtMount,txtPrice,txtMoney,txtInvono,txtTax,txtDiscount,txtTotal,txtMemo,txtAcc1,txtAcc2', as.length, as
                        		, 'tablea,noa,typea,mount,price,money,invono,tax,discount,total,memo,acc1,acc2', 'txtRc2no', '');
			                }else{
			                	q_gridAddRow(bbsHtm, 'tbbs', 'txtTablea,txtRc2no,txtTypea,txtMount,txtPrice,txtMoney,txtInvono,txtTax,txtDiscount,txtTotal,txtMemo,txtAcc1,txtAcc2,cmbPartno', as.length, as
                        		, 'tablea,noa,typea,mount,price,money,invono,tax,discount,total,memo,acc1,acc2,carno', 'txtRc2no', '');
			                }
                        	
                        }else{
                        	alert('無資料。');
                        }
                        sum();
                        Unlock(1);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,10)=='checkRc2no'){
                    		var t_sel = parseFloat(t_name.split('_')[1]);
                    		var as = _q_appendData("paybs", "", true);
                       		if (as[0] != undefined) {
                       			alert('單號【'+as[0].rc2no+'】於【'+as[0].noa+'】已立帳。')
                       			Unlock(1);
                       		}else{
                       			checkRc2no(t_sel-1);	
                       		}
                    	}
                    	break;
                }
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString.split(";")[0];
                //abbm[q_recno]['payed'] = xmlString.split(";")[1];
                //abbm[q_recno]['unpay'] = xmlString.split(";")[2];
                //$('#txtAccno').val(xmlString.split(";")[0]);
                //$('#txtPayed').val(xmlString.split(";")[1]);
                //$('#txtUnpay').val(xmlString.split(";")[2]);
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
                if ($.trim($('#txtNick').val()).length == 0)
                    $('#txtNick').val($('#txtComp').val());
                $('#txtAcomp').val($('#cmbCno').find(":selected").text());

                if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
                if (!q_cd($('#txtPaydate').val())){
                	alert(q_getMsg('lblPaydate')+'錯誤。'); 
                	Unlock(1);
                	return;
                }
                if (!q_cd($('#txtIndate').val())){
                	alert(q_getMsg('lblIndate')+'錯誤。'); 
                	Unlock(1);
                	return;
                }
                sum();
                var yufu=false;
                for (var j = 0; j < q_bbsCount; j++) {
                	if($('#cmbKind_'+j).val()!=null){
	                	if($('#cmbKind_'+j).val().indexOf('預付')>-1){
	                		yufu=true;
	                		break;
	                	}
                	}
                }
                if(yufu &&$('#txtPayc').val().indexOf('預付')==-1)
                	$('#txtPayc').val($('#txtPayc').val()+' 預付');
                //存檔前檢查進貨單號有無重覆
                checkRc2no(q_bbsCount-1);
            }
            function checkRc2no(n){
            	if(n<0){
	                if(q_cur ==1){
	                	$('#txtWorker').val(r_name);
	                }else if(q_cur ==2){
	                	$('#txtWorker2').val(r_name);
	                }
	                var t_noa = trim($('#txtNoa').val());
	                var t_date = trim($('#txtDatea').val());
	                if (t_noa.length == 0 || t_noa == "AUTO")
	                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_payb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
	                else
	                    wrServer(t_noa);
            	}else{
            		var t_rc2no = $.trim($('#txtRc2no_'+n).val());
            		if(t_rc2no.length==0){
            			checkRc2no(n-1);
            		}else{
            			t_where=" where=^^ rc2no='"+t_rc2no+"' and noa!='"+$('#txtNoa').val()+"'^^";
                    	q_gt('paybs', t_where, 0, 0, 0, "checkRc2no_"+n, r_accy);
            		}
            	}
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('payb_s.aspx', q_name + '_s', "550px", "550px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_'+j).text(j+1);	
                	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                		$('#txtAcc1_' + j).change(function(e) {
		                    var patt = /^(\d{4})([^\.,.]*)$/g;
                    		$(this).val($(this).val().replace(patt,"$1.$2"));
                		});
                		$('#txtMount_' + j).change(function(e) {
	                        sum();
	                    });
	                    $('#txtPrice_' + j).change(function(e) {
	                        sum();
	                    });
                		$('#txtMoney_' + j).change(function(e) {
	                        sum();
	                    });
	                    $('#txtTax_' + j).change(function(e) {
	                        sum();  
	                    });
	                    $('#txtDiscount_' + j).change(function(e) {
	                        sum();
	                    });
                	}
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnModi',r_accy);
            }

            function btnPrint() {
				q_box("z_payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'z_payb', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (as['money'] ==0 && as['tax'] ==0 && as['acc1'] =='' && as['rc2no'].length==0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            	var t_money,t_total,t_tax,t_discount,t_taxrate;
            	var tot_money=0,tot_tax=0,tot_discount=0,tot_total=0;
            	for (var j = 0; j < q_bbsCount; j++) {
            		t_money = q_float('txtMount_'+j).mul(q_float('txtPrice_'+j)).round(0);
            		t_total = t_money.add(q_float('txtTax_'+j)).sub(q_float('txtDiscount_'+j))    		
            		$('#txtMoney_'+j).val(FormatNumber(t_money));
            		$('#txtTotal_'+j).val(FormatNumber(t_total));
            		if(q_getPara('sys.project')=='jr' && $('#txtTax_'+j).val().length==0){
            		     t_taxrate = parseFloat(q_getPara('sys.taxrate'))/100;
                         t_tax = t_money.mul(t_taxrate).round(0);
                         $('#txtTax_'+j).val(FormatNumber(t_tax));
                    }              
            		tot_money = tot_money.add(t_money);
            		tot_tax = tot_tax.add(q_float('txtTax_'+j));
            		tot_discount = tot_discount.add(q_float('txtDiscount_'+j));
            		tot_total = tot_total.add(t_total);
            	}
                $('#txtMoney').val(FormatNumber(tot_money));
            	$('#txtTax').val(FormatNumber(tot_tax));
            	$('#txtDiscount').val(FormatNumber(tot_discount));
            	$('#txtTotal').val(FormatNumber(tot_total));
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#btnFix').attr('disabled', 'disabled');
                } else {
                    $('#btnFix').removeAttr('disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
            	Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnDele',r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
			Number.prototype.round = function(arg) {
			    return Math.round(this * Math.pow(10,arg))/ Math.pow(10,arg);
			}
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			}
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""))
			        r2 = Number(arg2.toString().replace(".", ""))
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			}
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length } catch (e) { }
			    try { m += s2.split(".")[1].length } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			}
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2))
			    return (arg1 * m + arg2 * m) / m
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			}
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((arg1 * m - arg2 * m) / m).toFixed(n));
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 390px;
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
                width: 560px;
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
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs input[type="text"] {
                width: 95%;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"], select {
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
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewTotal'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewUnpay'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" />
						</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="unpay,0,1" style="text-align: right;">~unpay,0,1</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"   type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAcomp" class="lbl btn" > </a></td>
						<td>
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblBedate' class="lbl"> </a></td>
						<td><input id="txtBdate"  type="text" class="txt c1"/></td>
						<td><input id="txtEdate"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg"  class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtTggno" type="text" style="float:left; width:20%;"/>
						<input id="txtComp"  type="text" style="float:left; width:80%;"/>
						<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td>
						<input type="button" id="btnFix"  value="單據匯入">
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPayc' class="lbl"> </a></td>
						<td>
							<input id="txtPayc" type="text" style="float:left; width:75%;"/>
							<select id="cmbXpayc" style="float:left; width:20%;"> </select>
						</td>
						<td><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td><input id="txtPaydate" type="text" class="txt c1"/> </td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate" type="text" class="txt c1"/> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text"  class="txt num c1" /></td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblDiscount' class="lbl"> </a></td>
						<td><input id="txtDiscount" type="text"  class="txt num c1" /></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="4"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:120px;">#<a id='lblRc2no'> </a></td>
					<td align="center" style="width:60px;">#<a id='lblKind'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:80px;">*<a id='lblMoneys'> </a></td>
					<td align="center" style="width:120px;">#<a id='lblInvonos'> </a>/<a id='lblTaxs'> </a></td>
					<td align="center" style="width:80px;">*<a id='lblTotals'> </a></td>
					<td align="center" style="width:80px;">*<a id='lblPartnos'> </a></td>
					<td align="center" style="width:150px;">*<a id='lblMemos'> </a></td>
					<td align="center" style="width:120px;"><a id='lblBal'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*"  style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtRc2no.*" type="text"  style="float:left;width: 95%;"/>
						<input id="txtTypea.*" type="text"  style="float:left;width: 40%;"/>
						<input id="txtTablea.*" type="text"  style="float:left;visibility: hidden;width:0px;"/>
					</td>
					<td><select id="cmbKind.*" style="width: 95%;"> </select></td>	
					<td>
						<input id="txtMount.*" type="text" style="text-align: right; width: 95%;" />
						<input id="txtPrice.*" type="text" style="text-align: right; width: 95%;" />
					</td>
					<td>
						<input id="txtMoney.*" type="text" style="text-align: right; width: 95%;"/>
						<input id="txtDiscount.*" type="text" style="text-align: right; width: 95%;" />
					</td>
					<td>
						<input id="txtInvono.*" type="text" style="width: 95%;"/>
						<input id="txtTax.*" type="text" style="text-align: right; width: 95%;" />
					</td>
					<td><input id="txtTotal.*" type="text" style="text-align: right; width: 95%;" /></td>
					<td><select id="cmbPartno.*" style="float:left;width:95%;" > </select></td>
					<td>
						<input id="txtMemo.*" type="text" style=" width: 95%;"/>	
						<input class="btn"  id="btnAcc.*" type="button" value='.' style="float: left; font-weight: bold;width:1%;" />
						<input type="text" id="txtAcc1.*"  style="float: left;width:40%;"/>
						<input type="text" id="txtAcc2.*"  style="float: left;width:40%;"/>
					</td>
					<td><input id="txtBal.*" type="text" style="width: 95%;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

