//
//  SearchDetailViewController.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/22.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "SearchDetailTableViewCell.h"
#import "DeatilView.h"
#import "MenuTableViewCell.h"

@interface SearchDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    float ret;
}

@property (nonatomic,strong) NSArray *stepArray;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) DeatilView *detailView;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SearchDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    self.navigationController.navigationBar.alpha = 1;
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  设置导航栏
     */
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB(255.0, 255.0, 255.0) colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];

    
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[_detailDic objectForKey:@"albums"]objectAtIndex:0]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    ret = self.image.size.height / self.image.size.width;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.detailView = [[DeatilView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_width*2/3+240)];
    _detailView.rootImgeView.image = self.image;
    _detailView.titleLabel.text = [_detailDic objectForKey:@"title"];
    _detailView.ingreLabel.text = [_detailDic objectForKey:@"ingredients"];
    _detailView.burdenLabel.text = [_detailDic objectForKey:@"burden"];
    
    self.stepArray = [_detailDic objectForKey:@"steps"];
    
    //注册
    [SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
    [SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
    //设定图片存储顺序
    [SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
    SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;

}

#pragma mark ----- UITableViewDatabase
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 1){
        return _stepArray.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return screen_width*2/3+250;
    }else{
        return 150;
    }
    
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"步骤";
    }else if(section == 2){
        return @"小贴士";
    }else{
        return nil;
    }
}


- (MenuTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //	static NSString *Indetifier = @"cell";
    //	MenuTableViewCell *cell = (MenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indetifier];
    //	if (!cell) {
    //		cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
    //
    //	}
    MenuTableViewCell *cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
        [cell.contentView addSubview:_detailView];
    }else if(indexPath.section == 1){
        [self initCell:cell cellAtIndexPath:indexPath];
        
    }else{
        cell.tags.frame = CGRectMake(10, 10, screen_width-20, 80);
        cell.tags.numberOfLines = 5;
        cell.tags.text = [_detailDic objectForKey:@"imtro"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	   return cell;
}

- (void)initCell:(MenuTableViewCell*)cell cellAtIndexPath:(NSIndexPath *)indexPath{
    cell.tags.frame = CGRectMake(10, 10, screen_width-20, 50);
    cell.tags.numberOfLines = 3;
    cell.tags.text = [NSString stringWithFormat:@"%@",[[[_detailDic objectForKey:@"steps"]objectAtIndex:indexPath.row]objectForKey:@"step"]];
    cell.imageView.frame = CGRectMake(20, 65, 130, 95);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[[[[_detailDic objectForKey:@"steps"]objectAtIndex:indexPath.row]objectForKey:@"img"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                      placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
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
