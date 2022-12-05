//
//  ThirdViewController.m
//  MRWaterflow
//
//  Created by Andrew554 on 16/8/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "ThirdViewController.h"
#import "MRWaterflowLayout.h"
#import "MRShop.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "BYShopCell.h"
#import "ShopDetailViewController.h"
@interface ThirdViewController () <UICollectionViewDataSource, UICollectionViewDelegate,MRWaterflowLayoutDelegate>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;

@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ThirdViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

static NSString * const MRShopId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"9.9包邮大杂烩";
    [self setupLayout];
    
    [self setupRefresh];
}
-(void)getData1{
    
 
    
    

}
- (void)setupRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.header beginRefreshing];
    
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.footer.hidden = YES;
}

- (void)loadNewShops
{
    
    NSString * url = [NSString stringWithFormat:@"https://api.zhetaoke.com:10001/api/api_all.ashx?appkey=f6cfb493dd7843b49b4f9bb5d839c061&price=0.0-9.9&sid=160008&page=%ld&page_size=100",self.page];
    [XXZHttpUtil getWithURLString:url parameters:@{} success:^(id res) {
        
        [self.shops removeAllObjects];
        [self.dataArray removeAllObjects];
        for (NSDictionary * dic in res[@"content"]) {
            MRShop * model = [[MRShop alloc]init];
            model.w = 275;
            model.h = 300;
            model.price = [NSString stringWithFormat:@"¥%@",dic[@"quanhou_jiage"]];
            model.img = dic[@"pict_url"];
            [self.shops addObject:model];
        }
        [self.dataArray addObjectsFromArray:res[@"content"]];

        [self.collectionView reloadData];
        [self.collectionView.header endRefreshing];
        [self.collectionView.footer endRefreshing];
    } failure:^(NSError *error) {
        
    }];
    

}

- (void)loadMoreShops
{
    self.page += 1;
    //一级商品分类，值为空：全部商品，1：女装，2：母婴，3：美妆，4：居家日用，5：鞋品，6：美食，7：文娱车品，8：数码家电，9：男装，10：内衣，11：箱包，12：配饰，13：户外运动，14：家装家纺
    NSString * url = [NSString stringWithFormat:@"https://api.zhetaoke.com:10001/api/api_all.ashx?appkey=f6cfb493dd7843b49b4f9bb5d839c061&price=0.0-9.9&sid=160008&page=%ld&page_size=100",self.page];
    [XXZHttpUtil getWithURLString:url parameters:@{} success:^(id res) {
        
       
        for (NSDictionary * dic in res[@"content"]) {
            MRShop * model = [[MRShop alloc]init];
            model.w = 275;
            model.h = 300;
            model.price = [NSString stringWithFormat:@"¥%@",dic[@"quanhou_jiage"]];
            model.img = dic[@"pict_url"];
            [self.shops addObject:model];
        }
        [self.dataArray addObjectsFromArray:res[@"content"]];
        [self.collectionView reloadData];
        [self.collectionView.header endRefreshing];
        [self.collectionView.footer endRefreshing];


    } failure:^(NSError *error) {
        
    }];
}

- (void)setupLayout
{
    self.title = @"9.9包邮";
    // 创建布局
    MRWaterflowLayout *layout = [[MRWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BYShopCell class]) bundle:nil] forCellWithReuseIdentifier:MRShopId];
    
    self.collectionView = collectionView;
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BYShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MRShopId forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}

#pragma mark - <MRWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(MRWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    MRShop *shop = self.shops[index];
    
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnCountInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout
{
//    if (self.shops.count <= 50) return 2;
    return 5;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MRWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 20, 30, 20);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self jumpDetail:self.dataArray[indexPath.row]];

}

-(void)jumpDetail:(NSDictionary *)startDic{
    ShopDetailViewController * vc = [[ShopDetailViewController alloc]init];
    vc.startDic = startDic;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: vc animated:YES];
}
@end
