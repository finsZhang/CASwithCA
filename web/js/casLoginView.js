/**
 * Created by fins on 2016/1/22.
 */
//����ԭ�ĺ�֤�������֤���ݰ�
function doDataProcess(){
    var Auth_Content = $("#original_jsp").val();
    var DSign_Subject = $("#RootCADN").val();
    if(Auth_Content==""){
        alert("��֤ԭ�Ĳ���Ϊ��!");
        //info("��ܰ��ʾ","��֤ԭ�Ĳ���Ϊ��!");
    }else{
        var InitParam = "<?xml version=\"1.0\" encoding=\"gb2312\"?><authinfo><liblist><lib type=\"CSP\" version=\"1.0\" dllname=\"\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"SERfR01DQUlTLmRsbA==\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U2h1dHRsZUNzcDExXzMwMDBHTS5kbGw=\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib><lib type=\"SKF\" version=\"1.1\" dllname=\"U0tGQVBJLmRsbA==\" ><algid val=\"SHA1\" sm2_hashalg=\"sm3\"/></lib></liblist></authinfo>";
        JITDSignOcx.Initialize(InitParam);
        if (JITDSignOcx.GetErrorCode() != 0) {
            alert("��ʼ��ʧ�ܣ������룺"+JITDSignOcx.GetErrorCode()+" ������Ϣ��"+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            //info("��ܰ��ʾ","��ʼ��ʧ�ܣ������룺"+JITDSignOcx.GetErrorCode()+" ������Ϣ��"+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            JITDSignOcx.Finalize();
            return false;
        }
        //����֤��Ϊһ��ʱ��������֤��ѡ���
        JITDSignOcx.SetCertChooseType(1);
        JITDSignOcx.SetCert("SC","","","",DSign_Subject,"");
        if(JITDSignOcx.GetErrorCode()!=0){
            alert("�����룺"+JITDSignOcx.GetErrorCode()+"��������Ϣ��"+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            //info("��ܰ��ʾ","�����룺"+JITDSignOcx.GetErrorCode()+"��������Ϣ��"+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
            JITDSignOcx.Finalize();
            return false;
        }else {
            var temp_DSign_Result = JITDSignOcx.DetachSignStr("",Auth_Content);
            if(JITDSignOcx.GetErrorCode()!=0){
                alert("�����룺"+JITDSignOcx.GetErrorCode()+"��������Ϣ��"+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
                //info("��ܰ��ʾ","�����룺"+JITDSignOcx.GetErrorCode()+"��������Ϣ��"+JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
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