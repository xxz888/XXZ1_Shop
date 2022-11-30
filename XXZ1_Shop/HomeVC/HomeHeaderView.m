//
//  HomeHeaderView.m
//  XXZ1_Shop
//
//  Created by BH on 2022/11/29.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil] lastObject];

    }
    return self;
}
- (IBAction)segmentAction:(UISegmentedControl *)seg {
    
    NSInteger i = seg.selectedSegmentIndex;
    NSLog(@"切换了状态 %lu",i);
    if (self.clickSegmentBlock) {
        self.clickSegmentBlock(i);
    }
}
@end
