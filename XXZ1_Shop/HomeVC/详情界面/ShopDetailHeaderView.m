//
//  ShopDetailHeaderView.m
//  LemonFish
//
//  Created by BH on 2022/8/23.
//

#import "ShopDetailHeaderView.h"
@implementation ShopDetailHeaderView



- (void)drawRect:(CGRect)rect {
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ShopDetailHeaderView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
