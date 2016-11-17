//
//  ASPayTradeView.h
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPayModel.h"
#import "ASPayVisibleView.h"
#import "ASPayConst.h"
#import "ASTableView.h"
#import "ASTransformAnimationTool.h"
typedef NS_ENUM(NSInteger, ASPayTradeViewType) {
    ASPayTradeViewTypeAlert = 1,        //alert
    ASPayTradeViewTypesheet = 2,        //sheet
    ASPayTradeViewTypeSetPassword = 3,  //set
    ASPayTradeViewTypeResetPassword     //reset
};
@interface ASPayTradeView : UIView
+(ASPayTradeView *)shareTradeViewWithViewType:(ASPayTradeViewType)type withTranslateType:(ASTranslateType)translateType withModel:(ASPayModel *)model;
-(void)show;
@end
