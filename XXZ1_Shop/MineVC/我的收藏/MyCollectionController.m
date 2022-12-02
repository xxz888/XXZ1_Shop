//
//  MyCollectionController.m
//  XXZ1_Shop
//
//  Created by BH on 2022/11/29.
//

#import "MyCollectionController.h"
#import "MyCollectionCell.h"
#import "HomeHeaderView.h"
#import "ANBannerVIew.h"
#import "JDMarqueeView.h"
#import "HomeClassifyViewController.h"
#import "ShopDetailViewController.h"

@interface MyCollectionController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)HomeHeaderView * headerView;
@property (nonatomic ,assign)CGFloat headerViewHeight;
@property (nonatomic ,strong)NSMutableArray * fourArray;

@end

@implementation MyCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerViewHeight = 0;
    [self initUI];


    self.title = @"我的收藏";
  self.dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"collectGoods"];

}

#pragma mark -  初始化UI
-(void)initUI{
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight);
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCollectionCell" bundle:nil] forCellReuseIdentifier:@"MyCollectionCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  
    
     
}
-(HomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, self.headerViewHeight)];
    
    }
    return _headerView;
}

#pragma mark -  tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    NSDictionary * dic = self.dataArray[indexPath.row];
    cell.cellTitle.text = dic[@"title"];
    cell.cellPrice.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"quanhou_jiage"] doubleValue]];
    cell.cellCount.text = [NSString stringWithFormat:@"库存:%@个",dic[@"sellCount"]];
    [cell.cellImv sd_setImageWithURL:[NSURL URLWithString:dic[@"pict_url"]]];
    
    
    
    if ([dic[@"quanhou_jiage"] doubleValue] < 60) {
        cell.tip1Lbl.hidden = NO;
        cell.tip2Lbl.hidden = YES;
        cell.tip3Lbl.hidden = YES;
    }
    else if ([dic[@"quanhou_jiage"] doubleValue] > 60 && [dic[@"quanhou_jiage"] doubleValue] < 200) {
        cell.tip1Lbl.hidden = NO;
        cell.tip2Lbl.hidden = NO;
        cell.tip3Lbl.hidden = YES;
    }else{
        cell.tip1Lbl.hidden = NO;
        cell.tip2Lbl.hidden = NO;
        cell.tip3Lbl.hidden = NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopDetailViewController * vc = [[ShopDetailViewController alloc]init];
    vc.startDic = self.dataArray[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: vc animated:YES];
}

@end
