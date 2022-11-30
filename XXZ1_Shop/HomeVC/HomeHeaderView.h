//
//  HomeHeaderView.h
//  XXZ1_Shop
//
//  Created by BH on 2022/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickSegmentBlock)(NSInteger index);
@interface HomeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *lunboView;
- (instancetype)initWithFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;

- (IBAction)segmentAction:(id)sender;

@property (nonatomic ,copy)ClickSegmentBlock clickSegmentBlock;
@property (weak, nonatomic) IBOutlet UIView *stackView1;
@property (weak, nonatomic) IBOutlet UIView *stackView2;
@property (weak, nonatomic) IBOutlet UIView *stackView3;
@property (weak, nonatomic) IBOutlet UIView *stackView4;


@end

NS_ASSUME_NONNULL_END
