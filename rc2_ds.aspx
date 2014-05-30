<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "rc2";
            var q_readonly = ['txtNoa', 'txtTgg', 'txtWorker', 'txtWorker2','txtMoney','txtTax','txtTotal'];
            var q_readonlys = ['txtNoq'];
            var bbmNum = [
                ['txtMoney', 15, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 15, 0, 1]
            ];
            var bbsNum = [['txtMount', 15, 0, 1], ['txtPrice', 15, 3, 1], ['txtTotal', 15, 0, 1], ['txtTax', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
            aPop = new Array(
                ['txtTggno', 'lblTgg', 'tgg', 'noa,nick,tel,zip_invo,addr_comp', 'txtTggno,txtTgg,txtTel,txtPost,txtAddr', 'tgg_b.aspx'],
                ['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea', 'txtProductno_,txtProduct_', 'fixucc_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function sum() {
                //1@應稅,6@作廢,2@零稅率,3@內含,4@免稅,5@自訂
                var t_money = 0, t_tax = 0;
                var t_moneys,t_taxs;
                var t_taxtype = $('#cmbTaxtype').val();
                var t_taxrate = parseFloat(q_getPara('sys.taxrate'))/100;
                for(var i=0;i<q_bbsCount;i++){
                    t_moneys = round(q_mul(q_float('txtMount_'+i),q_float('txtPrice_'+i)),0);
                    switch(t_taxtype){
                        case '1':
                            t_taxs = round(q_mul(t_moneys,t_taxrate),0);
                            break;
                        case '2':
                            t_taxs = 0;
                            break;
                        case '3':
                            t_taxs = t_moneys - round(t_moneys/(1+t_taxrate),0);
                            t_moneys = t_moneys - t_taxs;
                            break;
                        case '4':
                            t_taxs = 0;
                            break;
                        case '5':
                            t_tax = ''+$('#txtTax_'+i).val();
                            t_tax = parseFloat(t_tax.length=0?"0":t_tax);
                            break;
                        case '6':
                            t_taxs = 0;
                            break;
                    }
                    t_money += t_moneys;
                    t_tax += t_taxs;
                    
                    $('#txtTotal_'+i).val(t_moneys);
                    $('#txtTax_'+i).val(t_taxs);
                }
                $('#txtMoney').val(t_money);
                $('#txtTax').val(t_tax);
                $('#txtTotal').val(q_add(t_money,t_tax));
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
               // q_cmbParse("cmbTranstyle", q_getPara('sys.transtyle'));
                q_cmbParse("cmbTypea", q_getPara('rc2.typea'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                
                $('#cmbTaxtype').change(function(e){
                   sum(); 
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
                    case 'btnDele':
                        var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                            var t_msg = "", t_paysale = 0;
                            for (var i = 0; i < as.length; i++) {
                                t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
                                if (t_paysale != 0)
                                    t_msg += String.fromCharCode(13) + '付款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
                            }
                            if (t_msg.length > 0) {
                                alert('已沖帳:' + t_msg);
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
                            var t_msg = "", t_paysale = 0;
                            for (var i = 0; i < as.length; i++) {
                                t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
                                if (t_paysale != 0)
                                    t_msg += String.fromCharCode(13) + '付款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
                            }
                            if (t_msg.length > 0) {
                                alert('已沖帳:' + t_msg);
                                Unlock(1);
                                return;
                            }
                        }
                        _btnModi();
                        Unlock(1);
                        $('#txtDatea').focus();
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var s1 = xmlString.split(';');
                abbm[q_recno]['accno'] = s1[0];
                $('#txtAccno').val(s1[0]);
                Unlock(1);
            }
            
            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                if (q_cur == 2)
                    $('#txtWorker2').val(r_name);
                sum();    
                    
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_rc2') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('rc2_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtMount_' + j).change(function() {
                            sum();
                        });
                        $('#txtPrice_' + j).change(function() {
                            sum();
                        });
                        $('#txtTotal_' + j).focusout(function() {
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
                $('#cmbTaxtype').val(1);
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                Lock(1, {
                    opacity : 0
                });
                var t_where = " where=^^ rc2no='" + $('#txtNoa').val() + "'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnModi', r_accy);
            }

            function btnPrint() {
                q_box("z_rc2p.aspx?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
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

            function q_appendData(t_Table) {
                dataErr = !_q_appendData(t_Table);
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
                Lock(1, {
                    opacity : 0
                });
                var t_where = " where=^^ rc2no='" + $('#txtNoa').val() + "'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnDele', r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }

            function q_popPost(s1) {
                switch (s1) {
                    default:
                        break;  
                }
            }
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 350px;
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
                width: 10%;
            }
            .tbbm .trX {
                background-color: #FFEC8B;
            }
            .tbbm .trY {
                background-color: #DAA520;
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
            .dbbs {
                width: 1500px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }

        </style>
    </head>
    <body>
        <!--#include file="../inc/toolbar.inc"-->
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td align="center" style="width:5%"><a id='vewTypea'> </a></td>
                        <td align="center" style="width:25%"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:30%"><a id='vewTgg'> </a></td>
                        <td align="center" style="width:25%"><a id='vewTotal'> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='typea=rc2.typea'>~typea=rc2.typea</td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='tggno tgg,4' style="text-align: left;">~tggno ~tgg,4</td>
                        <td align="right" id='total,0'>~total,0</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
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
                        <td><span> </span><a id='lblType' class="lbl"> </a></td>
                        <td>
                            <select id="cmbTypea" class="txt c1"> </select>
                        </td>
                        <td><span> </span><a id='lblDatea' class="lbl"> </a></td>
                        <td><input id="txtDatea" type="text" class="txt c1 ime"/></td>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblMon' class="lbl"> </a></td>
                        <td><input id="txtMon" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
                        <td><input id="txtInvono" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
                        <td><input id="txtTggno" type="text" class="txt c1" /></td>
                        <td colspan="2"><input id="txtTgg" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblTel' class="lbl"> </a></td>
                        <td colspan="2"><input id="txtTel" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblAddr' class="lbl btn"> </a></td>
                        <td><input id="txtPost" type="text" class="txt c1"/></td>
                        <td colspan='4' >
                            <input id="txtAddr" type="text" class="txt" style="width: 98%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblMoney' class="lbl"> </a></td>
                        <td>
                            <input id="txtMoney" type="text" class="txt num c1" />
                        </td>
                        <td><span> </span><a id='lblTax' class="lbl"> </a></td>
                        <td colspan='2' >
                            <input id="txtTax" type="text" class="txt num c1" style="width: 49%;" />
                            <select id="cmbTaxtype" class="txt c1" style="width: 49%;" ></select>
                        </td>
                        <td><span> </span><a id='lblTotal' class="lbl"> </a></td>
                        <td><input id="txtTotal" type="text" class="txt num c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblMemo' class="lbl"> </a></td>
                        <td colspan="6" >
                            <input id="txtMemo" type="text" class="txt c1" />
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td><input id="txtWorker2" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
                        <td colspan="2"><input id="txtAccno" type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs' style=' text-align:center'>
                <tr style='color:white; background:#003366;' >
                    <td align="center" style="width:1%;">
                        <input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
                    </td>
                    <td align="center" style="width:20px;"></td>
                    <td align="center" style="width:180px;"><a id='lblProductno'> </a></td>
                    <td align="center" style="width:220px;"><a id='lblProduct'> </a></td>
                    <td align="center" style="width:40px;"><a id='lblUnit'> </a></td>
                    <td align="center" style="width:80px;">數量</td>
                    <td align="center" style="width:80px;">單價</td>
                    <td align="center" style="width:80px;">金額</td>
                    <td align="center" style="width:80px;">稅額</td>
                    <td align="center" style="width:180px;">備註</td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td>
                        <input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
                        <input id="txtNoq.*" type="text" style="display:none;"/>
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
                        <input class="btn" id="btnProductno.*" type="button" value='' style="font-weight: bold;" />
                        <input id="txtProductno.*" type="text" class="txt" style="width:80%;"/>
                    </td>
                    <td>
                        <input type="text" id="txtProduct.*" class="txt c1"/>
                    </td>
                    <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                    <td><input id="txtMount.*" type="text" class="txt num c1" /></td>
                    <td><input id="txtPrice.*" type="text" class="txt num c1" /></td>
                    <td><input id="txtTotal.*" type="text" class="txt num c1" /></td>
                    <td><input id="txtTax.*" type="text" class="txt num c1" /></td>
                    <td>
                        <input id="txtMemo.*" type="text" class="txt c1"/>
                    </td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>