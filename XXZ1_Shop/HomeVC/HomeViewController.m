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
    JDMarqueeView *view =[[JDMarqueeView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44) andMessage:@"??????????????????1???????????????????????????????????????????????????????????????????????????????????????????????????????????????2??????????????????????????????????????????????????????????????????????????????????????????????????????????????? 3????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????4???????????????????????????????????????????????????????????????????????????5????????????????????????????????????????????????????????????????????????????????????????????????6??????????????????????????????????????????????????????????????????????????????????????????7???????????????????????????????????????????????????????????????????????????????????????????????????????????????8??????????????????????????????????????????????????????????????????????????????????????????????????????9?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????10??????????????????????????????????????????????????????????????????????????????????????????????????????????????????"];
    [self.headerView addSubview:view];
}
#pragma mark -  ?????????UI
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
    
    
    
    //????????????????????????????????????????????????1????????????2????????????3????????????4??????????????????5????????????6????????????7??????????????????8??????????????????9????????????10????????????11????????????12????????????13??????????????????14???????????????

    [self.headerView.stackView1 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        HomeClassifyViewController * vc = [[HomeClassifyViewController alloc]init];
        vc.cid = @"1";
        vc.navTitle = @"??????";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.headerView.stackView2 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        HomeClassifyViewController * vc = [[HomeClassifyViewController alloc]init];
        vc.cid = @"2";
        vc.navTitle = @"??????";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.headerView.stackView3 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        HomeClassifyViewController * vc = [[HomeClassifyViewController alloc]init];
        vc.cid = @"9";
        vc.navTitle = @"??????";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.headerView.stackView4 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        HomeClassifyViewController * vc = [[HomeClassifyViewController alloc]init];
        vc.cid = @"6";
        vc.navTitle = @"??????";
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
    cell.cellPrice.text = [NSString stringWithFormat:@"??%.2f",[dic[@"quanhou_jiage"] doubleValue]];
    cell.cellCount.text = [NSString stringWithFormat:@"??????:%@???",dic[@"sellCount"]];
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
#pragma mark ??????????????? ???????????? ???????????????
-(void)headerRereshing{
    self.page = 1;
    [self getData];
}

#pragma mark ??????????????? ???????????? ???????????????
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
