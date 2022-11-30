//
//  ShopDetailViewController.m
//  LemonFish
//
//  Created by BH on 2022/8/18.
//

#import "ShopDetailViewController.h"
#import "ShopDetailHeaderView.h"
#import "MBProgressHUD.h"
#import "HHBannerView.h"
#import "ShopDetailTableViewCell.h"

@interface ShopDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ShopDetailHeaderView *headerView;
@property (nonatomic ,strong) HHBannerView * hhBannerView;
@property (nonatomic ,strong) NSArray * detailImvArray;

@end

@implementation ShopDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight );
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShopDetailTableViewCell"];
    
    self.title = self.startDic[@"title"];
    [self.headerView.cellImv sd_setImageWithURL:self.startDic[@"pict_url"]];
    
    self.headerView.cellTitle.text = self.startDic[@"tao_title"];
    
    self.headerView.cellPrice.text = [NSString stringWithFormat:@"¥%.2f",[self.startDic[@"quanhou_jiage"] doubleValue]];
    
    self.headerView.cellKucun.text = [NSString stringWithFormat:@"库存:%@",self.startDic[@"sellCount"]];
    
    self.headerView.cellAdress.text = self.startDic[@"provcity"];
    
    self.headerView.cellCanshu.text = [NSString stringWithFormat:@"品牌:%@ 分类:%@",self.startDic[@"pinpai_name"],self.startDic[@"level_one_category_name"]];
    
    self.headerView.cell1.text = self.startDic[@"coupon_info"];
    
    self.headerView.cellContent.text = self.startDic[@"jianjie"];
    


        self.hhBannerView = [[HHBannerView alloc]initWithFrame:CGRectMake(0,0 , KScreenWidth, 336) WithBannerSource:1 WithBannerArray:[self.startDic[@"small_images"] componentsSeparatedByString:@"|"]];

    self.detailImvArray = [self.startDic[@"small_images"] componentsSeparatedByString:@"|"];
    self.hhBannerView.timeInterval = 1.5f;
    self.hhBannerView.showPageControl = YES;
    [self.headerView.bannerView addSubview:self.hhBannerView];

    
    
    
    

}


- (ShopDetailHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[ShopDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 1000)];
    }
    return _headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.detailImvArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShopDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShopDetailTableViewCell" forIndexPath:indexPath];
    if ([self.detailImvArray[indexPath.row] containsString:@"http"]) {
        [cell.imv sd_setImageWithURL:self.detailImvArray[indexPath.row]];

    }else{
        cell.imv.image = [UIImage imageNamed:self.detailImvArray[indexPath.row]];
    }
    
    return cell;
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
