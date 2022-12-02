//
//  SuspensionButton.m
//  jintStudentProject
//
//  Created by jin on 2021/3/17.
//

#import "SuspensionButton.h"

@implementation SuspensionButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0,0, 56 ,56);
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:tap];
//        UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handelPan:)];
//          [self addGestureRecognizer:pan];
        _MoveEnable = YES;
    }
    return self;
}
-(void)tapGesture{
    if (self.block) {
        self.block();
    }
}



//开始触摸的方法
//触摸-清扫
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _MoveEnabled = NO;
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
    if (!_MoveEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    _beginpoint = [touch locationInView:self];
}
-(void)handelPan:(UIPanGestureRecognizer*)gestureRecognizer{
    CGPoint curPoint = [gestureRecognizer locationInView:self.superview];
    [self setCenter:curPoint];

}

//触摸移动的方法
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    _MoveEnabled = YES;//单击事件可用
    [super touchesMoved:touches withEvent:event];
    [self.nextResponder touchesMoved:touches withEvent:event];
    if (!_MoveEnable) {
        return;
    }
   
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    //偏移量
    float offsetX = currentPosition.x - _beginpoint.x;
    float offsetY = currentPosition.y - _beginpoint.y;
    //移动后的中心坐标
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
    //x轴左右极限坐标
    if (self.center.x > (self.superview.frame.size.width - self.frame.size.width / 2)) {
        CGFloat x = self.superview.frame.size.width - self.frame.size.width / 2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    } else if (self.center.x < self.frame.size.width / 2) {
        CGFloat x = self.frame.size.width / 2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    }
    NSLog(@"%f----%f",self.superview.frame.size.height,self.center.y);
    //y轴上下极限坐标
    if (self.center.y >= (KScreenHeight - kStatusBarHeight -kTabBarHeight - 56)) {
        CGFloat x = self.center.x;
        CGFloat y = KScreenHeight - kStatusBarHeight -kTabBarHeight - 56;
        self.center = CGPointMake(x, y);
    } else if (self.center.y <= 34) {
        CGFloat x = self.center.x;
        CGFloat y = 34;
        self.center = CGPointMake(x, y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [super.nextResponder touchesEnded:touches withEvent:event];
    if (!_MoveEnable) {
        return;
    }
   
    if (self.center.x >= self.superview.frame.size.width / 2) {//向右侧移动
        //偏移动画
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        self.frame = CGRectMake(self.superview.frame.size.width - 56, self.center.y-34, 56, 56);
        //提交UIView动画
        [UIView commitAnimations];
    } else {//向左侧移动
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        self.frame=CGRectMake(0.f,self.center.y-34, 56, 56);
        //提交UIView动画
        [UIView commitAnimations];
    }
    
    //不加此句话，UIButton将一直处于按下状态
    [super touchesEnded: touches withEvent: event];
    
}

@end
