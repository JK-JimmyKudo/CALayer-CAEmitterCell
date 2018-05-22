//
//  EmitterButton.m
//  CALayer层动画详解
//
//  Created by PW on 2018/5/22.
//  Copyright © 2018年 Oriental Horizon. All rights reserved.
//

#import "EmitterButton.h"
@interface EmitterButton ()
{
    UIImage *Nimage;
    UIImage *Himage;
    UIImage *Eimage;
    UIImageView *imageView;
    BOOL isChose;
    CAEmitterLayer *emitterLayer;
    CAEmitterCell *emitterCell;
}
@end


@implementation EmitterButton

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        Himage = [UIImage imageNamed:@"comment_praise_on"];
        Nimage = [UIImage imageNamed:@"comment_praise"];
        Eimage = [UIImage imageNamed:@"snow"];
        [self setUpSubviews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame andNormalImage:(UIImage *)image andHighlightImage:(UIImage *)highlightImage andEffectImage:(UIImage *)EffImage
{
    self = [super initWithFrame:frame];
    if (self) {
        Nimage = image;
        Himage = highlightImage;
        Eimage = EffImage;
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews
{
    imageView = [[UIImageView alloc]init];
    imageView.frame = self.bounds;
    imageView.userInteractionEnabled = YES;
    [imageView setImage:Nimage];
    [self addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap)];
    [imageView addGestureRecognizer:tap];
    
    emitterLayer = [CAEmitterLayer layer];
    //设置发射位置
    [emitterLayer setEmitterPosition:CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0)];
    //设置发射源的大小
    [emitterLayer setEmitterSize:CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    //设置发射源的形状
    [emitterLayer setEmitterShape:kCAEmitterLayerCircle];
    //设置发射模式
    [emitterLayer setEmitterMode:kCAEmitterLayerOutline];
    [self.layer addSublayer:emitterLayer];
    
    emitterCell = [CAEmitterCell emitterCell];
    //设置粒子的名字
    [emitterCell setName:@"emitterButton"];
    //设置粒子速度
    [emitterCell setVelocity:50];
    //设置粒子速度范围
    [emitterCell setVelocityRange:50];
    //设置粒子参数的速度乘数因子
    [emitterCell setBirthRate:0];
    //设置粒子生命周期
    [emitterCell setLifetime:1.0];
    //设置粒子透明度在生命周期内的改变速度
    [emitterCell setAlphaSpeed:-1];
    //设置粒子要展现的图片,是个 CGImageRef 的对象
    [emitterCell setContents:(__bridge id)Eimage.CGImage];
    
    [emitterLayer setEmitterCells:@[emitterCell]];
}

-(void)imageViewTap{
    isChose = !isChose;
    [self setCurrentImage];
    imageView.bounds = CGRectZero;
    
    
    [UIView animateWithDuration:0.25 delay:0 options:0.3 animations:^{
        [imageView setBounds:self.bounds];
        if (isChose)
        {
            CABasicAnimation *baseAnimat = [CABasicAnimation animationWithKeyPath:@"emitterCells.emitterButton.birthRate"];
            [baseAnimat setFromValue:[NSNumber numberWithFloat:100]];
            [baseAnimat setToValue:[NSNumber numberWithFloat:0]];
            baseAnimat.duration = 0;
            baseAnimat.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            [emitterLayer addAnimation:baseAnimat forKey:@"effectButton"];
        }
    } completion:nil];
    
}
-(void)setCurrentImage
{
    if (isChose) {
        [imageView setImage:Himage];
    }else{
        [imageView setImage:Nimage];
    }
}

-(BOOL)chose
{
    return isChose;
}


@end
