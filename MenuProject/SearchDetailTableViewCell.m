//
//  SearchDetailTableViewCell.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/21.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "SearchDetailTableViewCell.h"

@implementation SearchDetailTableViewCell
@synthesize imageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        
        self.titleLB = [UILabel new];
        _titleLB.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_titleLB];
        
        self.tipsLB = [UILabel new];
        _tipsLB.font = [UIFont boldSystemFontOfSize:13];
        
        [self.contentView addSubview:_tipsLB];
        
        self.stepLB = [UILabel new];
        _stepLB.text = @"步骤图";
        _stepLB.font = [UIFont boldSystemFontOfSize:11];
        _stepLB.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _stepLB.textColor = [UIColor grayColor];
        _stepLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_stepLB];
        
        self.browseLB = [UILabel new];
        _browseLB.font = [UIFont boldSystemFontOfSize:12];
        _browseLB.textColor = [UIColor grayColor];
        _browseLB.textAlignment = NSTextAlignmentCenter;
        _browseLB.numberOfLines = 0;
        [self.contentView addSubview:_browseLB];
        
        self.collectLB = [UILabel new];
        _collectLB.font = [UIFont boldSystemFontOfSize:12];
        _collectLB.textColor = [UIColor grayColor];
        _collectLB.textAlignment = NSTextAlignmentCenter;
        _collectLB.numberOfLines = 0;
        [self.contentView addSubview:_collectLB];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.and.left.equalTo(self.contentView).with.offset(10);
            make.right.equalTo(self.titleLB.mas_left).with.offset(-10);
            make.bottom.equalTo(self.contentView).with.offset(-10);
            make.width.mas_equalTo(@100);
        }];
        
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView).with.offset(10);
            make.left.equalTo(self.imageView.mas_right).with.offset(10);
            make.right.equalTo(self.stepLB.mas_left).with.offset(-5);
            make.bottom.equalTo(self.tipsLB.mas_top).with.offset(0);
            make.height.equalTo(@30);
        }];
        
        [_stepLB mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.mas_equalTo(self.titleLB.mas_centerY);
            make.left.equalTo(self.titleLB.mas_right).with.offset(5);
            make.height.mas_equalTo(@15);
            make.width.mas_equalTo(@40);
        }];
        
        [_tipsLB mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.titleLB.mas_bottom).with.offset(10);
            make.left.equalTo(self.imageView.mas_right).with.offset(10);
            make.right.equalTo(self.contentView).with.offset(-10);
            make.bottom.equalTo(self.browseLB.mas_top).with.offset(0);
            make.height.mas_equalTo(@20);
        }];
        
        [_browseLB mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.tipsLB.mas_bottom).with.offset(10);
            make.left.equalTo(self.imageView.mas_right).with.offset(10);
            make.right.equalTo(self.collectLB.mas_left).with.offset(-15);
            make.bottom.equalTo(self.contentView).with.offset(0);
            make.width.mas_equalTo(_collectLB.mas_width);
        }];
        
        [_collectLB mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.mas_equalTo(self.browseLB.mas_centerY);
            make.height.mas_equalTo(self.browseLB.mas_height);
        }];
        
        [_titleLB sizeToFit];
        [_browseLB sizeToFit];
        [_collectLB sizeToFit];
        
    
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
