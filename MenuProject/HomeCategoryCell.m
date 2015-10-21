//
//  HomeCategoryCell.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/15.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "HomeCategoryCell.h"

@implementation HomeCategoryCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"menuData" ofType:@"plist"];
        _menuArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        int index = 0;
        for (int i=0; i<3; i++) {
            for (int j=0; j<4; j++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(j*screen_width/4, i*(200/4), screen_width/4, 200/4);
                [btn setTitle:[_menuArray objectAtIndex:index++] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                btn.layer.borderWidth = 1.0f;
                [self.contentView addSubview:btn];
            }
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
