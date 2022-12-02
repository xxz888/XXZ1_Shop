//
//  HomeAffirmViewController.h
//  XXZ1_Shop
//
//  Created by BH on 2022/12/2.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface HomeAffirmViewController : BaseViewController
@property (nonatomic ,strong)NSDictionary * startDic;

@property (weak, nonatomic) IBOutlet UILabel *adressName;
@property (weak, nonatomic) IBOutlet UILabel *adressPhone;
@property (weak, nonatomic) IBOutlet UILabel *adressLbl;


@property (weak, nonatomic) IBOutlet UIImageView *cellImv;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellYouhui;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice;
@property (weak, nonatomic) IBOutlet UILabel *cellTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *cellYouhuiquan;
@property (weak, nonatomic) IBOutlet UITextView *cellBeizhu;
@property (weak, nonatomic) IBOutlet UILabel *cellTotalPriceBottom;

@property (weak, nonatomic) IBOutlet UILabel *lijizhifuLbl;

@end

NS_ASSUME_NONNULL_END
