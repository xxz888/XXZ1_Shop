//
//  SecondViewController.m
//  XXZ1_Shop
//
//  Created by BH on 2022/11/29.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign)NSInteger selectIndex;
@property (nonatomic ,strong)NSMutableArray * arr1;
@property (nonatomic ,strong)NSMutableArray * arr2;
@property (nonatomic ,strong)NSMutableArray * arr3;

@end

@implementation SecondViewController

- (void)loadNewShops
{
    
    
    //一级商品分类，值为空：全部商品，1：女装，2：母婴，3：美妆，4：居家日用，5：鞋品，6：美食，7：文娱车品，8：数码家电，9：男装，10：内衣，11：箱包，12：配饰，13：户外运动，14：家装家纺
    NSString * url = [NSString stringWithFormat:@"https://api.zhetaoke.com:10001/api/api_all.ashx?appkey=f6cfb493dd7843b49b4f9bb5d839c061&sid=160008&page=%ld&page_size=10&cid=%@",self.page,@"13"];
    [XXZHttpUtil getWithURLString:url parameters:@{} success:^(id res) {
        
      
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:res[@"content"]];
        
        
        self.arr1 = [[NSMutableArray alloc]initWithArray:@[self.dataArray[0]]];
        
        
        self.arr2 = [[NSMutableArray alloc]initWithArray:@[self.dataArray[1],self.dataArray[2],self.dataArray[3]]];
        
        
        self.arr3 = [[NSMutableArray alloc]initWithArray:@[self.dataArray[4],self.dataArray[5],self.dataArray[6],
                                                           self.dataArray[7],self.dataArray[8],self.dataArray[9]]];

        
        
        [self.xxzTableView reloadData];
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    self.xxzTableView.backgroundColor = KF8F8F8Color;
    self.selectIndex = 0;
    [self.xxzTableView registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondTableViewCell"];
    self.xxzTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    NSDictionary * dic = @{@"shop_title":@"小小美商城",
//                           @"title":@"2022棉衣女中长款过膝羽绒棉服",
//                           @"quanhou_jiage":@"89.90",
//                           @"pict_url":@"https://img.alicdn.com/bao/uploaded/i2/2126878191/O1CN012nfAXV2ANWxxRP5wG_!!2126878191.jpg",
//                           @"category_name":@"棉衣/棉服",
//    };
//    [self.dataArray addObject:dic];
    
    [self loadNewShops];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.selectIndex == 0 ?  [self.dataArray count] :
    self.selectIndex == 1 ?  [self.arr1 count] :
    self.selectIndex == 2 ?  [self.arr2 count] :
    self.selectIndex == 3 ?  [self.arr3 count] : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectIndex == 0) {
        if (indexPath.row == 0) {
            return  185;
        }else  if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            return  128;
        }else{
            return  128;
        }
    }
    if (self.selectIndex == 1) {
        return  185;
    }
       
    if (self.selectIndex == 2) {
        return  128;
    }
    if (self.selectIndex == 3) {
        return  128;
    }
    
    return 0;

    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SecondTableViewCell" forIndexPath:indexPath];
    NSArray * arr =   self.selectIndex == 0 ? self.dataArray :
    self.selectIndex == 1 ? self.arr1 :
    self.selectIndex == 2 ?  self.arr2 :
    self.selectIndex == 3 ?  self.arr3 : 0;
    NSDictionary * dic = arr[indexPath.row];
    
    
    cell.sectionLbl.text = dic[@"shop_title"];
    cell.cellTitle.text = dic[@"title"];
    cell.cellPrice.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"quanhou_jiage"] doubleValue]];
    [cell.cellImv sd_setImageWithURL:dic[@"pict_url"]];
    cell.cellBrand.text = dic[@"category_name"];

    
    
    if (self.selectIndex == 0) {
        if (indexPath.row == 0) {
            cell.cellStatus.text = @"待支付";
            cell.cellStatus.textColor = [UIColor orangeColor];
        }else  if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            cell.cellStatus.text = @"已完成";
            cell.cellStatus.textColor = [UIColor colorWithHexString:@"#1989fa"];
        }else{
            cell.cellStatus.text = @"已取消";
            cell.cellStatus.textColor = [UIColor grayColor];
        }
    }
    if (self.selectIndex == 1) {
        if (indexPath.row == 0) {
            cell.cellStatus.text = @"待支付";
            cell.cellStatus.textColor = [UIColor orangeColor];
        }
    }
    if (self.selectIndex == 2) {
            cell.cellStatus.text = @"已完成";
            cell.cellStatus.textColor = [UIColor colorWithHexString:@"#1989fa"];
    }
    if (self.selectIndex == 3) {

        cell.cellStatus.text = @"已取消";
        cell.cellStatus.textColor = [UIColor grayColor];
     
    }
    if ([dic[@"quanhou_jiage"] doubleValue] < 100) {
        cell.cellBaoyouTag.hidden = NO;
       
    }else{
        cell.cellBaoyouTag.hidden = YES;

    }

    [cell.qvxiaodingdan rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"此订单不可删除，请联系客服";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }];
    
    [cell.jixufukuan rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
            
    }];
    return cell;
    
}
- (IBAction)segmentAction:(UISegmentedControl *)seg {
        NSInteger i = seg.selectedSegmentIndex;
    self.selectIndex = i;
    [self.xxzTableView reloadData];
}
@end
