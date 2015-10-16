//
//  HomeKnowledgeCell.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/16.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "HomeKnowledgeCell.h"
#import "KnowledgeCellView.h"

@implementation HomeKnowledgeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *imageArray = @[@"advert2", @"advert3"];
        NSArray *titleArray = @[@"十全十美，养生悦目", @"小调料，真讲究"];
        UIView *view = [UIView new];
        [self.contentView addSubview:view];
        
        UILabel *knowledgeLb = [UILabel new];
        knowledgeLb.text = @"美食小知识";
        knowledgeLb.font = [UIFont boldSystemFontOfSize:15];
        knowledgeLb.textColor = RGB(240, 70, 73);
        [view addSubview:knowledgeLb];
        
        UILabel *moreLb = [UILabel new];
        moreLb.textAlignment = NSTextAlignmentRight;
        moreLb.text = @"更多 >";
        moreLb.textColor = [UIColor grayColor];
        moreLb.font = [UIFont boldSystemFontOfSize:15];
        [view addSubview:moreLb];
        
        for (int i=0; i<2; i++) {
            
            KnowledgeCellView *knowview = [[KnowledgeCellView alloc]initWithFrame:CGRectMake(i*((screen_width-30)/2+10)+10, 40, (screen_width-30)/2, 140)];
            knowview.tag = (i+1)*100;
            knowview.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
            knowview.titleLB.text = [titleArray objectAtIndex:i];
            NSLog(@"%@",[titleArray objectAtIndex:i]);
            [self.contentView addSubview:knowview];
        }
        
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
