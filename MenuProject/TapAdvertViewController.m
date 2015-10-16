//
//  TapAdvertViewController.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/16.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "TapAdvertViewController.h"
#import <YAScrollSegmentControl/YAScrollSegmentControl.h>


@interface TapAdvertViewController () <YAScrollSegmentControlDelegate>
@property (nonatomic, strong)  YAScrollSegmentControl *scrollSegment;
@end

@implementation TapAdvertViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"今日推荐";
    
    self.scrollSegment = [[YAScrollSegmentControl alloc] initWithFrame:CGRectMake(0, 64, screen_width, 40)];
    _scrollSegment.buttons = @[@"早餐", @"中餐", @"晚餐"];
    _scrollSegment.delegate = self;
    _scrollSegment.tag = 11;
    [_scrollSegment setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateNormal];
    [_scrollSegment setBackgroundImage:[UIImage imageNamed:@"backgroundSelected"] forState:UIControlStateSelected];
    [_scrollSegment setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    _scrollSegment.gradientColor = [UIColor redColor]; // Purposely set strange gradient color to demonstrate the effect
    
    [self.view addSubview:_scrollSegment];
    // Do any additional setup after loading the view.
}

- (void)didSelectItemAtIndex:(NSInteger)index{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
