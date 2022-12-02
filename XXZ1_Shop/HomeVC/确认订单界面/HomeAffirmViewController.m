//
//  HomeAffirmViewController.m
//  XXZ1_Shop
//
//  Created by BH on 2022/12/2.
//

#import "HomeAffirmViewController.h"
#import "HomeAddAddressViewController.h"

@interface HomeAffirmViewController ()
@property (weak, nonatomic) IBOutlet UIView *addressView;

@end

@implementation HomeAffirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    
    
    
    self.cellTitle.text = self.startDic[@"title"];
    [self.cellImv sd_setImageWithURL:self.startDic[@"pict_url"]];
    self.cellPrice.text =  self.cellTotalPriceBottom.text = [NSString stringWithFormat:@"¥%.2f",[self.startDic[@"quanhou_jiage"] doubleValue]];
    self.cellTotalPrice.text = [NSString stringWithFormat:@"%.2f元",[self.startDic[@"quanhou_jiage"] doubleValue]];
    self.cellYouhuiquan.text = self.startDic[@"coupon_info"];
    self.cellYouhui.text = [NSString stringWithFormat:@"品牌:%@ 分类:%@",self.startDic[@"pinpai_name"],self.startDic[@"level_one_category_name"]];
    
    
    __weak typeof(self) weakSelf = self;
    [self.addressView rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        HomeAddAddressViewController * vc = [HomeAddAddressViewController alloc];
        vc.clickSaveBlock = ^(NSDictionary *dic) {
            weakSelf.adressName.text = dic[@"name"];
            weakSelf.adressPhone.text = dic[@"phone"];
            weakSelf.adressLbl.text = dic[@"address"];
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
  
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
