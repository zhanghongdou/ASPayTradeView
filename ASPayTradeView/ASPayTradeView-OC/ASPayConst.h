
//
//  ASPayConst.h
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#ifndef ASPayConst_h
#define ASPayConst_h

typedef NS_ENUM(NSInteger, ASTranslateType){
    ASTranslateTypeSlip = 1,   //滑移
    ASTranslateTypeFlip = 2    //翻转
};

typedef NS_ENUM(NSInteger, ASAlertType){
    ASAlertTypeAlert,      //弹出的形式出现在屏幕中间
    ASAlertTypeSheet,      //在下方出现
};

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
static CGFloat AnimaDuration     =   0.8f;
#endif /* ASPayConst_h */
