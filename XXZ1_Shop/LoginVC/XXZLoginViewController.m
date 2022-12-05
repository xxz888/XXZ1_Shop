//
//  XXZLoginViewController.m
//  XXZ1_Shop
//
//  Created by BH on 2022/12/5.
//

#import "XXZLoginViewController.h"
#import "HomeViewController.h"
#import "BaseTabBarViewController.h"
@interface XXZLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accTf;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf;
@property (weak, nonatomic) IBOutlet UIButton *duihaoBtn;

@end

@implementation XXZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
}
- (IBAction)loginAction:(id)sender {
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    BaseTabBarViewController *tabber = [BaseTabBarViewController new];
    app.window.rootViewController = tabber;
    
    
    
}
- (IBAction)registerAction:(id)sender {
}
- (IBAction)selectXuanzhongAction:(id)sender {
}
- (IBAction)shiyongxieyiAction:(id)sender {
}
- (IBAction)yinsixieyiActino:(id)sender {
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
