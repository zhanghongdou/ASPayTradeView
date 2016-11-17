//
//  ASPayTradeView.m
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASPayTradeView.h"

@interface ASPayTradeView ()<SelectedCellUpdateSubViewDelegate>
{
    ASPayTradeViewType _viewType;
    ASPayModel *_payModel;
    ASTranslateType _translateType;
    ASTransformAnimationTool *_tool;
    NSInteger _firstViewToNextViewByIndex;
}
@property (nonatomic, strong) ASPayVisibleView *payAlertViewOne, *payAlertViewTwo, *paySheetViewOne, *paySheetViewTwo, *paySheetSetWord, *paySheetViewResetPassword;
@end

@implementation ASPayTradeView

-(ASPayVisibleView *)payAlertViewOne
{
    if (!_payAlertViewOne) {
        _payAlertViewOne = [[ASPayVisibleView alloc]initWithFrame:CGRectMake(50, (kScreenHeight - 5 * 44) / 2, kScreenWidth - 100, 5 * 44) withType:VisibleViewTypeAlertOne withModel:_payModel];
        _payAlertViewOne.updateSubdelegate = self;
    }
    return _payAlertViewOne;
}

-(ASPayVisibleView *)payAlertViewTwo
{
    if (!_payAlertViewTwo) {
        if (_translateType == ASTranslateTypeSlip) {
            _payAlertViewTwo = [[ASPayVisibleView alloc]initWithFrame:CGRectMake(kScreenWidth + 50, (kScreenHeight - 5 * 44) / 2, kScreenWidth - 100, 5 * 44) withType:VisibleViewTypeAlertTwo withModel:_payModel];
        }else{
            _payAlertViewTwo = [[ASPayVisibleView alloc]initWithFrame:CGRectMake(50, (kScreenHeight - 5 * 44) / 2, kScreenWidth - 100, 5 * 44) withType:VisibleViewTypeAlertTwo withModel:_payModel];
        }
        __weak typeof(self)weakSelf = self;
        _payAlertViewTwo.backToFirstViewBlock = ^{
            [weakSelf backToFirstView];
        };
        _payAlertViewTwo.updateFirstViewBlock = ^(ASSubModel *subModel){
            [weakSelf updateFirstView:subModel];
        };
    }
    return _payAlertViewTwo;
}

-(void)updateFirstView:(ASSubModel *)subModel
{
    ASSubModel *model =  _payModel.dataArray[_firstViewToNextViewByIndex];
    model.subTilte = subModel.subTilte;
    
    for (UIView *view in self.payAlertViewOne.subviews) {
        if ([view isKindOfClass:[ASTableView class]]) {
            ASTableView *tableView = (ASTableView *)view;
            [tableView updateFirstView];
            break;
        }
    }
    
    [_tool transformWithAniamtionType:_translateType withCurrentView:self.payAlertViewTwo withNextView:self.payAlertViewOne isToLeft:YES];
    
}

-(void)backToFirstView
{
    [_tool transformWithAniamtionType:_translateType withCurrentView:self.payAlertViewTwo withNextView:self.payAlertViewOne isToLeft:YES];
}

-(ASPayVisibleView *)paySheetViewOne
{
    if (!_paySheetViewOne) {
       _paySheetViewOne = [[ASPayVisibleView alloc]initWithFrame:CGRectMake(kScreenWidth, kScreenHeight - 44 * 6, kScreenWidth, 44 * 6) withType:VisibleViewTypeSheetOne withModel:_payModel];
    }
    return _paySheetViewOne;
}

-(ASPayVisibleView *)paySheetViewTwo
{
    if (!_paySheetViewTwo) {
           _paySheetViewTwo = [[ASPayVisibleView alloc]initWithFrame:CGRectMake(kScreenWidth, kScreenHeight - 44 * 6, kScreenWidth, 44 * 6) withType:VisibleViewTypeSheetTwo withModel:_payModel];
    }
    return _paySheetViewTwo;
}

-(ASPayVisibleView *)paySheetViewResetPassword
{
    if (!_paySheetViewResetPassword) {
        _paySheetViewResetPassword = [[ASPayVisibleView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44 * 6, kScreenWidth, 44 * 6) withType:VisibleViewTypeSheetResetPassword withModel:_payModel];
    }
    return _paySheetViewResetPassword;
}

