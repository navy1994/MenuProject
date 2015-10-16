//
//  HomeViewController.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/12.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "NetworkSingleton.h"
#import "NetworkSingleton.h"

#import <DYMRollingBanner/DYMRollingBannerVC.h>
#import "UIImage+UIColor.h"
#import "UISearchView.h"

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
    
    UISearchView *_searchView;
    UIButton *_videoBtn;
    
    UIActivityIndicatorView *_activityView;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchView *adverSearchView;



/**
 *  请求数据
 */
- (void)getAdvertImageData;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillApper");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidapper");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    [self setupUI];
    
    //[self getAdvertImageData];
    
}

- (void)setupUI{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor clearColor] colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
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
    _rollingBannerVC.rollingImages = @[[UIImage imageNamed:@"advert1"]
                                       , [UIImage imageNamed:@"advert2"]
                                       , [UIImage imageNamed:@"advert3"]
                                       , [UIImage imageNamed:@"advert2"]    // Local Image
                                       , [UIImage imageNamed:@"advert3"]    // Locak Image
                                       ];
    
    [_rollingBannerVC addBannerTapHandler:^(NSInteger whichIndex) {
        NSLog(@"banner tapped, index = %@", @(whichIndex));
    }];
    
    [_rollingBannerVC startRolling];
    
    self.adverSearchView = [[UISearchView alloc]initWithFrame:CGRectMake(10, -40, screen_width-20, 30)];
    _adverSearchView.alpha = 0.8;
    [_tableView addSubview:_adverSearchView];
    
    //自定义标题
    _searchView = [[UISearchView alloc]initWithFrame:CGRectMake(10, 0, screen_width-20, 30)];
    
    
    self.navigationItem.titleView = _searchView;
    _searchView.alpha = 0;
    
}

//- (void)getAdvertImageData{
//    NSString *dayStr = @"早餐";
//    NSString *urlStr = [NSString stringWithFormat:@"http://apis.juhe.cn/cook/query?key=%s&menu=%@&rn=10&pn=3",appkey,dayStr];
//    [_activityView startAnimating];
//    [[NetworkSingleton sharedManager] getShopResult:nil url:urlStr successBlock:^(id responseBody){
//           // NSLog(@"店铺详情请求成功");
//           // NSLog(@"result=%@",responseBody);
//            NSDictionary *result = [responseBody objectForKey:@"result"];
//            if (result) {
//                NSLog(@"结果：%@",result);
//                NSMutableArray *imageArray = [[NSMutableArray alloc]init];
//                for (int i=0; i<3; i++) {
//                    UIImage *image = [[[[result objectForKey:@"data"]objectAtIndex:rand()%10]objectForKey:@"albums"]objectAtIndex:0];
//                    NSLog(@"image%@",image);
//                    [imageArray addObject:image];
//                }
//                
//                NSLog(@"图片%@",_advertArray);
//                _rollingBannerVC.rollingImages = imageArray;
//            }
//            
//            [_activityView stopAnimating];
//            
//        } failureBlock:^(NSString *error){
//            NSLog(@"店铺详情请求失败：%@",error);
//        }];
//
//}

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
