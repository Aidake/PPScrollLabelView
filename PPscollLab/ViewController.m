//
//  ViewController.m
//  PPscollLab
//
//  Created by 李欢 on 2019/10/28.
//  Copyright © 2019 test. All rights reserved.
//

#import "ViewController.h"
#import "PPHScorllLabel/JXJCustomScrollLabelView.h"

@interface ViewController ()
@property(nonatomic,strong)JXJCustomScrollLabelView *aview;
@property(nonatomic,strong)JXJCustomScrollLabelView *aview2;
@property(nonatomic,strong)JXJCustomScrollLabelView *aview3;

@property(nonatomic,strong)UISlider *slider_dymicCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _aview= [[JXJCustomScrollLabelView alloc]init];
    _aview.frame = CGRectMake(50, 200, self.view.frame.size.width, 50);
    _aview.scrollType = JXJScrollNumAnimationTypeNormal;
    _aview.font = [UIFont fontWithName:@"Helvetica" size:34];
    _aview.textColor = [UIColor cyanColor];
//    _aview.array_AnimationValue = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];//默认是这样，可以不设置
    //        _lab_custome.scrollType = JXJScrollNumAnimationTypeRandom;
    //        _lab_custome.numberValue = 0.00;
    _aview.durationSpeed = 0.2;
    _aview.duration = 1;
    _aview.isUpDown = YES;
    _aview.layer.shadowOffset =  CGSizeMake(1, 2);
    _aview.layer.shadowColor =  [UIColor blackColor].CGColor;
    _aview.layer.shadowOpacity = 1;
    _aview.layer.shadowRadius = 0;
    _aview.alpha = 1;
    _aview.decimalCount = 10;
    [self.view addSubview:_aview];
    _aview.numberValue = 0.25;
    
    _aview2= [[JXJCustomScrollLabelView alloc]init];
    _aview2.frame = CGRectMake(50, 300, self.view.frame.size.width, 50);
    _aview2.scrollType = JXJScrollNumAnimationTypeNormal;
    _aview2.font = [UIFont fontWithName:@"Helvetica" size:34];
    _aview2.textColor = [UIColor cyanColor];
    _aview2.durationSpeed = 0.2;
    _aview2.duration = 1;
    _aview2.isUpDown = NO;
    _aview2.layer.shadowOffset =  CGSizeMake(1, 2);
    _aview2.layer.shadowColor =  [UIColor blackColor].CGColor;
    _aview2.layer.shadowOpacity = 1;
    _aview2.layer.shadowRadius = 0;
    _aview2.alpha = 1;
    _aview2.decimalCount = 2;
    [self.view addSubview:_aview2];
    _aview2.numberValue = 0.25;
    
    _aview3= [[JXJCustomScrollLabelView alloc]init];
    _aview3.frame = CGRectMake(50, 400, self.view.frame.size.width, 50);
    _aview3.scrollType = JXJScrollNumAnimationTypeNormal;
    _aview3.font = [UIFont fontWithName:@"Helvetica" size:34];
    _aview3.textColor = [UIColor cyanColor];
    _aview3.durationSpeed = 0.1;
    _aview3.duration = 2;
//    _aview3.isUpDown = YES;
    _aview3.layer.shadowOffset =  CGSizeMake(1, 2);
    _aview3.layer.shadowColor =  [UIColor blackColor].CGColor;
    _aview3.layer.shadowOpacity = 1;
    _aview3.layer.shadowRadius = 0;
    _aview3.alpha = 1;
//    _aview3.decimalCount = 0;
    [self.view addSubview:_aview3];
    _aview3.numberValue = 0.25;
    
    _slider_dymicCount = [[UISlider alloc]initWithFrame:CGRectMake(100, 100, 100, 44)];
    [_slider_dymicCount addTarget:self action:@selector(setlabdurationSpeed:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider_dymicCount];
}

-(void)setlabdurationSpeed:(UISlider *)slider
{
//    slider.
    if (slider.value*2<=0) {
        _aview.durationSpeed = 0.1;
    }else{
        _aview.durationSpeed = slider.value*2;
    }
    _aview.duration = _aview.durationSpeed*2;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _aview.string_Prefix = @"¥";
    _aview.numberValue =
    (CGFloat)(arc4random()%100000*1.0)/1000000;
    
//    _aview2.string_Prefix = @"¢";
    _aview2.numberValue = 0.50;
//    (CGFloat)(arc4random()%100*1.0)/100;

    _aview3.numberValue = arc4random()%100000000;

}

@end
