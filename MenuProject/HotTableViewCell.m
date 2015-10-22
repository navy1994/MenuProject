//
//  HotTableViewCell.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/21.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "HotTableViewCell.h"

@implementation HotTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSArray *hotMenu = @[@"粥", @"炒饭", @"牛肉", @"秋葵", @"鸡汤", @"饼", @"芋头", @"回锅肉", @"胡萝卜"];
        UIView *view = [UIView new];
        [self.contentView addSubview:view];
        
        UILabel *knowledgeLb = [UILabel new];
        knowledgeLb.text = @"美食热搜榜";
        knowledgeLb.font = [UIFont boldSystemFontOfSize:16];
        [view addSubview:knowledgeLb];
        
        UILabel *moreLb = [UILabel new];
        moreLb.textAlignment = NSTextAlignmentRight;
        moreLb.text = @"刷新";
        moreLb.textColor = [UIColor grayColor];
        moreLb.font = [UIFont boldSystemFontOfSize:15];
        [view addSubview:moreLb];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.and.left.and.right.equalTo(self.contentView).with.offset(0);
            make.height.mas_equalTo(@40);
        }];
        
        [knowledgeLb mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.and.left.equalTo(view).with.offset(10);
            make.right.equalTo(moreLb.mas_left).offset(0);
            make.bottom.equalTo(view).with.offset(-10);
            make.width.mas_equalTo(moreLb.mas_width);
        }];
        
        [moreLb mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.mas_equalTo(knowledgeLb.mas_centerY);
            make.right.equalTo(view).with.offset(-10);
            make.width.and.height.equalTo(knowledgeLb);
        }];

        
        int index = 0;
        for (int i=0; i<3; i++) {
            for (int j=0; j<3; j++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(j*screen_width/3, i*(150/3)+40, screen_width/3, 150/3);
                [btn setTitle:[hotMenu objectAtIndex:index++] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                btn.layer.borderWidth = 1.0f;
                btn.tag = index*100;
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
