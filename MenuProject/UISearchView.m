
//
//  UISearchView.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/15.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "UISearchView.h"

@implementation UISearchView

- (id)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        //
        UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 15, 15)];
        [searchImage setImage:[UIImage imageNamed:@"icon_homepage_search"]];
        [self addSubview:searchImage];
        
        UILabel *placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 2.5, screen_width-50, 25)];
        placeHolderLabel.font = [UIFont boldSystemFontOfSize:13];
        placeHolderLabel.text = @"搜菜谱、食材、相克、知识等";
        placeHolderLabel.textColor = [UIColor grayColor];
        [self addSubview:placeHolderLabel];
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
