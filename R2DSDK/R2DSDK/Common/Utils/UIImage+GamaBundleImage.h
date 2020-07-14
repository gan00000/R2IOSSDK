//


#import <UIKit/UIKit.h>

@interface UIImage (GamaBundleImage)

/**
 *	@brief	UIImage 类别，读取 默认 bundle 文件下的图片。
 */
+ (UIImage *)gama_imageNamed:(NSString *)imageName;

/**
 *	@brief	UIImage 类别，读取不同 bundle 文件下的图片。
 */
+ (UIImage *)gama_imageNamed:(NSString *)imageName inBundle:(NSBundle *)bundle;

/**
 *	@brief	UIImage 类别，读取不同 bundle 文件下某个文件夹的图片。
 */
+ (UIImage *)gama_imageNamed:(NSString *)imageName inBundle:(NSBundle *)bundle inFolder:(NSString *)folder;


@end
