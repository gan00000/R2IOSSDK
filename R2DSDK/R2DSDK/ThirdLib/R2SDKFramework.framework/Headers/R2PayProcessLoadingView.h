//
//  R2LoadingView.h
//  R2GMDemo
//
//  Created by luxing on 8/21/15.
//  Copyright (c) 2015 luxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LOADING_FRAME_SIZE 80

@interface R2PayProcessLoadingView : UIView

@property UIActivityIndicatorView *indicatorView;


-(id)initWithFrame:(CGRect)frame;
-(void)start;
-(void)stop;
@end
