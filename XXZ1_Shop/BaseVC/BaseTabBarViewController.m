//
//  BaseTabBarViewController.m
//  XXZ1_Shop
//
//  Created by BH on 2022/11/29.
//

#import "BaseTabBarViewController.h"
#import "HomeViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "MineViewController.h"

#import "BaseNavigationViewController.h"

@interface BaseTabBarViewController ()<UITabBarControllerDelegate>
@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.view.backgroundColor = KWhiteColor;
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self setUpAllChildViewController];
}

-(void)setUpAllChildViewController{
    _VCS = @[].mutableCopy;

    HomeViewController * VC1 = [[HomeViewController alloc]init];
    [self setupChildViewController:VC1 title:@"首页" imageName:@"icon_tabbar_onsite" seleceImageName:@"icon_tabbar_onsite_selected"];
    

    
    SecondViewController * VC2 = [[SecondViewController alloc]init];
    [self setupChildViewController:VC2 title:@"分类" imageName:@"icon_tabbar_homepage" seleceImageName:@"icon_tabbar_homepage_selected"];
    
    ThirdViewController * VC3 = [[ThirdViewController alloc]init];
    [self setupChildViewController:VC3 title:@"消息" imageName:@"icon_tabbar_merchant_normal" seleceImageName:@"icon_tabbar_merchant_selected"];
    
    
    MineViewController * VC4 = [[MineViewController alloc]init];
    [self setupChildViewController:VC4 title:@"我的" imageName:@"icon_tabbar_mine" seleceImageName:@"icon_tabbar_mine_selected"];
    
    
    
    self.viewControllers = _VCS;
}
-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:controller];
    
//    [self addChildViewController:nav];
    [_VCS addObject:nav];
    
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
   NSLog(@"选中 %ld",tabBarController.selectedIndex);
}

@end
