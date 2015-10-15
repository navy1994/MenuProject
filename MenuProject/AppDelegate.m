//
//  AppDelegate.m
//  MenuProject
//
//  Created by mac- t4 on 15/10/12.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LifeViewController.h"
#import "SurpriseViewController.h"
#import "MineViewController.h"
#import "NetworkSingleton.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initRootVC];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)initRootVC{
    //此处一定要给window一个frame，添加广告image时这个必须要
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    UINavigationController *homeNavigation = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    LifeViewController *lifeViewController = [[LifeViewController alloc] init];
    UINavigationController *lifeNavigation = [[UINavigationController alloc] initWithRootViewController:lifeViewController];
    SurpriseViewController *surpriseViewController = [[SurpriseViewController alloc] init];
    UINavigationController *surpriseNavigation = [[UINavigationController alloc] initWithRootViewController:surpriseViewController];
    MineViewController *mineViewController = [[MineViewController alloc] init];
    UINavigationController *mineNavigation = [[UINavigationController alloc] initWithRootViewController:mineViewController];
    
    homeViewController.title = @"学做菜";
    lifeViewController.title = @"生活圈";
    surpriseViewController.title = @"惊喜";
    mineViewController.title = @"我的";
    
    NSArray *viewControllers = @[homeNavigation, lifeNavigation, surpriseNavigation, mineNavigation];
    
    self.rootTabbarCtr = [[UITabBarController alloc] init];
    [self.rootTabbarCtr setViewControllers:viewControllers];
    self.window.rootViewController = self.rootTabbarCtr;
    
//    UITabBar *tabbar = self.rootTabbarCtr.tabBar;
//    UITabBarItem *homeItem = [tabbar.items objectAtIndex:0];
//    UITabBarItem *lifeItem = [tabbar.items objectAtIndex:1];
//    UITabBarItem *surpriseItem = [tabbar.items objectAtIndex:2];
//    UITabBarItem *mineItem = [tabbar.items objectAtIndex:3];
    
    //改变UITabBarItem字体颜色
    
    UIFont* font = [UIFont fontWithName:@"Arial-ItalicMT" size:20.0];
    NSDictionary* textAttributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:RGB(243, 70, 73)};
    
    [[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateSelected];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.window makeKeyAndVisible];
    
//    NSString *dayStr = @"早餐";
//    NSString *urlStr = [NSString stringWithFormat:@"http://apis.juhe.cn/cook/query?key=%s&menu=%@&rn=10&pn=3",appkey,dayStr];
//    [[NetworkSingleton sharedManager] getShopResult:nil url:urlStr successBlock:^(id responseBody){
//        NSLog(@"店铺详情请求成功");
//        NSLog(@"result=%@",responseBody);
//        NSDictionary *result = [responseBody objectForKey:@"result"];
//        if (result) {
//            homeViewController.advertArray = [result objectForKey:@"data"];
//        }
//        
//    } failureBlock:^(NSString *error){
//        NSLog(@"店铺详情请求失败：%@",error);
//    }];

    
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "maigeli.MenuProject" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MenuProject" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MenuProject.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
