//
//  GourmetCellView.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/16.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "GourmetCellView.h"

@implementation GourmetCellView

-(id)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.imageView = [UIImageView new];
        [self addSubview:_imageView];
        
        self.title = [UILabel new];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:_title];
        
        self.tips = [UILabel new];
        _tips.textAlignment = NSTextAlignmentCenter;
        _tips.font = [UIFont boldSystemFontOfSize:13];
        _tips.textColor = [UIColor grayColor];
        [self addSubview:_tips];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top).with.offset(10);
            make.width.and.height.mas_equalTo(@70);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_imageView.mas_bottom).with.offset(5);
            make.left.and.right.equalTo(self).with.offset(0);
            make.height.mas_equalTo(@20);
        }];
        
        [_tips mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_title.mas_bottom).with.offset(5);
            make.left.and.right.equalTo(self).with.offset(0);
            make.height.mas_equalTo(@15);
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
