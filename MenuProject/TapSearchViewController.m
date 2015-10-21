//
//  TapSearchViewController.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/20.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "TapSearchViewController.h"
#import "UIImage+UIColor.h"
#import "HMSegmentedControl.h"
#import "RDVTabBarController.h"
<<<<<<< HEAD

@interface TapSearchViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;


=======

@interface TapSearchViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
>>>>>>> 2b0e636d8a5b7e07e446a860fb11ea46dc187af0
@end

@implementation TapSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    self.navigationController.navigationBar.alpha = 0;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  设置导航栏
     */
    self.navigationController.navigationBar.alpha = 1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB(260.0, 260.0, 248.0) colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(popViewController)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(clickBtnToSearch)];
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, screen_width-80, 30)];
    _textField.delegate = self;
    _textField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _textField.placeholder = @"搜菜谱、食材、相克、知识等";
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 5;
    _textField.clearsOnBeginEditing = YES;
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.returnKeyType = UIReturnKeySearch;
    [_textField becomeFirstResponder];
    self.navigationItem.titleView = _textField;
    
    /**
     *  设置segmentController
     */
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部", @"食材", @"菜谱", @"菜单", @"相克／宜搭", @"健康养生", @"美食知识", @"美食贴", @"哈友"]];
    segmentedControl.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    segmentedControl.layer.borderWidth = 0.5f;
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.frame = CGRectMake(0, 0, screen_width, 30);
    segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.backgroundColor = RGB(260.0, 260.0, 248.0);
    segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName:[UIFont fontWithName:@"Arial-ItalicMT" size:14.0]};
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : RGB(240, 70, 73), NSFontAttributeName:[UIFont fontWithName:@"Arial-ItalicMT" size:15.0]};
    segmentedControl.selectionIndicatorColor = RGB(240, 70, 73);
    segmentedControl.selectionIndicatorHeight = 2.0f;
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBtnToSearch{
    [_textField resignFirstResponder];
}

- (void)popViewController{
    [_textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
