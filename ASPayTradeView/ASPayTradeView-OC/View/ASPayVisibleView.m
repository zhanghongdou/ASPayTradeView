//
//  ASPayVisibleView.m
//  ASPayTradeView
//
//  Created by haohao on 16/11/14.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASPayVisibleView.h"
#import "ASTableView.h"
#import "ASInputView.h"
@interface ASPayVisibleView ()<SelectedCellDelegate>
{
    VisibleViewType _visibleType;
    ASPayModel *_payModel;
}
@property (nonatomic, strong) ASTableView *asTableView;
@property (nonatomic, strong) UILabel *headerTitleLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *addBtn;
@end
@implementation ASPayVisibleView

-(id)initWithFrame:(CGRect)frame withType:(VisibleViewType)type withModel:(ASPayModel *)model
{
    if (self = [super initWithFrame:frame]) {
        _payModel = [[ASPayModel alloc]init];
        _payModel = model;
        _visibleType = type;
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    self.backgroundColor = [UIColor colorWithRed:251.0 / 255.0 green:251.0 / 255.0 blue:251.0 / 255.0 alpha:1.0];
    self.layer.cornerRadius = 5.0;
    self.clipsToBounds = YES;
    switch (_visibleType) {
        case VisibleViewTypeAlertOne:
            [self creatUIAboutAlertOne];
            break;
        case VisibleViewTypeAlertTwo:
            [self creatUIAboutAlertTwo];
            break;
        case VisibleViewTypeSheetOne:
            [self creatUIAboutSheetOne];
            break;
        case VisibleViewTypeSheetTwo:
            [self creatUIAboutSheetTwo];
            break;
        case VisibleViewTypeSheetSetWord:
            [self creatUIAboutSheetSetWord];
            break;
        case VisibleViewTypeSheetResetPassword:
            [self creatUIAboutSheetReset];
            break;
        default:
            NSLog(@"please set type");
            break;
    }
}

-(void)creatUIAboutAlertOne
{
    self.asTableView = [[ASTableView alloc]initWithFrame:CGRectMake(0, 44, self.frame.size.width, _payModel.dataArray.count * 44)];
    self.asTableView.subModelArray = _payModel.dataArray;
    self.asTableView.delegate = self;
    [self addSubview:self.asTableView];
    [self creatHeaderView];
    self.headerTitleLabel.text = @"请输入支付密码";
    self.cancelBtn.hidden = NO;
    
    //输入框
    ASInputView *inputView = [[ASInputView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.asTableView.frame), CGRectGetWidth(self.frame), 44) withType:InputViewTypeNormal withPassWordCount:6];
    [self addSubview:inputView];
}


-(void)dissmissFromSuperView
{
    if (self.dissmissBtnBlock) {
        self.dissmissBtnBlock();
    }
}

-(void)creatUIAboutAlertTwo
{
    self.asTableView = [[ASTableView alloc]initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height - 44)];
    [self addSubview:self.asTableView];
    [self creatHeaderView];
    self.headerTitleLabel.text = @"请选择支付方式";
    self.backBtn.hidden = NO;
    self.asTableView.isSubView = @"isSubView";
    self.cancelBtn.hidden = YES;
    __weak typeof (self) weakSelf = self;
    self.asTableView.selectedSubCellBlock = ^(ASSubModel *subModel) {
        if (weakSelf.updateFirstViewBlock) {
            weakSelf.updateFirstViewBlock(subModel);
        }
    };
}

-(void)creatHeaderView
{
    //head label
    self.headerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.frame.size.width - 50 * 2, 44)];
    
    self.headerTitleLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
    self.headerTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.headerTitleLabel];
    
    //cancel btn
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"╳" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor colorWithWhite:0.400 alpha:1.000] forState:UIControlStateNormal];
    self.cancelBtn.frame = CGRectMake(self.frame.size.width - 20 - 20, 12, 20, 20);
    [self.cancelBtn addTarget:self action:@selector(dissmissFromSuperView) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn.hidden = YES;
    [self addSubview:self.cancelBtn];
    
    //line
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.400 alpha:0.5];
    [self addSubview:lineView];
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.backBtn.frame = CGRectMake(0, 0, 44, 44);
    [self addSubview:self.backBtn];
    [self.backBtn addTarget:self action:@selector(backToFirstView) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn.hidden = YES;
    
    //add btn
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(self.frame.size.width - 50, 0, 50, 44);
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor colorWithWhite:0.400 alpha:0.5] forState:UIControlStateNormal];
    self.addBtn.hidden = YES;
    [self.addBtn addTarget:self action:@selector(addMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.addBtn];
}

-(void)addMethod
{
    
}

-(void)backToFirstView
{
    if (self.backToFirstViewBlock) {
        self.backToFirstViewBlock();
    }
}


-(void)creatUIAboutSheetOne
{
    
}

-(void)creatUIAboutSheetTwo
{
    
}

-(void)creatUIAboutSheetSetWord
{
    
}

-(void)creatUIAboutSheetReset
{
    
}

#pragma mark ------- SelectedCellDelegate
-(void)selectedCellWith:(NSMutableArray *)subModelArray withIndex:(NSInteger)index
{
    if (self.updateSubdelegate) {
        [self.updateSubdelegate selectedCellUpdateSubViewDelegate:subModelArray withIndex:index];
    }
}

- (void)drawRect:(CGRect)rect {
    
}

@end
