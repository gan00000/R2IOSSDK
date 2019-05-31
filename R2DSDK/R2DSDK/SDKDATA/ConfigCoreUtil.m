//
//  ConfigCoreUtil.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "ConfigCoreUtil.h"
#import "R2DHeader.h"


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

+ (ConfigCoreUtil *)reader
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
