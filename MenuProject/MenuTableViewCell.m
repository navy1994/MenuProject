//
//  MenuTableViewCell.m
//  尝尝鲜
//
//  Created by mac on 15/6/3.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell
@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.titleLabel = [[UILabel alloc]init];
		_titleLabel.font = [UIFont boldSystemFontOfSize:16];
		[self.contentView addSubview:_titleLabel];
		
		self.imageView = [[UIImageView alloc]init];
		[self.contentView addSubview:imageView];
		
		self.tags = [[UILabel alloc]init];
		_tags.font = [UIFont boldSystemFontOfSize:13];
		[self.contentView addSubview:_tags];
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
