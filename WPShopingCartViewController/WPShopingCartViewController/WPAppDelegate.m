//
//  AppDelegate.m
//  WPShopingCartViewController
//
//  Created by 吴鹏 on 16/9/7.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "WPAppDelegate.h"
#import "WPViewController.h"

@implementation WPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    WPViewController * vc = [[WPViewController alloc]init];
    UINavigationController * na = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = na;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
