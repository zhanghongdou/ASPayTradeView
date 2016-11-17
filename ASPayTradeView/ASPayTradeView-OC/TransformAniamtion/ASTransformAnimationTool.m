//
//  TransformAnimationTool.m
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASTransformAnimationTool.h"

@interface ASTransformAnimationTool ()

@end

@implementation ASTransformAnimationTool

-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)transformWithAniamtionType:(ASTranslateType)type withCurrentView:(UIView *)currentView withNextView:(UIView *)nextView isToLeft:(BOOL)isToLeft
{
    switch (type) {
        case ASTranslateTypeSlip:
            [self slipAnimationWithCurrnetView:currentView withNextView:nextView isToLeft:isToLeft];
            break;
        case ASTranslateTypeFlip:
            [self flipAnimationWithCurrnetView:currentView withNextView:nextView];
            break;
        default:
            NSLog(@"Please choose to switch type of animation !");
            break;
    }
}

//slip
-(void)slipAnimationWithCurrnetView:(UIView *)currentView withNextView:(UIView *)nextView isToLeft:(BOOL)isToLeft
{
    CGAffineTransform currentTransform, nextTransform;
    if (isToLeft) {
        currentTransform = CGAffineTransformMakeTranslation(0, 0);
        nextTransform = CGAffineTransformMakeTranslation(0, 0);
    }else{
        nextTransform = CGAffineTransformMakeTranslation(-kScreenWidth, 0);
        currentTransform = CGAffineTransformMakeTranslation(-kScreenWidth, 0);
    }
    
    [UIView animateWithDuration:AnimaDuration animations:^{
        currentView.transform = currentTransform;
        nextView.transform = nextTransform;
    } completion:^(BOOL finished) {
//        NSLog(@"animation is finished !");
    }];
}

//flip
-(void)flipAnimationWithCurrnetView:(UIView *)currentView withNextView:(UIView *)nextView
{
    CGFloat offset = currentView.frame.size.height * .5;
    nextView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0), CGAffineTransformTranslate(nextView.transform, 0, -offset));
    nextView.alpha = 0;
    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0f, 0.01f), CGAffineTransformMakeTranslation(1.0, offset));
    [UIView animateWithDuration:AnimaDuration animations:^{
        nextView.transform = CGAffineTransformIdentity;
        currentView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.21f, 0.1), CGAffineTransformTranslate(currentView.transform, 0, -offset));
        nextView.alpha = 1;
        currentView.transform = transform;
        currentView.alpha = 0;
    } completion:^(BOOL finished) {
        currentView.transform = CGAffineTransformIdentity;
    }];
}


//dismiss
-(void)dismissWithView:(UIView *)targetView withBottomView:(UIView *)bottomView
{
    [UIView animateWithDuration:0.3f animations:^{
        targetView.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        targetView.alpha = 0;
        bottomView.alpha = 0;
    } completion:^(BOOL finished) {
        [bottomView removeFromSuperview];
    }];
}


//抖动
+(void)shakeViewWithView:(UIView *)view
{
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = 16;
    shakeAnimation.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    shakeAnimation.duration = 0.2f;
    shakeAnimation.repeatCount = 2;
    shakeAnimation.removedOnCompletion = YES;
    [view.layer addAnimation:shakeAnimation forKey:@"shakeAnimation"];
}

@end











