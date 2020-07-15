//
//  BJHTTPServiceEngine.m
//  BenjiaPro
//
//  Created by Marco on 2017/6/6.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJHTTPServiceEngine.h"
#import "BJServiceConfigurator.h"
#import "YYModel.h"
#import "AFHTTPSessionManager.h"
#import "BJBaseResponceModel.h"
#import "CCSkyHourHeader.h"

@interface BJHTTPServiceEngine ()

@property (nonatomic, strong) BJBaseHTTPEngine *httpEngine;

@end

@implementation BJHTTPServiceEngine

+ (instancetype)sharedInstance {
    
    static BJHTTPServiceEngine *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BJHTTPServiceEngine alloc] init];
        NSString *servicePath = [[BJServiceConfigurator sharedInstance] serverBaseUrl];
        instance.httpEngine = [[BJBaseHTTPEngine alloc] initWithBasePath:servicePath];
        [instance.httpEngine updateSessionWithBlock:^(AFHTTPSessionManager *session) {
            session.requestSerializer.timeoutInterval = 30;
//            [session.requestSerializer setValue:@"89bc52ca5b" forHTTPHeaderField:@"X-User-AppId"];
//            [session.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-User-Platform"];
//            [session.requestSerializer setValue:[NSString stringWithFormat:@"%@|%@|%@", [BJUtility modelName], [BJUtility systemVersion], [BJUtility idfa]] forHTTPHeaderField:@"X-User-Device"]; //机器名称 | 系统版本 | idfa
//            [session.requestSerializer setValue:[BJUtility appVersion] forHTTPHeaderField:@"X-App-Version"];
        }];
    });
    return instance;
}

#pragma mark -
+ (void)getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    
    [[BJHTTPServiceEngine sharedInstance].httpEngine getRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
        
#if ENABLE_REQUEST_LOG
        SDK_LOG(@"get: path = %@,requsetHeader = %@, params = %@, data = %@", task.originalRequest.URL,task.originalRequest.allHTTPHeaderFields,params, responseData);
#endif
        
        NSDictionary *responseDict = responseData;
        
        NSString *code = responseDict[@"status"];
        if (!code || (code.length > 0 && [code isEqualToString:@"ok"])) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            BJError *errorObject = [BJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
        
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
        SDK_LOG(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            BJError *errorObject = [[BJError alloc] init];
            errorObject.code = error.code;
            errorObject.message = @"请求失败"; //TODO:获取NSError里面的描述信息
            errorBlock(errorObject);
        }
    }];
}

+ (void)postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    
    [[BJHTTPServiceEngine sharedInstance].httpEngine postRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
        
#if ENABLE_REQUEST_LOG
        NSLog(@"post: path = %@,requsetHeader = %@,data = %@", task.originalRequest.URL,task.originalRequest.HTTPBody, responseData);
#endif
        
        NSDictionary *responseDict = responseData;
        
        NSString *code = responseDict[@"status"];
        if (!code || (code.length > 0 && [code isEqualToString:@"ok"])) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            BJError *errorObject = [BJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
        
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
        SDK_LOG(@"post: path = %@, error = %@,requsetHeader = %@", path, error,task.originalRequest.HTTPBody);
        if (errorBlock) {
            BJError *errorObject = [[BJError alloc] init];
            errorObject.code = error.code;
            errorObject.message = @"请求失败"; //TODO:获取NSError里面的描述信息
            errorBlock(errorObject);
        }
    }];
}

+ (void)fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    
    [[BJHTTPServiceEngine sharedInstance].httpEngine fileUploadWithFunctionPath:functionPath params:params fileData:fileData fileName:fileName mimeType:mimeType progressBlock:^(float progress) {
        
        if (progressBlock) {
            progressBlock(progress);
        }
        
    } successBlock:^(NSURLSessionDataTask *task, id responseData) {
        
        NSDictionary *responseDict = responseData;
        
        NSString *code = responseDict[@"status"];
        if (!code || (code.length > 0 && [code isEqualToString:@"ok"])) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            BJError *errorObject = [BJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
        
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
        SDK_LOG(@"file upload: path = %@, error = %@", functionPath, error);
        if (errorBlock) {
            BJError *errorObject = [[BJError alloc] init];
            errorObject.code = error.code;
            errorObject.message = @"请求失败"; //TODO:获取NSError里面的描述信息
            errorBlock(errorObject);
        }
        
    }];
    
}

+ (void)imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    
    [[BJHTTPServiceEngine sharedInstance].httpEngine imageUploadWithFunctionPath:functionPath params:params imageData:imageData imageName:imageName progressBlock:^(float progress) {
        
        if (progressBlock) {
            progressBlock(progress);
        }

    } successBlock:^(NSURLSessionDataTask *task, id responseData) {
        
        NSDictionary *responseDict = responseData;
        
        NSString *code = responseDict[@"status"];
        if (!code || (code.length > 0 && [code isEqualToString:@"ok"])) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            BJError *errorObject = [BJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (errorBlock) {
            BJError *errorObject = [[BJError alloc] init];
            errorObject.code = error.code;
            errorObject.message = @"请求失败"; //TODO:获取NSError里面的描述信息
            errorBlock(errorObject);
        }
    }];
}

+ (NSDictionary *)commDic
{
    NSDictionary * _commDic =
    @{
      // 公共的参数拼接
      @"packageName"      :     [CCSkyHourFunction getBundleIdentifier],
      
      @"adId"             :     [[CCSkyHourFunction getIdfa]       lowercaseString]? : @"",
      @"idfa"             :     [[CCSkyHourFunction getIdfa]       lowercaseString]? : @"",
      @"uuid"             :     [[CCSkyHourFunction getGamaUUID]     lowercaseString]? : @"",
      @"versionName"      :     [CCSkyHourFunction getBundleShortVersionString]? : @"",
      @"versionCode"      :     [CCSkyHourFunction getBundleVersion]? : @"",
      @"systemVersion"    :     [CCSkyHourFunction getSystemVersion]? : @"",
      @"deviceType"       :     [CCSkyHourFunction getDeviceType]? : @"",
      @"operatingSystem"  :     @"ios",
//      @"gameLanguage"     :     GAMA_GET_BOOL(GAMA_GMAE_mLanguge) ?[GamaFunction getServerLanguage]:[GamaFunction getServerLocaleStrWithGameLanguage:GAMA_GET_INFO(GAMA_GAME_LANGUAGE)]? : @"",
      @"osLanguage"       :     [CCSkyHourFunction getPreferredLanguage]? : @"",
      
//      @"loginTimestamp"   :     [GamaUserInfoModel shareInfoModel].timestamp ? : @"",
//      @"accessToken"      :     [GamaUserInfoModel shareInfoModel].accessToken ? : @"",
      @"uniqueId"         :     [[CCSkyHourFunction getGamaUUID] lowercaseString]? : @"",
      
//      @"spy_platForm"       :   GAMA_GET_INFO(@"gama_platForm")? :@"",
//      @"spy_advertiser"     :   GAMA_GET_INFO(@"gama_advertiser")? :@"",
      
      };
    
    return _commDic;
}

@end