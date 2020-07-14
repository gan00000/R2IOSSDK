//
//  ConfigCoreUtil.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "ConfigCoreUtil.h"
#import "CCSkyHourHeader.h"
#import "AccountModel.h"


@interface ConfigCoreUtil()

@property (nonatomic, retain) NSString *m_stringsName;
@property (nonatomic, retain) NSBundle *m_stringsBundle;

@end

@implementation ConfigCoreUtil

static ConfigCoreUtil * configUtil;
static dispatch_once_t onceToken;

-(void)dealloc
{
    _m_stringsBundle = nil;
    _m_stringsName = nil;
    
//    [super dealloc];
}

+ (ConfigCoreUtil *)share
{
    
    dispatch_once(&onceToken,^{
        configUtil = [[ConfigCoreUtil alloc] init];
    });
    return configUtil;
}

- (instancetype)init
{
    self=[super init];
    if (self)
    {
        
        [self setBundleInfo];
    }
    return self;
}

-(void)saveAccountModels:(NSArray<AccountModel *> *) mAccountModelArray
{
    
    NSMutableArray  *dataList = [NSMutableArray array];
    for (AccountModel *m in mAccountModelArray) {
        //存储到NSUserDefaults
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject: m];
        [dataList addObject: data];
    }
   
     //转为不可变数组才能保存
    NSArray *nsdataArray = [NSArray arrayWithArray: dataList];
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nsdataArray forKey:@"Key_AccountModelArray"];
    [userDefaults synchronize];
}

-(NSMutableArray<AccountModel *> *)getAccountModels
{
    NSMutableArray  *accountModelList = [NSMutableArray array];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults objectForKey:@"Key_AccountModelArray"];
    for (NSData *data in array) {
        AccountModel *m = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [accountModelList addObject:m];
    }
    //根据创建时间排序
    [accountModelList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return -[((AccountModel *)obj1).lastLoginTime compare: ((AccountModel *)obj2).lastLoginTime];
    }];
    return accountModelList;
}




-(NSString *)getLocalizedStringForKey:(NSString *)key
{
    return NSLocalizedStringFromTableInBundle(key, _m_stringsName, _m_stringsBundle, nil);
}

#pragma mark - 初始化 Bundle
- (void)setBundleInfo {

    
    self.m_stringsBundle = [NSBundle mainBundle];
    self.m_stringsName = @"";
    
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:SDK_DEFAULT_BUNDLE_NAME withExtension:@"bundle"];
    
    if (bundleURL) {
        
        self.m_stringsBundle = [NSBundle bundleWithURL:bundleURL];
        
        NSURL *lprojBundleURL = [[NSBundle bundleWithURL:bundleURL] URLForResource:SDK_DATA.gameLanguage withExtension:@"lproj"];
        
        if (lprojBundleURL) {
            self.m_stringsBundle = [NSBundle bundleWithURL:lprojBundleURL];
            self.m_stringsName = @"Localizable";
        }
    }
}


@end
