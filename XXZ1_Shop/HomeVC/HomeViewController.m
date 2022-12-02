//
//  HomeViewController.m
//  XXZ1_Shop
//
//  Created by BH on 2022/11/29.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeHeaderView.h"
#import "ANBannerVIew.h"
#import "JDMarqueeView.h"
#import "HomeClassifyViewController.h"
#import "ShopDetailViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)HomeHeaderView * headerView;
@property (nonatomic ,assign)CGFloat headerViewHeight;
@property (nonatomic ,strong)NSMutableArray * fourArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerViewHeight = 0;
    [self initUI];
    [self getData];
    [self getLunbo];
    [self open_item_guess_like];
    [self getPaomadeng];


}

-(void)getData{
    NSString * url = [NSString stringWithFormat:@"https://api.zhetaoke.com:10001/api/open_item_guess_like.ashx?appkey=f6cfb493dd7843b49b4f9bb5d839c061&sid=160008&page=%ld&page_size=10",self.page];
    [XXZHttpUtil getWithURLString:url parameters:@{} success:^(id res) {
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:res[@"content"]];
        [self requestDataCompleted];

    } failure:^(NSError *error) {
        
    }];
    
    

}
-(void)open_item_guess_like{
    self.fourArray = [[NSMutableArray alloc]init];
    [XXZHttpUtil getWithURLString:@"https://api.zhetaoke.com:10001/api/open_item_guess_like.ashx?appkey=f6cfb493dd7843b49b4f9bb5d839c061&&sid=160008&page=3&page_size=10" parameters:@{} success:^(id res) {
        
        [self.headerView.img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",res[@"content"][0][@"pict_url"]]]];
        [self.headerView.img2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",res[@"content"][1][@"pict_url"]]]];
        [self.headerView.img3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",res[@"content"][2][@"pict_url"]]]];
        [self.headerView.img4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",res[@"content"][3][@"pict_url"]]]];

        [self.fourArray addObjectsFromArray:res[@"content"]];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    [self.headerView.img1 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self jumpDetail:self.fourArray[0]];
    }];
    
    [self.headerView.img2 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self jumpDetail:self.fourArray[1]];
    }];
    
    [self.headerView.img3 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self jumpDetail:self.fourArray[2]];
    }];
    
    [self.headerView.img4 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self jumpDetail:self.fourArray[3]];
    }];
}
-(void)jumpDetail:(NSDictionary *)startDic{
    ShopDetailViewController * vc = [[ShopDetailViewController alloc]init];
    vc.startDic = startDic;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: vc animated:YES];
}

-(void)getLunbo{
    [XXZHttpUtil getWithURLString:@"https://api.zhetaoke.com:10001/api/api_lunbo.ashx?appkey=f6cfb493dd7843b49b4f9bb5d839c061&page=1&page_size=20" parameters:@{} success:^(id res) {
        
        NSMutableArray * array = [[NSMutableArray alloc]init];
        
        
        for (NSDictionary * dic in res[@"content"]) {
            [array addObject:dic[@"pic"]];
        }
        ANBannerVIew * bannerViews =[[ANBannerVIew alloc]initViewWithFrame: CGRectMake(0, 0, KScreenWidth, 0) autoPlayTime:3.0f imagesArray:array clickCallBack:^(NSInteger index) {
        
        }];
        [self.headerView.lunboView addSubview:bannerViews];
        
        

    } failure:^(NSError *error) {
        
    }];
    
    
    
    


}
-(void)getPaomadeng{
    // Do any additional setup after loading the view.
    JDMarqueeView *view =[[JDMarqueeView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44) andMessage:@"防诈骗知识：1、不要轻易相信来历不明的电话或者短信，避免给不法分子进一步设下圈套的机会。2、不要轻易地向陌生人透露自己以及家人的身份信息、存款等，尤其是在公共场合。 3、不要轻易地向陌生人汇款、转账，若是遇到必须要汇款、转账的情况一定要再三核实对方的信息。4、不要有贪小便宜的心理，毕竟世界上没有免费的东西。5、要注意向家里的老人科普诈骗等知识，这样可以在平时提高一些警惕。6、不要让家里的老人独自带大量现金出门，容易引起不法分子注意。7、家里面不要保存过多的贵重物品或是现金，若是必须放家里的一定要妥善保管好。8、家里面的存折、信用卡、银行卡等密码一定要保密，不要随意向他人透露。9、要相信科学，不要盲目迷信，如果生病了一定要及时就医，不要相信所谓的巫医、游医等，若是发现了可疑情况，一定要及时报警。10、若是有人用大钱换零钱或是主动用零钱换整钱的时候，一定要多加注意，防止被骗。"];
    [self.headerView addSubview:view];
}
#pragma mark -  初始化UI
-(void)initUI{
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight - kTabBarHeight);
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.sectionHeaderHeight = self.headerViewHeight;
    
    
    __weak typeof(self) weakSelf = self;
    self.headerView.clickSegmentBlock = ^(NSInteger index) {
        weakSelf.page = index + 4;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf getData];
    };
    
    
    
    //一级商品分类，值为空：全部商品，1：女装，2：母婴，3：美妆，4：居家日用，5：鞋品，6：美食，7：文娱车品，8：数码家电，9：男装，10：内衣，11：箱包，12：配饰，13：户外运动，14：家装家纺

    [self.headerView.stackView1 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        HomeClassifyViewController * vc = [[HomeClassifyViewController alloc]init];
        vc.cid = @"1";
        vc.navTitle = @"女装";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.headerView.stackView2 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        HomeClassifyViewController * vc = [[HomeClassifyViewController alloc]init];
        vc.cid = @"2";
        vc.navTitle = @"母婴";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.headerView.stackView3 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        HomeClassifyViewController * vc = [[HomeClassifyViewController alloc]init];
        vc.cid = @"9";
        vc.navTitle = @"男装";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.headerView.stackView4 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        HomeClassifyViewController * vc = [[HomeClassifyViewController alloc]init];
        vc.cid = @"6";
        vc.navTitle = @"美食";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
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
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
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
#pragma mark ————— 下拉刷新 —————
-(void)headerRereshing{
    self.page = 1;
    [self getData];
}

#pragma mark ————— 上拉刷新 —————
-(void)footerRereshing{
    self.page += 1;
    [self getData];
}


#pragma mark -  logic delegate
-(void)requestDataCompleted{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

@end
