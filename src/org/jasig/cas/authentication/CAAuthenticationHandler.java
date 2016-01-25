package org.jasig.cas.authentication;

import org.jasig.cas.authentication.handler.support.AbstractPreAndPostProcessingAuthenticationHandler;
import org.jasig.cas.authentication.handler.support.AbstractUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.principal.SimplePrincipal;

import javax.security.auth.login.AccountNotFoundException;
import java.security.GeneralSecurityException;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ZhangFengZhou
 * Date:  2016/1/21
 * Time: 16:42
 * Email:zhangfz3@asiainfo.com
 */
public class CAAuthenticationHandler extends AbstractPreAndPostProcessingAuthenticationHandler {

    @Override
    protected HandlerResult doAuthentication(Credential credential) throws GeneralSecurityException, PreventedException {
        CAAuthCredential caAuthCredential = (CAAuthCredential)credential;
        if(caAuthCredential.getSignedData() == null) {
            throw new AccountNotFoundException("SignedData is null.");
        } else {
                return new HandlerResult(this, new BasicCredentialMetaData(credential), new SimplePrincipal("JHXYYKT02"),  (List)null);
        }
    }

    @Override
    public boolean supports(Credential credential) {
        return credential instanceof CAAuthCredential;
    }
}
