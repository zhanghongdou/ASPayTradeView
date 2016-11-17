//
//  ASPayVisibleView.h
//  ASPayTradeView
//
//  Created by haohao on 16/11/14.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPayModel.h"
typedef NS_ENUM(NSInteger, VisibleViewType) {
    VisibleViewTypeAlertOne = 1,
    VisibleViewTypeAlertTwo = 2,
    VisibleViewTypeSheetOne = 3,
    VisibleViewTypeSheetTwo = 4,
    VisibleViewTypeSheetSetWord = 5,
    VisibleViewTypeSheetResetPassword
};
//消失的block
typedef void (^DissmissBtnBlock)();
//返回上一级页面
typedef void (^BackToFirstViewBlock) ();
//刷新上一级页面
typedef void (^UpdateFirstViewBlock) (ASSubModel *subModel);
@protocol SelectedCellUpdateSubViewDelegate <NSObject>
@optional
//刷新subtableView
-(void)selectedCellUpdateSubViewDelegate:(NSMutableArray *)subArray withIndex:(NSInteger)index;
@end
@interface ASPayVisibleView : UIView
-(id)initWithFrame:(CGRect)frame withType:(VisibleViewType)type withModel:(ASPayModel *)model;

@property (nonatomic, weak) id <SelectedCellUpdateSubViewDelegate>updateSubdelegate;
@property (nonatomic, copy) DissmissBtnBlock dissmissBtnBlock;
@property (nonatomic, copy) BackToFirstViewBlock backToFirstViewBlock;
@property (nonatomic, copy) UpdateFirstViewBlock updateFirstViewBlock;

@end
