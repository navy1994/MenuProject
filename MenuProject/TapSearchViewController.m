//
//  TapSearchViewController.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/20.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "TapSearchViewController.h"

#import "HotTableViewCell.h"
#import "HistoryTableViewCell.h"
#import "SearchDetailTableViewCell.h"

#import "SearchDetailViewController.h"



@interface TapSearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIActivityIndicatorView *_activityView;
}


@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;

@end


@implementation TapSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    self.navigationController.navigationBar.alpha = 1;
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB(255.0, 255.0, 255.0) colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(popViewController)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(clickBtnToSearch)];
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, screen_width-80, 30)];
    _textField.delegate = self;
    _textField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 5;
    _textField.clearsOnBeginEditing = YES;
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField.placeholder = @"搜菜谱、食材、相克、知识等";
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.returnKeyType = UIReturnKeySearch;
    
    if (_textFiledString) {
        _textField.text = _textFiledString;
    }
    
    self.navigationItem.titleView = _textField;
    
    /**
     *  设置tableView1 ------  搜索推荐列表
     */
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView1];
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    _tableView1.sectionHeaderHeight = 0;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView1.tableHeaderView removeFromSuperview];
    
    /**
     *  设置tableView2 ------  搜索详情列表
     */
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, screen_width, screen_height-94) style:UITableViewStylePlain];
    [self.view addSubview:_tableView2];
    _tableView2.dataSource = self;
    _tableView2.delegate = self;
    [_tableView2.tableHeaderView removeFromSuperview];
    
    if (_isSearch) {
        [_tableView2 setHidden:NO];
        [_tableView1 setHidden:YES];
    }else{
        [_tableView2 setHidden:YES];
        [_tableView1 setHidden:NO];
        [_textField becomeFirstResponder];
    }
    
    /**
     *  设置segmentController
     */
    [self initSegmentController];
    
    
    //注册
    [SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
    [SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
    //设定图片存储顺序
    [SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
    SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
    
//    if (!_menuData.count) {
//        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"无任何记录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//
//    }else{
//        _tableView2.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    }
}

/**
 *  设置segmentController
 *
 *  @return void
 */

- (void)initSegmentController{
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
}

#pragma mark -- SegmentDelegate
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark --- UITextFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _textField.text = textField.text;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    _textField.text = textField.text;
    if (![textField.text isEqualToString:@""]) {
        [self initSearchData:textField.text];
    }
    
    return YES;
}

#pragma mark --- UITableViewDatabase and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == _tableView2) {
        
        return 1;
    }else{
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView2) {
        return _menuData.count;
        
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *heightRows = @[@100, @190, @40];
    if (tableView == _tableView2) {
        return 90;
    }else{
        return [[heightRows objectAtIndex:indexPath.section]floatValue];
    }
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView == _tableView2) {
        static NSString *cellIndentifier = @"nomorecell";
        SearchDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        
        if (cell == nil) {
            cell = [[SearchDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        if (_menuData.count) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[[[[_menuData objectAtIndex:indexPath.row]objectForKey:@"albums"]objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                              placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
            cell.titleLB.text = [[_menuData objectAtIndex:indexPath.row]objectForKey:@"title"];
            cell.tipsLB.text = [[_menuData objectAtIndex:indexPath.row]objectForKey:@"tags"];
            cell.browseLB.text = @"34664浏览";
            cell.collectLB.text = @"65553收藏";
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;

    }else{
        return [self isSearchTableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell*)isSearchTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *cellIndentifier = @"nomorecell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        UIButton *videoBtn = [UIButton new];
        [cell.contentView addSubview:videoBtn];
        [videoBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(cell.contentView).with.offset(15);
             make.bottom.equalTo(cell.contentView).with.offset(0);
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
        for (int i = 1; i < 10; i++) {
            UIButton *btn = (UIButton*)[cell.contentView viewWithTag:i*100];
            [btn addTarget:self action:@selector(clickBtnToDetail:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView2) {
        SearchDetailViewController *detailMenuController = [[SearchDetailViewController alloc]init];
        detailMenuController.detailDic = [_menuData objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailMenuController animated:YES];
    }
}

- (void)clickBtnToDetail:(UIButton*)sender{
    [_textField resignFirstResponder];
    _textField.text = sender.titleLabel.text;
    if (_textField.text) {
        [self initSearchData:_textField.text];
    }
}


- (void)clickBtnToSearch{
    [_textField resignFirstResponder];
    if (![_textField.text isEqualToString:@""]) {
        [self initSearchData:_textField.text];
    }

}

- (void)initSearchData:(NSString *)menuString{
    NSString *urlStr = [NSString stringWithFormat:@"http://apis.juhe.cn/cook/query?key=%s&menu=%@&rn=10&pn=3",appkey,menuString];
    [_activityView startAnimating];
    [[NetworkSingleton sharedManager] getShopResult:nil url:urlStr successBlock:^(id responseBody){
        if (![responseBody objectForKey:@"\"error_code\""]) {
            [self getSearchData:[[responseBody objectForKey:@"result"]objectForKey:@"data"]];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"没有相关数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
        [_activityView stopAnimating];
        
    } failureBlock:^(NSString *error){
        NSLog(@"店铺详情请求失败：%@",error);
    }];
}

- (void)getSearchData:(id)resultData{
    if (resultData) {
        _menuData = resultData;
    }else{
        _menuData = nil;
    }
    [_tableView2 reloadData];
    [_tableView1 setHidden:YES];
    [_tableView2 setHidden:NO];
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
