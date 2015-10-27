//
//  TapSearchViewController.h
//  MenuProject
//
//  Created by mac- t4 on 15/10/20.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapSearchViewController : UIViewController

@property (nonatomic,strong) NSArray *menuData;

@property (nonatomic)  BOOL isSearch;
@property (nonatomic, strong) NSString *textFiledString;

@property (nonatomic, strong) UITextField *textField;

@end
