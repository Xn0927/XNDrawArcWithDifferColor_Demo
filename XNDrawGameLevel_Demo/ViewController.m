//
//  ViewController.m
//  XNDrawGameLevel_Demo
//
//  Created by ||X.H|| on 2016/11/29.
//  Copyright © 2016年 ||X.H||. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (strong, nonatomic) IBOutlet UITextField *VHTextF;
@property (strong, nonatomic) IBOutlet UITextField *HighTextF;
@property (strong, nonatomic) IBOutlet UITextField *NorTextF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)countMatches
{
    NSInteger matches = _VHTextF.text.integerValue + _HighTextF.text.integerValue + _NorTextF.text.integerValue;
    
    CGFloat vh_rate = _VHTextF.text.integerValue * 2*M_PI / matches;
    CGFloat h_rate = _HighTextF.text.integerValue * 2*M_PI / matches;
    CGFloat n_rate = _NorTextF.text.integerValue * 2*M_PI / matches;
    
    [self drawDataCircleWithVhRate:vh_rate hRate:h_rate norRate:n_rate];
}


- (void)drawDataCircleWithVhRate:(CGFloat)vh_rate hRate:(CGFloat)h_rate norRate:(CGFloat)n_rate
{
    // very high Layer
    CAShapeLayer *vh_Layer = [CAShapeLayer layer];
    vh_Layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height/2+100) radius:100 startAngle:-M_PI/2 endAngle:-M_PI/2+vh_rate clockwise:YES].CGPath;
    vh_Layer.strokeColor = [UIColor orangeColor].CGColor;
    vh_Layer.fillColor = [UIColor clearColor].CGColor;
    vh_Layer.lineWidth = 10;
    [self.view.layer addSublayer:vh_Layer];
    
    // high
    CAShapeLayer *h_Layer = [CAShapeLayer layer];
    h_Layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height/2+100) radius:99 startAngle:-M_PI/2+vh_rate  endAngle:h_rate+(-M_PI/2+vh_rate) clockwise:YES].CGPath;
    h_Layer.strokeColor = [UIColor brownColor].CGColor;
    h_Layer.fillColor = [UIColor clearColor].CGColor;
    h_Layer.lineWidth = 8;
    [self.view.layer addSublayer:h_Layer];
    
    // normal
    CAShapeLayer *n_layer = [CAShapeLayer layer];
    n_layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height/2+100) radius:98 startAngle:h_rate+(-M_PI/2+vh_rate) endAngle:n_rate+(h_rate+(-M_PI/2+vh_rate)) clockwise:YES].CGPath;
    n_layer.strokeColor = [UIColor lightGrayColor].CGColor;
    n_layer.fillColor = [UIColor clearColor].CGColor;
    n_layer.lineWidth = 6;
    [self.view.layer addSublayer:n_layer];

    
    // animate layer
    CAShapeLayer *coverLayer = [CAShapeLayer layer];
    coverLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height/2+100) radius:100 startAngle:-M_PI/2 endAngle:-M_PI/2 + 2*M_PI clockwise:YES].CGPath;
    coverLayer.fillColor = [UIColor clearColor].CGColor;
    coverLayer.strokeColor = [UIColor whiteColor].CGColor;
    coverLayer.lineWidth = 11;
    [self.view.layer addSublayer:coverLayer];
    
    // animation
    CABasicAnimation *baseAnima = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    baseAnima.duration = 5;
    baseAnima.fromValue = @0;
    baseAnima.toValue = @1;
    baseAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [coverLayer setValue:@(-M_PI/2+2*M_PI) forKey:@"strokeStart"];
    [coverLayer addAnimation:baseAnima forKey:@"animateCircle"];
}

- (IBAction)analyseAction:(UIButton *)sender {
    
    [self countMatches];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
