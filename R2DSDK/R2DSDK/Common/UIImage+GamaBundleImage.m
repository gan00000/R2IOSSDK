

#import "UIImage+GamaBundleImage.h"
#import "CCSkyHourHeader.h"

@implementation UIImage (EFNBundleImage)

+ (UIImage *)gama_imageNamed:(NSString *)imageName {
    
    if (imageName.length <= 0) {
        return nil;
    }
    
    NSURL *defaultBundleUrl = [[NSBundle mainBundle] URLForResource:SDK_DEFAULT_BUNDLE_NAME withExtension:@"bundle"];
    if (!defaultBundleUrl) {
        UIImage *resultImage = [UIImage imageNamed:imageName];
        return resultImage;
    }
    return [self gama_imageNamed:imageName inBundle:[NSBundle bundleWithURL:defaultBundleUrl]];
}

+ (UIImage *)gama_imageNamed:(NSString *)imageName inBundle:(NSBundle *)bundle {
    
    UIImage *resultImage = nil;
    
    NSString *imgPath = [bundle.resourcePath stringByAppendingPathComponent:imageName];
    resultImage = [UIImage imageWithContentsOfFile:imgPath];
    
    if (!resultImage) {
        resultImage = [UIImage imageNamed:imageName];
    }
    return resultImage;
}

+ (UIImage *)gama_imageNamed:(NSString *)imageName inBundle:(NSBundle *)bundle inFolder:(NSString *)folder
{
    UIImage *resultImage = nil;
    
    NSBundle *myBundle = nil;
    if (bundle == nil) {
        NSURL *defaultBundleUrl = [[NSBundle mainBundle] URLForResource:SDK_DEFAULT_BUNDLE_NAME withExtension:@"bundle"];
        myBundle = [NSBundle bundleWithURL:defaultBundleUrl];
    } else {
        myBundle = bundle;
    }
    
    NSString *imgPath = [[myBundle.resourcePath stringByAppendingPathComponent:folder] stringByAppendingPathComponent:imageName];
    
    resultImage = [UIImage imageWithContentsOfFile:imgPath];
    
    if (!resultImage) {
        resultImage = [UIImage imageNamed:imageName];
    }
    return resultImage;
}

@end
