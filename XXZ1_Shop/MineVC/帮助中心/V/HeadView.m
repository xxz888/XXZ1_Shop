//
//  HeadView.m
//  KCB
//
//  Created by haozp on 16/1/6.
//  Copyright © 2016年 haozp. All rights reserved.
//
#define SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)

#import "HeadView.h"
#import "ProblemTitleModel.h"

@interface HeadView()
{
    BOOL _isMore;
    UILabel *_numLabel;
}
@end

@implementation HeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView;
{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView;
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
        headView.contentView.backgroundColor = [UIColor whiteColor];

    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.titleLabel.numberOfLines = 0;

        [bgButton setImage:[UIImage imageNamed:@"second_icon_open"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:0];
        bgButton.titleLabel.font = [UIFont systemFontOfSize:15];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.titleLabel.lineBreakMode = 0;

//        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
     
            bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, SCREEN_WIDTH-60, 0, 0);
            bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, -SCREEN_WIDTH+53, 0, 60);

       
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        _bgButton = bgButton;
        
    }
    return self;
}

- (void)headBtnClick
{
//    _titleGroup.opened = !_titleGroup.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView:)]) {
        [_delegate clickHeadView:_titleGroup];
    }
}
- (void)setTitleGroup:(ProblemTitleModel *)titleGroup{
    _titleGroup = titleGroup;
    
    [_bgButton setTitle:titleGroup.title forState:UIControlStateNormal];
}


- (void)didMoveToSuperview
{
    _bgButton.imageView.transform = _titleGroup.isOpened ? CGAffineTransformMakeRotation(M_PI_2*2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, self.frame.size.height-0.5, self.frame.size.width-20, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"#E8E9EC"];
    [self addSubview:line];
}

@end
