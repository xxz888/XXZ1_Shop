//
//  HomeAddAddressViewController.h
//  XXZ1_Shop
//
//  Created by BH on 2022/12/2.
//

#import "BaseViewController.h"

typedef void(^ClickSaveBlock)(NSDictionary * dic);


NS_ASSUME_NONNULL_BEGIN

@interface HomeAddAddressViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *shouhuorenTf;
@property (weak, nonatomic) IBOutlet UITextField *lianxidianhuaTf;
@property (weak, nonatomic) IBOutlet UITextField *lianxidizhiTf;
@property (weak, nonatomic) IBOutlet UITextView *xiangxidizhiTv;
- (IBAction)lijizhifuAction:(id)sender;
@property (nonatomic ,copy)ClickSaveBlock clickSaveBlock;

@end

NS_ASSUME_NONNULL_END
