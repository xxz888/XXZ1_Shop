//
//  ANProductRollVIew.h
//  Moneyarrival
//
//  Created by jin on 2018/10/22.
//  Copyright © 2018 Qianli Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^clickCallBack) (NSInteger index);
@interface ANBannerVIew : UIView


/** 点击图片回调的block */
@property (nonatomic, copy) clickCallBack clickBlcok;


/**
 *  @author li bo, 16/06/24
 *
 *  创建轮播器的构造方法
 *
 *  @param frame         轮播器的frame
 *  @param playTime      轮播器图片的切换时间
 *  @param imagesArray   轮播器图片的数据源
 *  @param clickCallBack 点击轮播器imageview回调的block
 *
 *  @return 返回一个轮播器组件
 */
- (instancetype)initViewWithFrame:(CGRect)frame
                     autoPlayTime:(NSTimeInterval)playTime
                      imagesArray:(NSArray *)imagesArray
                    clickCallBack:(clickCallBack)clickCallBack;
@property (nonatomic,strong)NSArray *imagesArray;
@end

NS_ASSUME_NONNULL_END
