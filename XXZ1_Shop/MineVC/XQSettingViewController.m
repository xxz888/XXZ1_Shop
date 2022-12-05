//
//  XQSettingViewController.m
//  Mine
//
//  Created by Ticsmatic on 2017/10/12.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import "XQSettingViewController.h"
#import <YYModel.h>
#import "XQSettingItem.h"
#import "XQSettingTableViewCell.h"
#import "XQSettingHeader.h"
#import <Masonry.h>
#import "MyCollectionController.h"
#import <MeiQiaSDK/MQManager.h>
#import "MQChatViewController.h"
#import "MQChatViewManager.h"
#import "HomeAddAddressViewController.h"
#import "HelpViewController.h"
#import "XXZLoginViewController.h"

@interface XQSettingViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerBgImageView;
@property (nonatomic, strong) XQSettingHeader *header;
@property (strong, nonatomic) NSMutableArray *sectionArray;
@end

@implementation XQSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupHeaderView];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 

- (void)setupUI {
    self.title = @"我的";
    [self.tableView registerNib:[UINib nibWithNibName:@"XQSettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"XQSettingTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"logoutID"];
}

- (void)setupData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSArray *sectionArray = [NSArray yy_modelArrayWithClass:[XQSettingSection class] json:[NSArray arrayWithContentsOfFile:path]];
    self.sectionArray = [sectionArray mutableCopy];
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    [self.tableView addSubview:self.headerBgImageView];
    UIView *headerContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 200)];
    [headerContainer addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerContainer);
    }];
    self.tableView.tableHeaderView = headerContainer;
    [self.tableView bringSubviewToFront:headerContainer];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XQSettingSection *group = self.sectionArray[section];
    return group.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XQSettingSection *section = self.sectionArray[indexPath.section];
    XQSettingItem *item = section.items[indexPath.row];
    return item.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    XQSettingSection *group = self.sectionArray[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    XQSettingSection *group = self.sectionArray[section];
    return group.footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XQSettingSection *section = self.sectionArray[indexPath.section];
    XQSettingItem *item = section.items[indexPath.row];
    if (item.custom) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.customReuseID forIndexPath:indexPath];
        cell.contentView.backgroundColor = CNavBgColor;
        cell.textLabel.textColor = KWhiteColor;
        cell.textLabel.text = item.title;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    } else {
        XQSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XQSettingTableViewCell"];
        cell.data = item;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  

    XQSettingSection *section = self.sectionArray[indexPath.section];
    XQSettingItem *item = section.items[indexPath.row];
    if ([item.title isEqualToString:@"我的收藏"]) {
        MyCollectionController * vc = [[MyCollectionController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item.title isEqualToString:@"绑定管理"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"绑定支付宝" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        //添加文本框
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            //设置键盘输入为数字键盘
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.placeholder = @"请填写支付宝账号";
        }];

        UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //取消
        }];
        [alert addAction: cancelBtn];
            
        //添加确定按钮
        UIAlertAction *confirmBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"%@", [alert.textFields firstObject].text);
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"绑定成功";
            hud.margin = 10.f;
            hud.yOffset = 150.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
        }];
        [alert addAction: confirmBtn];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    if ([item.title isEqualToString:@"注销账号"]) {
        //创建对象
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注销账号" message:@"账号注销后，会导致账号永久销户无法恢复！" preferredStyle:UIAlertControllerStyleAlert];
           
        //添加销毁按钮
        UIAlertAction* destructiveBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"此账号销户需联系客服";
            hud.margin = 10.f;
            hud.yOffset = 150.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
        }];
        [alert addAction: destructiveBtn];


        //添加取消按钮
        UIAlertAction* cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
          
        }];
        [alert addAction:cancelBtn];
        [self presentViewController:alert animated:YES completion:nil];

    }
    if ([item.title isEqualToString:@"在线客服"]) {
        
        NSDictionary* clientCustomizedAttrs = @{
        @"name"        : @"Kobe Bryant",
        @"avatar"      : @"http://meiqia.com/avatar.png",
        @"身高"         : @"1.98m",
        @"体重"         : @"93.0kg",
        @"效力球队"      : @"洛杉矶湖人队",
        @"场上位置"      : @"得分后卫",
        @"球衣号码"      : @"24号"
        };
     
        MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
        [chatViewManager setClientInfo:clientCustomizedAttrs ];
        [chatViewManager enableRoundAvatar:YES];
        [chatViewManager setAgentName:@""];
        [chatViewManager pushMQChatViewControllerInViewController:self.navigationController];

    }
    if ([item.title isEqualToString:@"版本升级"]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"已经是最新版本";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
    if ([item.title isEqualToString:@"收货地址"]) {
        HomeAddAddressViewController * vc = [HomeAddAddressViewController alloc];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([item.title isEqualToString:@"帮助中心"]) {
        HelpViewController * vc = [HelpViewController alloc];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([item.title isEqualToString:@"退出账号"]) {
        
        //创建对象
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定退出登录吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
           
        //添加销毁按钮
        UIAlertAction* destructiveBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
            
            AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
            XXZLoginViewController * vc = [XXZLoginViewController alloc];
            BaseNavigationViewController * nav = [[BaseNavigationViewController alloc]initWithRootViewController:vc];
            app.window.rootViewController = nav;
        }];
        [alert addAction: destructiveBtn];


        //添加取消按钮
        UIAlertAction* cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
          
        }];
        [alert addAction:cancelBtn];
        [self presentViewController:alert animated:YES completion:nil];
        

    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f",offsetY);
    if (offsetY < 0) {
        self.headerBgImageView.frame = CGRectMake(offsetY/2, offsetY, self.view.frame.size.width - offsetY, 200 - offsetY);
    }
}


#pragma mark - Action

- (void)goHomeAction { NSLog(@"%s", __func__); }

- (void)goBalanceAction { NSLog(@"%s", __func__); }

- (void)goMessageCenterAction { NSLog(@"%s", __func__); }

- (void)goCollectionAction { NSLog(@"%s", __func__); }

- (void)goFavorAction { NSLog(@"%s", __func__); }

- (void)goQuestionAction { NSLog(@"%s", __func__); }

- (void)goTeaTopicAction { NSLog(@"%s", __func__); }

- (void)goFocusAction { NSLog(@"%s", __func__); }

- (void)goFansAction { NSLog(@"%s", __func__); }

- (void)goBindingAction { NSLog(@"%s", __func__); }

- (void)goHelpAction { NSLog(@"%s", __func__); }

- (void)goShareAction { NSLog(@"%s", __func__); }

- (void)logoutAction { NSLog(@"%s", __func__); }

#pragma mark - Getter

- (XQSettingHeader *)header {
    if (_header == nil) {
        _header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XQSettingHeader class]) owner:nil options:nil] lastObject];
    }
    return _header;
}

- (UIImageView *)headerBgImageView {
    if (_headerBgImageView == nil) {
        _headerBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _headerBgImageView.image = [UIImage imageNamed:@"mine_bg"];
        _headerBgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerBgImageView.autoresizesSubviews = YES;
    }
    return _headerBgImageView;
}
@end
