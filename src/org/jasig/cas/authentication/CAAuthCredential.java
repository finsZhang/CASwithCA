package org.jasig.cas.authentication;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: ZhangFengZhou
 * Date:  2016/1/21
 * Time: 16:19
 * Email:zhangfz3@asiainfo.com
 */
public class CAAuthCredential implements Credential, Serializable {
    private static final long serialVersionUID = -700605081472810939L;
    private static final String PASSWORD_SUFFIX = "+password";
    @NotNull
    @Size(
            min = 1,
            message = "required.signedData"
    )
    private String signedData;
    @NotNull
    @Size(
            min = 1,
            message = "required.originalData"
    )
    private String originalData;
    @NotNull
    @Size(
            min = 1,
            message = "required.appId"
    )
    private String appId;

    public CAAuthCredential() {
    }

    public CAAuthCredential(String signedData, String originalData,String appId) {
        this.signedData = signedData;
        this.originalData = originalData;
        this.appId = appId;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getOriginalData() {
        return originalData;
    }

    public void setOriginalData(String originalData) {
        this.originalData = originalData;
    }

    public String getSignedData() {
        return signedData;
    }

    public void setSignedData(String signedData) {
        this.signedData = signedData;
    }

    public String getId() {
        return this.originalData;
    }
    public String toString() {
        return this.signedData;
    }

    public boolean equals(Object o) {
        if(this == o) {
            return true;
        } else if(o != null && this.getClass() == o.getClass()) {
            CAAuthCredential that = (CAAuthCredential)o;
            if(this.signedData != null) {
                if(!this.signedData.equals(that.signedData)) {
                    return false;
                }
            } else if(that.signedData != null) {
                return false;
            }

            if(this.originalData != null) {
                if(this.originalData.equals(that.originalData)) {
                    return true;
                }
            } else if(that.originalData == null) {
                return true;
            }

            return false;
        } else {
            return false;
        }
    }

    public int hashCode() {
        int result = this.originalData != null?this.originalData.hashCode():0;
        result = 31 * result + (this.signedData != null?this.signedData.hashCode():0);
        return result;
    }
}
