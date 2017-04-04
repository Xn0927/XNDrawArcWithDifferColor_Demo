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

@property (nonatomic, strong) CAShapeLayer *vh_Layer;
@property (nonatomic, strong) CAShapeLayer *h_Layer;
@property (nonatomic, strong) CAShapeLayer *n_Layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    self.vh_Layer = [CAShapeLayer layer];
    self.vh_Layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height/2+100) radius:100 startAngle:-M_PI/2 endAngle:-M_PI/2+vh_rate clockwise:YES].CGPath;
    self.vh_Layer.strokeColor = [UIColor orangeColor].CGColor;
    self.vh_Layer.fillColor = [UIColor clearColor].CGColor;
    self.vh_Layer.lineWidth = 10;
    [self.view.layer addSublayer:self.vh_Layer];
    
    // high
    self.h_Layer = [CAShapeLayer layer];
    self.h_Layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height/2+100) radius:99 startAngle:-M_PI/2+vh_rate  endAngle:h_rate+(-M_PI/2+vh_rate) clockwise:YES].CGPath;
    self.h_Layer.strokeColor = [UIColor brownColor].CGColor;
    self.h_Layer.fillColor = [UIColor clearColor].CGColor;
    self.h_Layer.lineWidth = 8;
    [self.view.layer addSublayer:self.h_Layer];
    
    // normal
    self.n_Layer = [CAShapeLayer layer];
    self.n_Layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height/2+100) radius:98 startAngle:h_rate+(-M_PI/2+vh_rate) endAngle:n_rate+(h_rate+(-M_PI/2+vh_rate)) clockwise:YES].CGPath;
    self.n_Layer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.n_Layer.fillColor = [UIColor clearColor].CGColor;
    self.n_Layer.lineWidth = 6;
    [self.view.layer addSublayer:self.n_Layer];

    
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
    
    if (self.vh_Layer&&self.h_Layer&&self.n_Layer) {
        [self.vh_Layer removeFromSuperlayer];
        [self.h_Layer removeFromSuperlayer];
        [self.n_Layer removeFromSuperlayer];
    }
    
    [self countMatches];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
