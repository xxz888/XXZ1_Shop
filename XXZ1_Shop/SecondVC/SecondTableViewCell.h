//
//  SecondTableViewCell.h
//  XXZ1_Shop
//
//  Created by BH on 2022/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellBaoyouTag;
@property (weak, nonatomic) IBOutlet UILabel *sectionLbl;
@property (weak, nonatomic) IBOutlet UILabel *cellStatus;
@property (weak, nonatomic) IBOutlet UIImageView *cellImv;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice;
@property (weak, nonatomic) IBOutlet UILabel *cellBrand;
@property (weak, nonatomic) IBOutlet UILabel *jixufukuan;
@property (weak, nonatomic) IBOutlet UILabel *qvxiaodingdan;

@end

NS_ASSUME_NONNULL_END
