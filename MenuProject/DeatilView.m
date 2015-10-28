//
//  DeatilView.m
//  尝尝鲜
//
//  Created by mac on 15/6/3.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "DeatilView.h"

@implementation DeatilView

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		self.rootImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width*2/3)];
		[self addSubview:_rootImgeView];
		self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.rootImgeView.frame.origin.y
																   +self.rootImgeView.frame.size.height+20, self.frame.size.width-20, 40)];
		_titleLabel.font = [UIFont boldSystemFontOfSize:26];
		[self addSubview:_titleLabel];
		UILabel *ingreTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+20, self.frame.size.width-20, 30)];
		ingreTitle.font = [UIFont boldSystemFontOfSize:18];
		ingreTitle.text = @"食材";
		[self addSubview:ingreTitle];
		self.ingreLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, ingreTitle.frame.origin.y+ingreTitle.frame.size.height+5, self.frame.size.width-20, 40)];
		_ingreLabel.font = [UIFont boldSystemFontOfSize:13];
		_ingreLabel.numberOfLines = 2;
		[self addSubview:_ingreLabel];
		UILabel *burdenTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, _ingreLabel.frame.origin.y+_ingreLabel.frame.size.height+20, self.frame.size.width-20, 30)];
		burdenTitle.font = [UIFont boldSystemFontOfSize:18];
		burdenTitle.text = @"调料";
		[self addSubview:burdenTitle];
		self.burdenLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, burdenTitle.frame.origin.y+burdenTitle.frame.size.height+5, self.frame.size.width-20, 40)];
		_burdenLabel.numberOfLines = 2;
		_burdenLabel.font = [UIFont boldSystemFontOfSize:13];
		[self addSubview:_burdenLabel];
	}
	return self;
}

@end
