//
//  HomeAddAddressViewController.m
//  XXZ1_Shop
//
//  Created by BH on 2022/12/2.
//

#import "HomeAddAddressViewController.h"
#import "AddressModel.h"
#import "AddressAreaModel.h"
#import "AreaView.h"

@interface HomeAddAddressViewController ()<AreaSelectDelegate>
{
    AreaView *areaView;
    NSInteger areaIndex;
    NSMutableArray *area_dataArray1;
    NSMutableArray *area_dataArray2;
    NSMutableArray *area_dataArray3;
    UILabel *areaLabel;
}
@end
CG_INLINE CGRect CGRectMakes(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    float secretNum = [[UIScreen mainScreen] bounds].size.width / 375;
    rect.origin.x = x*secretNum; rect.origin.y = y*secretNum;
    rect.size.width = width*secretNum; rect.size.height = height*secretNum;
    
    return rect;
}
@implementation HomeAddAddressViewController
- (IBAction)selectAdress:(id)sender {
    
    [self requestAllAreaName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"添加地址";
    areaIndex = 0;
    area_dataArray1 = [[NSMutableArray alloc]init];
    area_dataArray2 = [[NSMutableArray alloc]init];
    area_dataArray3 = [[NSMutableArray alloc]init];
    

    
}
#pragma mark - AreaSelectDelegate
- (void)selectIndex:(NSInteger)index selectID:(NSString *)areaID
{
    areaIndex = index;
    switch (areaIndex) {
        case 1:
            [area_dataArray2 removeAllObjects];
            break;
        case 2:
            [area_dataArray3 removeAllObjects];
            break;
        default:
            break;
    }
    [self requestAllAreaName];
}
- (void)getSelectAddressInfor:(NSString *)addressInfor
{
    self.lianxidizhiTf.text = addressInfor;
}



#pragma mark - requestAllAreaName
- (void)requestAllAreaName
{
    if (!areaView) {
        areaView = [[AreaView alloc]initWithFrame:CGRectMakes(0, 0, 375, 667)];
        areaView.hidden = YES;
        areaView.address_delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:areaView];
    }
    NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%ld",areaIndex + 1] ofType:@"plist"];
    NSMutableDictionary *plistDic=[NSMutableDictionary dictionaryWithContentsOfFile:path];

    for (NSDictionary *sh_dic in plistDic[@"data"][@"sh_items"]) {
        AddressAreaModel *addressAreaModel = [[AddressAreaModel alloc]init];
        [addressAreaModel setValuesForKeysWithDictionary:sh_dic];
        switch (areaIndex) {
            case 0:
                [area_dataArray1 addObject:addressAreaModel];
                break;
            case 1:
                [area_dataArray2 addObject:addressAreaModel];
                break;
            case 2:
                [area_dataArray3 addObject:addressAreaModel];
                break;
            default:
                break;
        }
    }
    switch (areaIndex) {
        case 0:
        {
            [areaView showAreaView];
            [areaView setProvinceArray:area_dataArray1];
        }
            break;
        case 1:
            [areaView setCityArray:area_dataArray2];
            break;
        case 2:
            [areaView setRegionsArray:area_dataArray3];
            break;
        default:
            break;
    }

}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if (!areaView) {
//        [self requestAllAreaName];
//    }
//    else
//        [areaView showAreaView];
//
//
//}
//

- (IBAction)lijizhifuAction:(id)sender {
    if (self.clickSaveBlock) {
        self.clickSaveBlock(@{@"phone":self.lianxidianhuaTf.text,
                              @"name":self.shouhuorenTf.text,
                              @"address":[NSString stringWithFormat:@"%@%@",self.lianxidizhiTf.text,self.xiangxidizhiTv.text]});
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
@end
