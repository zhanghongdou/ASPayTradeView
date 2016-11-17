//
//  ASPayModel.h
//  ASPayTradeView
//
//  Created by haohao on 16/11/15.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ASSubModel;
@interface ASPayModel : NSObject
@property (nonatomic, strong) NSMutableArray <ASSubModel *>*dataArray;
@end


//@class ASSubDetailModel;
@interface ASSubModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTilte;
@property (nonatomic, assign) BOOL haveSubModel;
@property (nonatomic, strong) NSMutableArray <ASSubModel *>*detailArray;
@end

//@interface ASSubDetailModel : NSObject
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *subTilte;
//@end
