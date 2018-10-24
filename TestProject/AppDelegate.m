//
//  AppDelegate.m
//  TestProject
//
//  Created by lmg on 2018/7/31.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "AppDelegate.h"
#import "WBStatusTimeLineViewController.h"
#import "SDImageCache.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    
//    WBStatusTimeLineViewController *vc = [[WBStatusTimeLineViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        NSLog(@"-------Completion--------");
    }];
}
/*
 静态库：.a 链接时会被完整的复制到可执行文件中去，程序的二进制可执行文件含有这份静态库的代码
 动态库：dtb/dylib  链接时不复制，在程序启动后用dyld加载，好多个程序都可以动态链接到这个动态库上面，达到了节省内存(不是磁盘是内存中只有一份动态库)
 Framework:资源打包方式，和静态库，动态库的本质没有关系

 
 */

@end
