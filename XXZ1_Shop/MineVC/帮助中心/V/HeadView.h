//
//  HeadView.h
//  KCB
//
//  Created by haozp on 16/1/6.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProblemTitleModel;

@protocol HeadViewDelegate <NSObject>

@optional
- (void)clickHeadView:(ProblemTitleModel *)titleGroup;

@end

@interface HeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) ProblemTitleModel *titleGroup;
@property (nonatomic, strong) UIButton * bgButton;



@property (nonatomic, weak) id<HeadViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
