//
//  ASPayModel.m
//  ASPayTradeView
//
//  Created by haohao on 16/11/15.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASPayModel.h"

@implementation ASPayModel
-(instancetype)init
{
    if (self = [super init]) {
        if (!self.dataArray) {
            self.dataArray = (NSMutableArray<ASSubModel *>*)[NSMutableArray array];
        }
    }
    return self;
}
@end


@implementation ASSubModel
-(instancetype)init
{
    if (self = [super init]) {
        if (!self.detailArray) {
            self.detailArray = (NSMutableArray<ASSubModel *>*)[NSMutableArray array];
        }
    }
    return self;
}

@end

//@implementation ASSubDetailModel
//
//
//@end
