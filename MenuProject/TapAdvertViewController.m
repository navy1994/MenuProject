//
//  TapAdvertViewController.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/16.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "TapAdvertViewController.h"
#import "HMSegmentedControl.h"
#import "RDVTabBarController.h"
#import "Masonry.h"


@interface TapAdvertViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UITableView *tableView3;

@end

@implementation TapAdvertViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"今日推荐";
    // Tying up the segmented control to a scroll view
    //self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, screen_width, 40)];
    self.segmentedControl = [[HMSegmentedControl alloc] init];
    [self.view addSubview:self.segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).with.offset(64);
        make.left.and.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    self.segmentedControl.sectionTitles = @[@"早餐", @"中餐", @"晚餐"];
    self.segmentedControl.selectedSegmentIndex = 1;
    self.segmentedControl.backgroundColor = RGB(245, 245, 245);
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : RGB(240, 70, 73)};
    self.segmentedControl.selectionIndicatorColor = RGB(240, 70, 73);
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.tag = 3;
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(screen_width * index, 0, screen_width, 200) animated:YES];
        NSLog(@"index=%ld",index);
    }];
    
    
    
    //self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentedControl.frame.origin.y+_segmentedControl.frame.size.height, screen_width, 210)];
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.segmentedControl.mas_bottom).with.offset(0);
        make.left.and.right.and.bottom.equalTo(self.view).with.offset(0);
    }];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(screen_width * 3, 200);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(screen_width, 0, screen_width, 200) animated:NO];
    
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, _scrollView.frame.size.height)];
    [self.scrollView addSubview:_tableView1];
    
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(screen_width, 0, screen_width, _scrollView.frame.size.height)];
    [self.scrollView addSubview:_tableView2];
    
    self.tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(screen_width * 2, 0, screen_width, _scrollView.frame.size.height)];
    [self.scrollView addSubview:_tableView3];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
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