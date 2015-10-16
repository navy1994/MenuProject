//
//  HomeGourmetCell.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/16.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "HomeGourmetCell.h"
#import "GourmetCellView.h"

@implementation HomeGourmetCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *imageArray = @[@"youshi", @"meishi", @"tizhi"];
        NSArray *titleArray = @[@"酉时", @"美食养生", @"体质养生"];
        NSArray *tipsArray = @[@"宜喝水", @"养生从美食开始", @"养生因人而异"];
        for (int i=0; i<3; i++) {
            GourmetCellView *gourmetView = [[GourmetCellView alloc]initWithFrame:CGRectMake(i*screen_width/3, 0, screen_width/3, self.frame.size.height)];
            gourmetView.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
            gourmetView.title.text = [titleArray objectAtIndex:i];
            gourmetView.tips.text = [tipsArray objectAtIndex:i];
            [self.contentView addSubview:gourmetView];
        }
    }
    return self;
}

- (void)clickBtn:(UIButton *)sender{
    NSLog(@"clickBtnTag:%ld",sender.tag);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect{
    
}

@end
