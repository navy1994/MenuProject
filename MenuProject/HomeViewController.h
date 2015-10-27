//
//  HomeViewController.h
//  MenuProject
//
//  Created by mac- t4 on 15/10/12.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISearchView.h"

@interface HomeViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *advertArray;
@property (nonatomic, strong) UISearchView *searchView;

@property (nonatomic, strong)  NSArray *sortMenuName;
@property (nonatomic, strong)  NSDictionary *menuForSort;
@end
