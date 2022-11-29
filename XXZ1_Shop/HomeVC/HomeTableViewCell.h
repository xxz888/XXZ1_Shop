//
//  HomeTableViewCell.h
//  XXZ1_Shop
//
//  Created by BH on 2022/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIImageView *cellImv;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice;
@property (weak, nonatomic) IBOutlet UILabel *cellCount;
@property (weak, nonatomic) IBOutlet UILabel *tip1Lbl;
@property (weak, nonatomic) IBOutlet UILabel *tip2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *tip3Lbl;

@end

NS_ASSUME_NONNULL_END
