//
//  JXJCustomeScrollLabel.h
//  ScholarshipApp
//
//  Created by 李欢 on 2019/10/26.
//  Copyright © 2019 Kevin007. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    JXJScrollNumAnimationTypeNormal = 0,
    JXJScrollNumAnimationTypeFast,
    JXJScrollNumAnimationTypeRandom
} JXJScrollNumAnimationType;

@interface JXJCustomeScrollLabel : UIView

@property (nonatomic, assign)JXJScrollNumAnimationType scrollType;

@property (nonatomic, strong) UIFont *font;//字体
@property (nonatomic, strong) UIColor *textColor;//字体颜色
//@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval durationSpeed;//滚动速度
@property (nonatomic, assign) NSTimeInterval duration;//滚动持续时间
@property(nonatomic,strong)NSArray *array_AnimationValue;//滚动的内容  默认0-9
@property(nonatomic,copy)NSString *string_Value;//当前内容 当前内容必须是滚动内容的一部分。
@property (nonatomic, assign) BOOL isUpDown;//Yes 从上边滚动到下边   NO 从下边滚动到上边。
@property (nonatomic, assign) BOOL isAnimation;//是否动画

- (void)updateNumber:(NSInteger)number nextNumber:(NSInteger)nextNumber;

@end

NS_ASSUME_NONNULL_END
