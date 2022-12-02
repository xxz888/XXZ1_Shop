//
//  AppDelegate.m
//  XXZ1_Shop
//
//  Created by BH on 2022/11/29.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import <MeiQiaSDK/MQManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    BaseTabBarViewController *tabber = [BaseTabBarViewController new];
    self.window.rootViewController = tabber;
    [self.window makeKeyAndVisible];
    
    
    
    //启用IQKeyboardManager 默认为YES
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    //键盘弹出时，点击背景，键盘收回
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    
    //通知红点
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
   
    self.collectionArray = [[NSMutableArray alloc]init];
    [[NSUserDefaults standardUserDefaults] setValue:self.collectionArray forKey:@"collectGoods"];

    
    [MQManager initWithAppkey:@"4e8f68376b2631a96dc3e47b52ac080d" completion:^(NSString *clientId, NSError *error) {
            if (!error) {
                NSLog(@"美洽 SDK：初始化成功");
            } else {
                NSLog(@"error:%@",error);
            }
        }];
    
    
    return YES;
}





@end
