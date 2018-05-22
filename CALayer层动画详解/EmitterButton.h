//
//  EmitterButton.h
//  CALayer层动画详解
//
//  Created by PW on 2018/5/22.
//  Copyright © 2018年 Oriental Horizon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmitterButton : UIView
/**是否选中***/
@property (assign,nonatomic,readonly) BOOL chose;
/**选中回调***/
@property (nonatomic, copy) void (^choseClick)(EmitterButton *button);

-(instancetype)initWithFrame:(CGRect)frame andNormalImage:(UIImage *)image andHighlightImage:(UIImage *)highlightImage andEffectImage:(UIImage *)EffImage;


@end
