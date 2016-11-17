//
//  ASTableViewCell.m
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASTableViewCell.h"
@interface ASTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end
@implementation ASTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0, 0, self.contentView.frame.size.width / 2 - 15, self.contentView.frame.size.height)];
    self.titleLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width / 2, 0, self.contentView.frame.size.width / 2 - 40, self.contentView.frame.size.height)];
    self.detailLabel.textColor = [UIColor colorWithWhite:0.098 alpha:1.000];
    [self.contentView addSubview:self.detailLabel];
}

-(void)setModel:(ASSubModel *)model
{
    _model = model;
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.subTilte;
    if (model.haveSubModel) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}
@end






