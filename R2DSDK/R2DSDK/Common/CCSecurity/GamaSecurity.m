#import "GamaSecurity.h"
#import "GamaSecurityFunction.h"

@implementation GamaSecurity

+(NSString *)getEncryptStringFromString:(NSString *)beforeEncryptString
                                WithKey:(NSString *)key
                                     iv:(NSString *)iv
{
    NSData * decryptData=[beforeEncryptString dataUsingEncoding:NSUTF8StringEncoding];
    NSData * encryptData=[decryptData gama_AES128EncryptWithKey:key iv:iv];
    NSString * encryptStr=[GamaBase64Encoding encode:encryptData];
    return encryptStr;
}

+(NSString *)getDecryptStringFromString:(NSString *)beforeDecryptString
                                withKey:(NSString *)key
                                     iv:(NSString *)iv
{
    NSData * encryptData=[GamaBase64Encoding decode:beforeDecryptString];
    NSData * decryptData=[encryptData gama_AES128DecryptWithKey:key iv:iv];
    NSString * decryptStr=[[NSString alloc]initWithData:decryptData encoding:NSUTF8StringEncoding];
    return decryptStr;
}

+(NSData *)getEncryptDataFromData:(NSData *)beforeEncryptData
                          withKey:(NSString *)key
                               iv:(NSString *)iv
{
    return [beforeEncryptData gama_AES128EncryptWithKey:key iv:iv];
}

+(NSData *)getDecryptDataFromData:(NSData *)beforeDecryptData
                          withKey:(NSString *)key
                               iv:(NSString *)iv
{
    return [beforeDecryptData gama_AES128DecryptWithKey:key iv:iv];
}

+(NSString *)getEncodeStringFromData:(NSData *)beforeEncodeData
{
    return [GamaBase64Encoding encode:beforeEncodeData];
}

+(NSData *)getEncodeDataFromString:(NSString *)beforeEncodeString
{
    return [GamaBase64Encoding decode:beforeEncodeString];
}

@end


