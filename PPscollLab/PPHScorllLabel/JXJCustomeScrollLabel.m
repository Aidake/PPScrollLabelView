//
//  JXJCustomeScrollLabel.m
//  ScholarshipApp
//
//  Created by 李欢 on 2019/10/26.
//  Copyright © 2019 Kevin007. All rights reserved.
//

#import "JXJCustomeScrollLabel.h"
#define kWeakSelf(type)  __weak typeof(type) weak##type = type


@interface JXJCustomeScrollLabel()
{
    UIImageView *backgroundImageView;
    UILabel *currentLabel;
    CAScrollLayer *layer;
    NSTimeInterval animationTime;
}
@property (nonatomic, strong) NSMutableArray *scrollLabels;

@end
@implementation JXJCustomeScrollLabel

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _isUpDown = YES;
        _font = [UIFont systemFontOfSize:14];
        self.textColor = [UIColor blackColor];
        _durationSpeed = 0.1;
        _duration = 2;
        _isUpDown = NO;
        _scrollType = JXJScrollNumAnimationTypeNormal;
        _isAnimation = YES;
//        _Decimalseparator_animation = NO;
        _array_AnimationValue = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        [self buildUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    backgroundImageView.frame = self.bounds;
    layer.frame = self.bounds;
    currentLabel.frame = layer.bounds;
    currentLabel.backgroundColor = [UIColor clearColor];
    [self setFont:[UIFont fontWithName:@"DIN Alternate" size:self.frame.size.height]];
}

- (void)buildUI {
    self.backgroundColor = [UIColor darkGrayColor];
    _textColor = [UIColor whiteColor];
    // 配置新的数据和UI
    layer = [CAScrollLayer layer];
    [self.layer addSublayer:layer];
    
    currentLabel = [self createLabel:_string_Value];
    [layer addSublayer:currentLabel.layer];
    _scrollLabels = [NSMutableArray array];
}
-(void)setIsUpDown:(BOOL)isUpDown
{
    _isUpDown = isUpDown;
}
- (void)setString_Value:(NSString *)string_Value
{
    [self.layer removeAllAnimations];
    [self.scrollLabels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lab = obj;
        [lab removeFromSuperview];
        lab = nil;
    }];
    if (_string_Value && [_string_Value isEqualToString:string_Value]) {
        if (self.scrollType==JXJScrollNumAnimationTypeRandom) {
            currentLabel.text = _string_Value;
            [self.layer addSublayer:currentLabel.layer];
            return;
        }
    }else{    }
    _string_Value = string_Value;
    NSInteger currentIndex = 0  ;
    //找到当前字符串在数字里面的索引
    if ([self.array_AnimationValue containsObject:_string_Value]) {
        currentIndex = [self.array_AnimationValue indexOfObject:_string_Value];
        [currentLabel.layer removeFromSuperlayer];
    }else{
        currentLabel.text = _string_Value;
        [self.layer addSublayer:currentLabel.layer];
        return;
    }
    NSInteger number_lab = _duration/ _durationSpeed;
    kWeakSelf(self);
    __block CGFloat height = 0;
    for (int i = 0; i<number_lab; i++) {//从当前索引currentIndex 开始去number_lab 个 array_AnimationValue 对象设置为内容。
        NSInteger index = (i+currentIndex)%self.array_AnimationValue.count;
        NSString *content = [self.array_AnimationValue objectAtIndex:index];
        UILabel *label = [self createLabel:content];
        label.text = content;
        label.frame = CGRectMake(0, height, self.frame.size.width, self.frame.size.height);
        [self->layer addSublayer:label.layer];
        [weakself.scrollLabels addObject:label];
        // 累加高度
        height = CGRectGetMaxY(label.frame);
    }
    [self createAnimations];

}

#pragma mark Setter
- (void)setFont:(UIFont *)font {
    _font = font;
    for (UILabel *lab  in self.scrollLabels) {
        lab.font = font;
    }
    currentLabel.font = font;
}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    currentLabel.textColor = textColor;
}
- (void)setDuration:(NSTimeInterval)duration{
    _duration = duration;
}

- (void)setScrollType:(JXJScrollNumAnimationType)scrollType{
    _scrollType = scrollType;
}
-(void)setArray_AnimationValue:(NSArray *)array_AnimationValue
{
    _array_AnimationValue = array_AnimationValue;
}
- (void)configScrollFromNumber:(NSInteger)fromNumber toNumber:(NSInteger)toNumber{
    NSMutableArray *scrollNumbers = [NSMutableArray array];
}

- (UILabel *)createLabel:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = _textColor;
    label.font = self.font;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    return label;
}

- (void)createAnimations
{
    CGFloat maxY = [[layer.sublayers lastObject] frame].origin.y;
    //    CGFloat maxHeight = [[layer.sublayers lastObject] frame].size.height;
    // keyPath 是 sublayerTransform ，因为动画应用于 layer 的 subLayer。
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
    animation.duration = _durationSpeed;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.fromValue = [NSNumber numberWithFloat:-maxY];
//    animation.toValue = @0;
    animation.repeatCount = _duration/_durationSpeed;
    animation.speed = 1;
    if (self.isUpDown) {
        animation.fromValue = [NSNumber numberWithFloat:-maxY];
        animation.toValue = @0;
    }else{
        animation.fromValue = @(0);
        animation.toValue = [NSNumber numberWithFloat:-maxY];
    }
    // 添加动画
    [layer addAnimation:animation forKey:@"LFNumberScrollAnimatedView"];
    //    layer.backgroundColor = [UIColor blueColor].CGColor;
}


- (void)updateNumber:(NSInteger)number nextNumber:(NSInteger)nextNumber{
    // 先删除旧数据
    [layer removeAnimationForKey:@"LFNumberScrollAnimatedView"];
    [layer removeFromSuperlayer];
    [_scrollLabels removeAllObjects];
    
    // 配置新的数据和UI
    layer = [CAScrollLayer layer];
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    
    [self configScrollFromNumber:number toNumber:nextNumber];
    [self createAnimations];
    
//    _currentNum = nextNumber;
}

/**
 *  改变图片的大小
 *
 *  @param image     需要改变的图片
 *  @param size 新图片的大小
 *
 *  @return 返回修改后的新图片
 */
- (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
