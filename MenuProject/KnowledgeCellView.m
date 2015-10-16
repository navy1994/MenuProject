//
//  KnowledgeCellView.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/16.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "KnowledgeCellView.h"

@implementation KnowledgeCellView

- (id)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.imageView = [UIImageView new];
        [self addSubview:_imageView];
        
        self.titleLB = [UILabel new];
        _titleLB.textColor = [UIColor grayColor];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:_titleLB];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.and.top.right.equalTo(self).with.offset(0);
            make.height.mas_equalTo(@100);
        }];
        
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(_imageView.mas_bottom).with.offset(0);
            make.centerX.mas_equalTo(_imageView.mas_centerX);
            make.width.mas_equalTo(_imageView.mas_width);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
