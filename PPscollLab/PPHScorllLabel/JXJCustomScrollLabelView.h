//
//  JXJCustomScrollLabelView.h
//  ScholarshipApp
//
//  Created by 李欢 on 2019/10/26.
//  Copyright © 2019 Kevin007. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXJCustomeScrollLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXJCustomScrollLabelView : UIView

@property(nonatomic,assign)CGFloat numberValue;//数值
//@property(nonatomic,copy)NSString *string_Decimalseparator;//小数点分隔符
@property(nonatomic,copy)NSString *string_Prefix;//前缀
@property (nonatomic, strong) UIFont *font;//字体
@property (nonatomic, strong) UIColor *textColor;//字体颜色
@property(nonatomic,strong)NSArray *array_AnimationValue;//滚动的内容  默认0-9
@property (nonatomic, assign) NSInteger decimalCount;//小数点后保留几位 默认2
@property (nonatomic, assign) NSTimeInterval durationSpeed;//滚动速度 默认 0.1
@property (nonatomic, assign) NSTimeInterval duration;//滚动持续时间  滚动时间 必须大于滚动速度
@property (nonatomic, assign) BOOL isUpDown;//Yes 从上边滚动到下边   NO 从下边滚动到上边。
//@property (nonatomic, assign) BOOL Decimalseparator_animation;//小数点是否跟随动画
@property (nonatomic, assign)JXJScrollNumAnimationType scrollType;

@end

NS_ASSUME_NONNULL_END
