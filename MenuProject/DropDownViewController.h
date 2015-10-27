//
//  DropDownViewController.h
//  MenuProject
//
//  Created by mac- t4 on 15/10/23.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownViewController : UIViewController{
    UIActivityIndicatorView *_activityView;
}

@property (nonatomic,strong) NSArray *menuData;
@property (nonatomic,strong) NSString *selectMenu;
@property (nonatomic) NSInteger currentData1Index;
@property (nonatomic) NSInteger currentData1SelectedIndex;
@property (nonatomic) BOOL isClassity;


@property (nonatomic,strong) NSArray *data;

@end
