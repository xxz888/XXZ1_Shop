//
//  SuspensionButton.h
//  jintStudentProject
//
//  Created by jin on 2021/3/17.
//

#import <UIKit/UIKit.h>
typedef void (^tochSeleBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface SuspensionButton : UIButton
@property (nonatomic,copy)tochSeleBlock block;
@property(nonatomic, assign)BOOL MoveEnable;
@property(nonatomic, assign)BOOL MoveEnabled;
@property(nonatomic, assign)CGPoint beginpoint;
@end

NS_ASSUME_NONNULL_END
