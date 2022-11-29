//
//  ANPagecontrol.m
//  Moneyarrival
//
//  Created by jin on 2018/11/25.
//  Copyright © 2018 Qianli Technology. All rights reserved.
//

#import "ANPagecontrol.h"

@implementation ANPagecontrol

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}
-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 4;
        size.width =16;
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,size.width,size.height)];
//        if (subview != 0) {
//            [subview setCenter:CGPointMake(subview.center.x - QL_XX_6(20)*subviewIndex,subview.center.y)];
//        }
        
        if (subviewIndex == currentPage)
            
            //        subview.image =[UIImage imageNamed:@"60.png"];
        {   subview.layer.cornerRadius = 2;
            subview.layer.masksToBounds = YES;
        }
        else
        {    //subview.image =[UIImage imageNamed:@"60.png"];
            subview.layer.cornerRadius = 2;
            subview.layer.masksToBounds = YES;
            
        }
    }
}

@end
