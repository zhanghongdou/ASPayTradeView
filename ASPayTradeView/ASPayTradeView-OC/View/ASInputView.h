//
//  ASInputView.h
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, InputViewType) {
    InputViewTypeShowDot  =  1, //黑点的形式显示
    InputViewTypeNormal         //正常显示textField
};
@interface ASInputView : UIView
-(id)initWithFrame:(CGRect)frame withType:(InputViewType)inputViewType withPassWordCount:(NSInteger)pwCount;
@end
