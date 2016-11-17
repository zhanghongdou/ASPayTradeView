//
//  ViewController.m
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "ASPayModel.h"
#import "ASPayTradeView.h"
@interface ViewController ()
@property (nonatomic, strong) ASPayModel *model;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[ASPayModel alloc]init];
    NSMutableArray *detailArray = [NSMutableArray array];
    ASSubModel *detailModel1 = [[ASSubModel alloc]init];
    detailModel1.title = @"类型1";
    detailModel1.subTilte = @"存钱罐";
    [detailArray addObject:detailModel1];
    ASSubModel *detailModel2 = [[ASSubModel alloc]init];
    detailModel2.title = @"类型2";
    detailModel2.subTilte = @"工商银行";
    [detailArray addObject:detailModel2];
    ASSubModel *detailModel3 = [[ASSubModel alloc]init];
    detailModel3.title = @"类型3";
    detailModel3.subTilte = @"建设银行";
    [detailArray addObject:detailModel3];
    ASSubModel *detailModel4 = [[ASSubModel alloc]init];
    detailModel4.title = @"类型4";
    detailModel4.subTilte = @"农业银行";
    [detailArray addObject:detailModel4];
    
    
    NSMutableArray *subArray = [NSMutableArray array];
    ASSubModel *subModel1 = [[ASSubModel alloc]init];
    subModel1.title = @"支付类型";
    subModel1.subTilte = @"金融理财";
    subModel1.haveSubModel = NO;
    subModel1.detailArray = nil;
    [subArray addObject:subModel1];
    ASSubModel *subModel2 = [[ASSubModel alloc]init];
    subModel2.title = @"支付方式";
    subModel2.subTilte = @"存钱罐";
    subModel2.haveSubModel = YES;
    subModel2.detailArray = detailArray;
    [subArray addObject:subModel2];
    
    ASSubModel *subModel3 = [[ASSubModel alloc]init];
    subModel3.title = @"支付金额";
    subModel3.subTilte = @"10000";
    subModel3.haveSubModel = NO;
    subModel3.detailArray = nil;
    [subArray addObject:subModel3];
    
    self.model.dataArray = subArray;
    
    
}

- (IBAction)btnClick:(id)sender {
        ASPayTradeView *view = [ASPayTradeView shareTradeViewWithViewType:ASPayTradeViewTypeAlert withTranslateType:ASTranslateTypeSlip withModel:self.model];
        [view show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
