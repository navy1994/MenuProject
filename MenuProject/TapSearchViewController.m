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

#import "HotTableViewCell.h"
#import "HistoryTableViewCell.h"



@interface TapSearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;

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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    /**
     *  设置导航栏
     */
    self.navigationController.navigationBar.alpha = 1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB(255.0, 255.0, 255.0) colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
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
    [self.view addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.and.left.and.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(@30);
    }];
    segmentedControl.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    segmentedControl.layer.borderWidth = 0.5f;
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.backgroundColor = RGB(255.0, 255.0, 255.0);
    segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName:[UIFont fontWithName:@"Arial-ItalicMT" size:14.0]};
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : RGB(240, 70, 73), NSFontAttributeName:[UIFont fontWithName:@"Arial-ItalicMT" size:15.0]};
    segmentedControl.selectionIndicatorColor = RGB(240, 70, 73);
    segmentedControl.selectionIndicatorHeight = 2.0f;
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    
    /**
     *  设置tableView
     */
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, screen_width, screen_height-segmentedControl.frame.origin.y+segmentedControl.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = nil;
    _tableView.sectionHeaderHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}
#pragma mark -- SegmentDelegate
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark --- UITextFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark --- UITableViewDatabase and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *height = @[@100, @190, @40];
    return [[height objectAtIndex:indexPath.section]floatValue];
    //return 150;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIndentifier = @"nomorecell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        UIButton *videoBtn = [UIButton new];
        [cell.contentView addSubview:videoBtn];
        [videoBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.and.bottom.equalTo(cell.contentView).with.offset(0);
            make.left.equalTo(cell.contentView).with.offset(10);
            make.right.equalTo(cell.contentView).with.offset(-10);
        }];
        [videoBtn setImage:[UIImage imageNamed:@"videoBtn"] forState:UIControlStateNormal];
        cell.backgroundColor = [UIColor clearColor];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }else if (indexPath.section == 1){
        
        static NSString *cellIndentifier = @"nomorecell";
        HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        static NSString *cellIndentifier = @"nomorecell";
        HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }
   
}


- (void)clickBtnToSearch{
    [_textField resignFirstResponder];
}

- (void)popViewController{
    [_textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
