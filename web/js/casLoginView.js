/**
 * Created by fins on 2016/1/22.
 */
//根据原文和证书产生认证数据包
function doDataProcess(){
    var Auth_Content = $("#original_jsp").val();
    var DSign_Subject = $("#RootCADN").val();
    if(Auth_Content==""){
        alert("认证原文不能为空!");
        //info("温馨提示","认证原文不能为空!");
    }else{
        var InitParam = "<?xml version=\"1.0\" encoding=\"gb2312\"?><authinfo><liblist><lib type=\"CSP\" version=\"1.0\" dllname=\"\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"SERfR01DQUlTLmRsbA==\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U2h1dHRsZUNzcDExXzMwMDBHTS5kbGw=\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U0tGQVBJLmRsbA==\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib></liblist></authinfo>";
        JITDSignOcx.Initialize(InitParam);
        if (JITDSignOcx.GetErrorCode() != 0) {
            alert("初始化失败，错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            //info("温馨提示","初始化失败，错误码："+JITDSignOcx.GetErrorCode()+" 错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            JITDSignOcx.Finalize();
            return false;
        }
        //控制证书为一个时，不弹出证书选择框
        JITDSignOcx.SetCertChooseType(1);
        JITDSignOcx.SetCert("SC","","","",DSign_Subject,"");
        if(JITDSignOcx.GetErrorCode()!=0){
            alert("错误码："+JITDSignOcx.GetErrorCode()+"　错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            //info("温馨提示","错误码："+JITDSignOcx.GetErrorCode()+"　错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            JITDSignOcx.Finalize();
            return false;
        }else {
            var temp_DSign_Result = JITDSignOcx.DetachSignStr("",Auth_Content);
            if(JITDSignOcx.GetErrorCode()!=0){
                alert("错误码："+JITDSignOcx.GetErrorCode()+"　错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
                //info("温馨提示","错误码："+JITDSignOcx.GetErrorCode()+"　错误信息："+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
                JITDSignOcx.Finalize();

                return false;
            }
            JITDSignOcx.Finalize();
            $("#signed_data").val(temp_DSign_Result);
        }
    }
}

function login() {
    doDataProcess();
    $("#loginForm").submit();
}