-(ASPayVisibleView *)paySheetSetWord
{
    if (!_paySheetSetWord) {
        _paySheetSetWord = [[ASPayVisibleView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44 * 6, kScreenWidth, 44 * 6) withType:VisibleViewTypeSheetSetWord withModel:_payModel];
    }
    return _paySheetSetWord;
}


+(ASPayTradeView *)shareTradeViewWithViewType:(ASPayTradeViewType)type withTranslateType:(ASTranslateType)translateType withModel:(ASPayModel *)model
{
    return [[ASPayTradeView alloc]initWithFrame:[UIScreen mainScreen].bounds withViewType:type withModel:model WithTranslateType:translateType];
}

-(id)initWithFrame:(CGRect)frame withViewType:(ASPayTradeViewType)type withModel:(ASPayModel *)model WithTranslateType: (ASTranslateType) translateType
{
    if (self = [super initWithFrame:frame]) {
        _payModel = [[ASPayModel alloc]init];
        _payModel = model;
        _viewType = type;
        _translateType = translateType;
        _tool = [[ASTransformAnimationTool alloc]init];
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    self.backgroundColor = [UIColor colorWithRed:178.0 / 255.0 green:178.0 / 255.0 blue:178.0 / 255.0 alpha:1.0];
    switch (_viewType) {
        case ASPayTradeViewTypeAlert:
            [self creatViewAboutAlert];
            break;
        case ASPayTradeViewTypesheet:
            [self creatViewAboutSheet];
            break;
        case ASPayTradeViewTypeSetPassword:
            [self creatViewAboutSetPassword];
            break;
        case ASPayTradeViewTypeResetPassword:
            [self creatViewAboutResetPassword];
            break;
        default:
            NSLog(@"view style can not be nil");
            break;
    }
}

-(void)creatViewAboutAlert
{
    [self addSubview:self.payAlertViewOne];
    __weak typeof (self)weakSelf = self;
    self.payAlertViewOne.dissmissBtnBlock = ^{
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.payAlertViewOne.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
            weakSelf.payAlertViewOne.alpha = 0.0;
            weakSelf.alpha = 0.0;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
        }];
    };
    self.payAlertViewTwo.hidden = YES;
    [self addSubview:self.payAlertViewTwo];
    self.payAlertViewTwo.updateSubdelegate = self;
}

-(void)selectedCellUpdateSubViewDelegate:(NSMutableArray *)subArray withIndex:(NSInteger)index
{
    _firstViewToNextViewByIndex = index;
    self.payAlertViewTwo.hidden = NO;
    switch (_viewType) {
        case ASPayTradeViewTypeAlert:
            for (UIView *view in self.payAlertViewTwo.subviews) {
                if ([view isKindOfClass:[ASTableView class]]) {
                    ASTableView *tableView = (ASTableView *)view;
                    [tableView updateSubTableViewWithArray:subArray];
                    break;
                }
            }
            [_tool transformWithAniamtionType:_translateType withCurrentView:self.payAlertViewOne withNextView:self.payAlertViewTwo isToLeft:NO];
            break;
        case ASPayTradeViewTypesheet:
            for (UIView *view in self.paySheetViewTwo.subviews) {
                if ([view isKindOfClass:[ASTableView class]]) {
                    ASTableView *tableView = (ASTableView *)view;
                    [tableView updateSubTableViewWithArray:subArray];
                    break;
                }
            }
            [_tool transformWithAniamtionType:_translateType withCurrentView:self.paySheetViewOne withNextView:self.paySheetViewTwo isToLeft:NO];
            break;
        default:
            NSLog(@"view style can not be nil");
            break;
    }
    
}


-(void)creatViewAboutSheet
{
    
}
-(void)creatViewAboutSetPassword
{
    
}

-(void)creatViewAboutResetPassword
{
    
}

-(void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.payAlertViewOne.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    self.payAlertViewOne.alpha = 0;
    [UIView animateWithDuration:0.7f delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.payAlertViewOne.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.payAlertViewOne.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)drawRect:(CGRect)rect {
    
}


@end
