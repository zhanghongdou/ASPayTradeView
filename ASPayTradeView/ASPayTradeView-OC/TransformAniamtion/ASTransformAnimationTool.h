//
//  TransformAnimationTool.h
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASPayConst.h"
@interface ASTransformAnimationTool : NSObject
-(void)transformWithAniamtionType:(ASTranslateType)type withCurrentView:(UIView *)currentView withNextView:(UIView *)nextView isToLeft:(BOOL)isToLeft;
+(void)shakeViewWithView:(UIView *)view;
@end
