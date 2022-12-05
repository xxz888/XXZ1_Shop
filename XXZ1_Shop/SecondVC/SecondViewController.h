//
//  SecondViewController.h
//  XXZ1_Shop
//
//  Created by BH on 2022/11/29.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *xxzTableView;
- (IBAction)segmentAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
