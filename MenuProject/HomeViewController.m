//
//  HomeViewController.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/12.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//
#import "TapAdvertViewController.h"
#import "TapSearchViewController.h"
#import "DropDownViewController.h"

#import "HomeViewController.h"


#import <DYMRollingBanner/DYMRollingBannerVC.h>

#import "HomeCategoryCell.h"
#import "HomeGourmetCell.h"
#import "HomeKnowledgeCell.h"
#import "HomeEndCell.h"

const CGFloat LSWHeaderViewHeight = 200;

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>{
    DYMRollingBannerVC      *_rollingBannerVC;
    MASConstraint *_headerViewLeftConstraint;//左边约束
    MASConstraint *_headerViewWidthConstraint;//宽的约束
    MASConstraint *_headerViewTopConstraint;//上边的约束
    MASConstraint *_headerViewHeightConstraint;//高的约束
    
    UIButton *_videoBtn;
    
    UIActivityIndicatorView *_activityView;
    TapSearchViewController *searchViewController;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchView *adverSearchView;




/**
 *  请求数据
 */

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationItem.titleView setHidden:NO];
    [self.tableView setContentOffset:CGPointMake(0,-LSWHeaderViewHeight) animated:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getAdvertImageData];
    [self initSortData];
    [self initSortMenuDataForID];
}

- (void)setupUI{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor clearColor] colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator =
    NO;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.sectionHeaderHeight = 0;
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset= UIEdgeInsetsMake(LSWHeaderViewHeight, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    _rollingBannerVC = [DYMRollingBannerVC new];
    [self addChildViewController:_rollingBannerVC];
    [_tableView addSubview:_rollingBannerVC.view];
    
    [_rollingBannerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        _headerViewLeftConstraint = make.left.equalTo(@0);
        _headerViewWidthConstraint = make.width.equalTo(@(_tableView.frame.size.width));
        _headerViewTopConstraint = make.top.equalTo(@(-LSWHeaderViewHeight));
        _headerViewHeightConstraint = make.height.equalTo(@(LSWHeaderViewHeight+20));
    }];
    
    [_rollingBannerVC didMoveToParentViewController:self];
    
    _rollingBannerVC.rollingInterval = 5;
//    _rollingBannerVC.rollingImages = @[[UIImage imageNamed:@"advert1"]
//                                       , [UIImage imageNamed:@"advert2"]
//                                       , [UIImage imageNamed:@"advert3"]
//                                       , [UIImage imageNamed:@"advert2"]    // Local Image
//                                       , [UIImage imageNamed:@"advert3"]    // Locak Image
//                                       ];
    
    [_rollingBannerVC addBannerTapHandler:^(NSInteger whichIndex) {
        TapAdvertViewController *tapViewController = [[TapAdvertViewController alloc]init];
        
        [self.navigationItem.titleView setHidden:YES];
        [self.navigationController pushViewController:tapViewController animated:YES];
        
    }];
    [_rollingBannerVC startRolling];
    
    self.adverSearchView = [[UISearchView alloc]initWithFrame:CGRectMake(10, -40, screen_width-20, 30)];
    _adverSearchView.alpha = 0.8;
    _adverSearchView.userInteractionEnabled = YES;
    [_tableView addSubview:_adverSearchView];
    
    //自定义标题
    _searchView = [[UISearchView alloc]initWithFrame:CGRectMake(10, 0, screen_width-20, 30)];
    self.navigationItem.titleView = _searchView;
     _searchView.alpha = 0;
    _searchView.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer*tapRecognizer1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickurl1:)];
    UITapGestureRecognizer*tapRecognizer2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickurl1:)];
    
    [_adverSearchView addGestureRecognizer:tapRecognizer1];
    [_searchView addGestureRecognizer:tapRecognizer2];
    
}

-(void)clickurl1:(id)sender

{
    TapSearchViewController *searchViewController = [[TapSearchViewController alloc]init];
    searchViewController.isSearch = NO;

    [self.navigationItem.titleView setHidden:YES];
    [self.navigationController pushViewController:searchViewController animated:YES];
    
}

- (void)getAdvertImageData{
    NSString *dayStr = @"早餐";
    NSString *urlStr = [NSString stringWithFormat:@"http://apis.juhe.cn/cook/query?key=%s&menu=%@&rn=10&pn=3",appkey,dayStr];
    [_activityView startAnimating];
    [[NetworkSingleton sharedManager] getShopResult:nil url:urlStr successBlock:^(id responseBody){
        
            NSDictionary *result = [responseBody objectForKey:@"result"];
            if (result) {
                NSMutableArray *imageArray = [[NSMutableArray alloc]init];
                for (int i=0; i<3; i++) {
                    UIImage *image = [[[[result objectForKey:@"data"]objectAtIndex:rand()%10]objectForKey:@"albums"]objectAtIndex:0];
                    
                    [imageArray addObject:image];
                }
                
                
                _rollingBannerVC.rollingImages = imageArray;
            }
            
            [_activityView stopAnimating];
            
        } failureBlock:^(NSString *error){
            NSLog(@"店铺详情请求失败：%@",error);
        }];

}

