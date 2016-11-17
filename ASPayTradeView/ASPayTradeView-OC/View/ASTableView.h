//
//  ASTableView.h
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPayModel.h"
@protocol SelectedCellDelegate <NSObject>
//进入下一级页面，查看详情
-(void)selectedCellWith:(NSMutableArray *)subModelArray withIndex:(NSInteger)index;
@end
typedef void (^SelectedSubCellBlock)(ASSubModel *submodel);
@interface ASTableView : UIView
@property (nonatomic, strong) NSMutableArray *subModelArray;
@property (weak, nonatomic) id <SelectedCellDelegate>delegate;
-(void)updateSubTableViewWithArray:(NSMutableArray *)subArray;
//表示是sub，可供选择
@property (nonatomic, copy) NSString *isSubView;
@property (nonatomic, copy) SelectedSubCellBlock selectedSubCellBlock;
-(void)updateFirstView;
@end
