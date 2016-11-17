//
//  ASTableView.m
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASTableView.h"
#import "ASTableViewCell.h"
@interface ASTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end
@implementation ASTableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.subModelArray = [NSMutableArray array];
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ASTableViewCell class] forCellReuseIdentifier:@"ASTableViewCell"];
    [self addSubview:self.tableView];
}

-(void)updateSubTableViewWithArray:(NSMutableArray *)subArray
{
    [self.subModelArray removeAllObjects];
    for (ASSubModel *subModel in subArray) {
        [self.subModelArray addObject:subModel];
    }
    [self.tableView reloadData];
}

-(void)setSubModelArray:(NSMutableArray *)subModelArray
{
    _subModelArray = subModelArray;
    [self.tableView reloadData];
}

-(void)updateFirstView
{
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.subModelArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASSubModel *model = self.subModelArray[indexPath.row];
    if (model.haveSubModel) {
        if (self.delegate) {
            [self.delegate selectedCellWith:model.detailArray withIndex:indexPath.row];
        }
    }
    if ([self.isSubView isEqualToString:@"isSubView"]) {
        //选中修改model，然后然后到上一个View
        if (self.selectedSubCellBlock) {
            self.selectedSubCellBlock(self.subModelArray[indexPath.row]);
        }
    }
}

- (void)drawRect:(CGRect)rect {
    
}


@end