- (void)initSortData{
    
        NSString *urlStr = [NSString stringWithFormat:@"http://apis.juhe.cn/cook/category?key=%s",appkey];
        [_activityView startAnimating];
        [[NetworkSingleton sharedManager] getShopResult:nil url:urlStr successBlock:^(id responseBody){

            [self getSortData:[responseBody objectForKey:@"result"]];
                [_activityView stopAnimating];
            } failureBlock:^(NSString *error){
                NSLog(@"店铺详情请求失败：%@",error);
            }];

}

- (void)getSortData:(id)result{
    self.sortMenuName = [[NSArray alloc]init];
    _sortMenuName = result;
    //NSLog(@"_sortMenuName:%@",_sortMenuName);
}

- (void)initSortMenuDataForID{
    NSString *urlStr = [NSString stringWithFormat:@"http://apis.juhe.cn/cook/index?key=%s&cid=1",appkey];
    [_activityView startAnimating];
    [[NetworkSingleton sharedManager] getShopResult:nil url:urlStr successBlock:^(id responseBody){
        
        [self getMenuDataForSort:[responseBody objectForKey:@"result"]];
        [_activityView stopAnimating];
    } failureBlock:^(NSString *error){
        NSLog(@"店铺详情请求失败：%@",error);
    }];

}

- (void)getMenuDataForSort:(id)result{
    self.menuForSort = [[NSDictionary alloc]init];
    _menuForSort = result;
}

#pragma mark - tableViewDelegate&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *height = @[@150, @100, @135, @180, @80];
    return [[height objectAtIndex:indexPath.section]floatValue];
    //return 150;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        static NSString *cellIndentifier = @"CategoryCell";
        HomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomeCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        for (int i=1; i<13; i++) {
            UIButton *categoryBtn = (UIButton*)[cell.contentView viewWithTag:i*100];
            [categoryBtn addTarget:self action:@selector(clickCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.section == 1){
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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
        
    }else if (indexPath.section == 2){
        
        static NSString *cellIndentifier = @"GourmetCell";
        HomeGourmetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomeGourmetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.section == 3){
        
        static NSString *cellIndentifier = @"knowledgecell";
        HomeKnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomeKnowledgeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    }else{//推荐
        static NSString *cellIndentifier = @"endcell";
        HomeEndCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomeEndCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)clickCategoryBtn:(UIButton*)sender{
    if (sender.tag !=12*100) {
        searchViewController = [[TapSearchViewController alloc]init];
        
        searchViewController.isSearch = YES;
        searchViewController.textFiledString = sender.titleLabel.text;
        [searchViewController.textField resignFirstResponder];
        [self.navigationItem.titleView setHidden:YES];
        [self initSearchData:sender.titleLabel.text];
        
    }else{
        
        DropDownViewController *dropDownViewController = [[DropDownViewController alloc]init];
        [self.navigationItem.titleView setHidden:YES];
        dropDownViewController.data = _sortMenuName;
        dropDownViewController.isClassity = NO;
        dropDownViewController.currentData1Index = 0;
        dropDownViewController.currentData1SelectedIndex = 0;
        dropDownViewController.menuData = [_menuForSort objectForKey:@"data"];
        dropDownViewController.selectMenu = [[[[_sortMenuName objectAtIndex:0]objectForKey:@"list"]objectAtIndex:0]objectForKey:@"name"];
        [self.navigationController pushViewController:dropDownViewController animated:YES];

    }
    
}

- (void)initSearchData:(NSString *)menuString{
    NSString *urlStr = [NSString stringWithFormat:@"http://apis.juhe.cn/cook/query?key=%s&menu=%@&rn=10&pn=3",appkey,menuString];
    [_activityView startAnimating];
    [[NetworkSingleton sharedManager] getShopResult:nil url:urlStr successBlock:^(id responseBody){
        
        [self getSearchData:[[responseBody objectForKey:@"result"]objectForKey:@"data"]];
        
        [_activityView stopAnimating];
        
    } failureBlock:^(NSString *error){
        NSLog(@"店铺详情请求失败：%@",error);
    }];
}

- (void)getSearchData:(id)resultData{
    if (resultData) {
        searchViewController.menuData = resultData;
    }else{
        searchViewController.menuData = nil;
    }
    
    [self.navigationController pushViewController:searchViewController animated:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + LSWHeaderViewHeight)/2;
    if (yOffset < -LSWHeaderViewHeight) {
        _headerViewTopConstraint.offset = yOffset;
        _headerViewLeftConstraint.offset = xOffset;
        _headerViewWidthConstraint.offset = _tableView.frame.size.width + fabs(xOffset) * 2;
        _headerViewHeightConstraint.offset = -yOffset+20;
    }
        CGFloat alpha = (yOffset + LSWHeaderViewHeight)/LSWHeaderViewHeight;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB(260.0, 260.0, 248.0) colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
         _searchView.alpha = alpha;
    self.navigationController.navigationBar.alpha = alpha;
//        alpha = fabs(alpha);
//        alpha = fabs(1 - alpha);
//        alpha = alpha < 0.5 ? 0.5 : alpha;
//        _rollingBannerVC.view.alpha = alpha;
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
