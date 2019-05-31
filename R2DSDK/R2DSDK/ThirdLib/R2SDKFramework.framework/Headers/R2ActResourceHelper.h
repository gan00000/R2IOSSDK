//
//  R2ActResourceHelper.h
//  R2GMDemo
//
//  Created by luxing on 9/6/15.
//  Copyright (c) 2015 luxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R2ActResourceHelper : NSObject


+(NSBundle*)getR2ActBundle;

+(NSString*)pathForResource:(NSString*)name ofType:(NSString*)type;


+(NSString*)getLocalizedStringWithKey:(NSString*)key fallback:(NSString*)fallback;

+(NSString*)getR2SDKLocalizedStringWithKey:(NSString*)key andFallback:(NSString*)fallback;



+(NSString*)getLocalizedOKText;


/*  LOGIN VIEW   */

+(NSString*)getLocalizedUsernameHint;
+(NSString*)getLocalizedPasswordHint;
+(NSString*)getLocalizedLoginText;
+(NSString*)getLocalizedForgotPasswordText;
+(NSString*)getLocalizedRegisterText;


+(NSString*)getLocalizedEmptyUsernameError;
+(NSString*)getLocalizedEmptyPasswordError;
+(NSString*)getLocalizedPasswordLengthError;
+(NSString*)getLocalizedUsernameOrPasswordError;
+(NSString*)getLocalizedLoginFailedError;

/* END */


/*  REGISTER VIEW  */
+(NSString*)getLocalizedRegisterTitle;
+(NSString*)getLocalizedRegAccountHint;
+(NSString*)getLocalizedRegPasswordHint;
+(NSString*)getLocalizedSubmitText;


+(NSString*)getLocalizedRegisterFailedError;

+(NSString*)getLocalizedRegAccountFormatError;
+(NSString*)getLocalizedRegPasswordFormatError;

+(NSString*)getLocalizedAccountAlreadyExistsError;


+(NSString*)getLocalizedUserTerms;
+(NSString*)getLocalizedUserTermsRedPosition;

+(NSString *)getTermsURL;

/* END */


#pragma mark-< R2Uid Bind R2 Account>
/*  R2Uid Bind R2 Account  */
+(NSString*)getLocalizedEmailFormatError;
+(NSString*)getLocalizedUsernameNotExsits;
+(NSString*)getLocalizedPasswordError;
+(NSString*)getLocalizedEmptyusernameOrEmptyPassword;
+(NSString*)getLocalizedCurrentGameAccountBindAnotherR2Account;
+(NSString*)getLocalizedCurrentR2AccountBindAnotherGameAccount;
+(NSString*)getLocalizedEmailAlreadyExists;
+(NSString*)getLocalizedPasswordFormatError;
+(NSString*)getLocalizedUsernameAlreadyExist;
+(NSString*)getLocalizedAlreadyBindByEmail;
/* END */


/*  RESET PASSWORD  */

+(NSString*)getLocalizedForgotTitle;
+(NSString*)getLocalizedRegisteredEmail;
+(NSString*)getLocalizedResetPasswordHint;
+(NSString*)getLocalizedEmptyRegisteredEmailError;
+(NSString*)getLocalizedRegisteredEmailFormatError;
+(NSString*)getLocalizedEmailSentSuccessfully;
+(NSString*)getLocalizedFailedToReset;

/* END */





/* Login With Game Center Account */

+(NSString*)getLocalizedCreateNewAccount;
+(NSString*)getLocalizedSwitchAccount;
+(NSString*)getLocalizedDialogOK;
+(NSString*)getLocalizedDialogCancel;

/* END */



/* Login With Facebook Account */
+(NSString*)getLocalizedCreateNewAccountBasedOnFb;
+(NSString*)getLocalizedSwitchAccountBasedOnFb;
+(NSString*)getFbLocalizedDialogYES;
+(NSString*)getFbLocalizedDialogNO;

/* END */




/* Log With Game Center in the game */

+(NSString*)getLocalizedMsgBeforeShowingGcLoginScreen;


/* END */




@end
