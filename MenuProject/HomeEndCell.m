//
//  HomeEndCell.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/16.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "HomeEndCell.h"

@implementation HomeEndCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        NSArray *btnTitle = @[@"意见反馈", @"给好评"];
        
        for (int i=0; i<2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = (i+1)*100;
            btn.frame = CGRectMake((screen_width-190)/2+i*100, 10, 90, 25);
            [btn setTitle:[btnTitle objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 12;
            btn.layer.borderColor = RGB(240, 70, 73).CGColor;
            btn.layer.borderWidth = 0.5f;
            [self.contentView addSubview:btn];
        }
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
