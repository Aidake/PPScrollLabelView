//
//  JXJCustomScrollLabelView.m
//  ScholarshipApp
//
//  Created by 李欢 on 2019/10/26.
//  Copyright © 2019 Kevin007. All rights reserved.
//

#import "JXJCustomScrollLabelView.h"
@interface JXJCustomScrollLabelView() {
    NSInteger _places;
    CGSize _labelSize;
    CGFloat _margin;
}
@property (nonatomic, strong)NSMutableArray *labelArray;

@end
@implementation JXJCustomScrollLabelView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberValue = 0.0;
//        _string_Decimalseparator = @".";
        _string_Prefix = @"";
        _font = [UIFont systemFontOfSize:14];
        _textColor = [UIColor blackColor];
        _durationSpeed = 0.1;
        _duration = 1;
        _isUpDown = NO;
        _scrollType = JXJScrollNumAnimationTypeNormal;
//        _Decimalseparator_animation = NO;
        _labelArray = [NSMutableArray array];
        _decimalCount =2;
        [self buildUI];
    }
    return self;
}
- (void)buildUI {
    self.backgroundColor = [UIColor clearColor];
    _labelArray = [NSMutableArray array];
}

-(void)setNumberValue:(CGFloat)numberValue
{
    [_labelArray removeAllObjects];
    _numberValue = numberValue;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    NSString *numberString =[self formatShortPayment:[NSNumber numberWithFloat:numberValue]];
    NSMutableString *Mstring_content = [NSMutableString string];
    [Mstring_content appendFormat:@"%@", self.string_Prefix];
    [Mstring_content appendFormat:@"%@", numberString];
    NSLog(@"numberString == %@",numberString);
    NSDictionary *attributes = @{NSFontAttributeName:self.font};
    CGRect boundingRect = [@"2" boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    for (int i = 0; i < Mstring_content.length; i++) {
        JXJCustomeScrollLabel *foldLabel = [self dequeueLabelObjectWithIndex:i];
        if (!foldLabel) {
            foldLabel = [[JXJCustomeScrollLabel alloc]init];
            foldLabel.textColor = self.textColor;
            foldLabel.font = self.font;
            foldLabel.durationSpeed = self.durationSpeed;
            foldLabel.duration = self.duration;
            foldLabel.scrollType = self.scrollType;
            foldLabel.isUpDown = self.isUpDown;
            if (self.array_AnimationValue) {
                foldLabel.array_AnimationValue = self.array_AnimationValue;
            }
        }
        foldLabel.frame = CGRectMake(i*boundingRect.size.width, self.frame.size.height/2-boundingRect.size.height/2, boundingRect.size.width, boundingRect.size.height);
        foldLabel.backgroundColor = [UIColor clearColor];
        char c = [Mstring_content characterAtIndex:i];
        NSString *str = [NSString stringWithFormat:@"%c",c];
        [self addSubview:foldLabel];
        foldLabel.string_Value = str;
        if (![self.labelArray containsObject:foldLabel]) {
            [_labelArray addObject:foldLabel];
        }
    }
    CGRect sframe = self.frame;
    sframe.size.width = _labelArray.count *boundingRect.size.width;
    self.frame = sframe;
}
-(void)setDecimalCount:(NSInteger)decimalCount
{
    _decimalCount = decimalCount;
}
-(void)setDuration:(NSTimeInterval)duration
{
    _duration = duration;
    for (int i = 0; i < _labelArray.count; i++) {
        JXJCustomeScrollLabel *label = _labelArray[i];
        label.duration = _duration;;
    }
}
-(void)setDurationSpeed:(NSTimeInterval)durationSpeed
{
    _durationSpeed = durationSpeed;
    for (int i = 0; i < _labelArray.count; i++) {
        JXJCustomeScrollLabel *label = _labelArray[i];
        label.durationSpeed = _durationSpeed;;
    }
}
-(JXJCustomeScrollLabel *)dequeueLabelObjectWithIndex:(NSInteger )index
{
    if (self.labelArray.count ==0) {
        return nil;
    }
    if (index>=self.labelArray.count) {
        return nil;
    }else{
        return self.labelArray[index];
    }
}
-(void)setArray_AnimationValue:(NSArray *)array_AnimationValue
{
    _array_AnimationValue = array_AnimationValue;
    for (int i = 0; i < _labelArray.count; i++) {
        JXJCustomeScrollLabel *label = _labelArray[i];
        label.array_AnimationValue = _array_AnimationValue;
    }
}

-(void)setScrollType:(JXJScrollNumAnimationType)scrollType
{
    _scrollType = scrollType;
    for (int i = 0; i < _labelArray.count; i++) {
        JXJCustomeScrollLabel *label = _labelArray[i];
        label.scrollType = _scrollType;
    }
}
- (void)setFont:(UIFont *)font{
    _font = font;
    for (int i = 0; i < _labelArray.count; i++) {
        JXJCustomeScrollLabel *label = _labelArray[i];
        label.font = font;
    }
}
-(void)setIsUpDown:(BOOL)isUpDown
{
    _isUpDown = isUpDown;
    for (int i = 0; i < _labelArray.count; i++) {
        JXJCustomeScrollLabel *label = _labelArray[i];
        label.isUpDown = _isUpDown;
    }
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    for (int i = 0; i < _labelArray.count; i++) {
        JXJCustomeScrollLabel *label = _labelArray[i];
        label.textColor = textColor;
    }
}
-(void)setString_Prefix:(NSString *)string_Prefix
{
    _string_Prefix = string_Prefix;
}
- (NSString *)formatShortPayment: (NSNumber *)payment {
    
    if (![payment isEqual: [NSNull null]]) {
        return [self notRounding:[payment floatValue] afterPoint:_decimalCount];
//        return [self notRounding:[payment floatValue] afterPoint:0];
    }
    return @"";
}

-(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    roundedOunces = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",price]];
    NSString *content = [NSString stringWithFormat:@"%@",roundedOunces];
    NSMutableString *mstring = [NSMutableString string];
    [mstring appendString:content];
    [mstring appendString:@"0000000000000000000000000000000000000000000000000000"];
    NSRange range = [content rangeOfString:@"."];
    if (range.length >0) {
        NSString *tempstring = [mstring substringWithRange:NSMakeRange(0, range.location+1+position)];
        return tempstring;
    }else{
        return content;
    }
}
@end
