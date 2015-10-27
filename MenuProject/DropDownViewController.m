//
//  DropDownViewController.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/23.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "DropDownViewController.h"
#import "TapSearchViewController.h"

#import "JSDropDownMenu.h"

#import "SearchDetailTableViewCell.h"

@interface DropDownViewController ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>{
    JSDropDownMenu *menu;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DropDownViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"菜谱分类";
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_homepage_search"] style:UIBarButtonItemStyleDone target:self action:@selector(clickBtnToSearch)];
    
    /**
     *  设置下拉菜单
     */
    
    menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:35];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.backgroundColor = [UIColor whiteColor];
    menu.tintColor = [UIColor whiteColor];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
    NSLog(@"data:%@",_data);
    NSLog(@"select:%@",_menuData);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, screen_width, screen_height-100) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 90;
    _tableView.dataSource = self;
    _tableView.delegate = self;

    
    //注册
    [SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
    [SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
    //设定图片存储顺序
    [SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
    SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
    
    


}

#pragma mark --- SDropDownMenuDelegate

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{
    return 1;
}

- (BOOL)haveRightTableViewInColumn:(NSInteger)column{
    return YES;
}

- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    return 0.3;
}

- (NSInteger)currentLeftSelectedRow:(NSInteger)column{
    return _currentData1Index;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    if (leftOrRight == 0) {
        return _data.count;
    }else{
        return [[[_data objectAtIndex:leftRow]objectForKey:@"list"]count];
    }
}

- (NSString*)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    if (_isClassity) {
        NSLog(@"select=%@",[[[_data[_currentData1Index]objectForKey:@"list"]objectAtIndex:_currentData1SelectedIndex]objectForKey:@"name"]);
        return [[[_data[_currentData1Index]objectForKey:@"list"]objectAtIndex:_currentData1SelectedIndex]objectForKey:@"name"];
        
    }else{
        return _selectMenu;
    }
    
}

- (NSString*)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
    if (indexPath.leftOrRight == 0){
        return [[_data objectAtIndex:indexPath.row]objectForKey:@"name"];
    }else{
        return [[[[_data objectAtIndex:indexPath.leftRow]objectForKey:@"list"]objectAtIndex:indexPath.row]objectForKey:@"name"];
    }
    
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
    if (indexPath.leftOrRight == 0) {
        _currentData1Index = indexPath.row;
        return;
    }else{
        
        _currentData1SelectedIndex = indexPath.row;
        
        NSString *urlStr = [NSString stringWithFormat:@"http://apis.juhe.cn/cook/index?key=%s&cid=%@",appkey,[[[_data[_currentData1Index]objectForKey:@"list"]objectAtIndex:_currentData1SelectedIndex]objectForKey:@"id"]];
        [_activityView startAnimating];
        [[NetworkSingleton sharedManager] getShopResult:nil url:urlStr successBlock:^(id responseBody){
            
            [self getMenuDataForSort:[responseBody objectForKey:@"result"]];
            [_activityView stopAnimating];
        } failureBlock:^(NSString *error){
            NSLog(@"店铺详情请求失败：%@",error);
        }];
       
    }
}

- (void)getMenuDataForSort:(id)result{
    _menuData = [result objectForKey:@"data"];
    [_tableView reloadData];
}

#pragma mark ----- UITableViewDatabase
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (SearchDetailTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndetifier = @"cell";
    SearchDetailTableViewCell *cell = (SearchDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIndetifier];
    
    if (!cell) {
        cell = [[SearchDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndetifier];
    }
    if (_menuData) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[[[[_menuData objectAtIndex:indexPath.row]objectForKey:@"albums"]objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                          placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
        cell.titleLB.text = [[_menuData objectAtIndex:indexPath.row]objectForKey:@"title"];
        cell.tipsLB.text = [[_menuData objectAtIndex:indexPath.row]objectForKey:@"tags"];
        cell.browseLB.text = @"34664浏览";
        cell.collectLB.text = @"65553收藏";
    }
    
    return cell;
}



- (void)clickBtnToSearch{
    TapSearchViewController *searchViewController = [[TapSearchViewController alloc]init];
    searchViewController.isSearch = NO;
    [self.navigationController pushViewController:searchViewController animated:YES];
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
