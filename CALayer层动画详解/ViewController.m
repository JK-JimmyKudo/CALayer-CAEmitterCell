//
//  ViewController.m
//  CALayer层动画详解
//
//  Created by PW on 2018/5/22.
//  Copyright © 2018年 Oriental Horizon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width , self.view.bounds.size.height) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.view addSubview:self.tableView];
//
//
    self.dataArray = @[@"案例一：粒子火焰效果",@"案例二：“鬼火”火焰效果",@"案例三：霓虹效果",@"案例四：雪花效果"];
    
/*
 在iOS系统中，粒子系统由两部分组成：CAEmitterLayer和CAEmitterCell。
 1、CAEmitterLayer为粒子发射图层。该图层主要用于控制粒子展现范围、粒子发射位置、粒子发射形状、渲染模式等属性。通过CAEmitterCell构建的发射单元都受到CAEmitterLayer图层节制，可以说粒子展现必须在CAEmitterLayer图层上来实现。
 1、CAEmitterCell粒子发射单元，用于对粒子系统的单个粒子做更加精细的控制。比如控制粒子的速度、方向、范围。在CAEmitterCell类中提供了几十种粒子属性参数设置，所以结合这些属性可以制作各种炫酷的粒子特效动画。
 部分重要属性详解：
 
 CAEmitterCell
 name：名称
 birthRate：每秒产生粒子的数量
 lifetime：粒子的生命周期
 yAcceleration，xAcceleration：分别表示颗粒在y和x方向上面运动的加速度
 velocity：表示粒子运动的速度
 emissionLongitude：表示颗粒初始时刻发射的方向(-M_PI_2 表示竖直往上发射)
 velocityRange：//随机产生的速度范围为 (velocity - velocityRange) 到(velocity + velocityRange)
 emissionRange：//将发射器的发射角度随机化
 color：粒子颜色
 greenSpeed，redSpeed，blueSpeed：颜色渐变范围
 scale：缩放比例
 scaleRange：缩放范围
 scaleSpeed：缩放速度比例
 contents：内容
 
 CAEmitterLayer
 position：发射器的位置
 emitterSize：发射器大小
 emitterShape：发射模式
 KCAEmitterLayerPoint：这种发射形态可以促使所有的颗粒都聚集于一点(即发射器的position所在处)，使用它可以实现火花或者烟火的效果
 KCAEmitterLayerLine：这种发射形态可以促使所有的颗粒都沿着发射器的顶部出现，使用它可以实现瀑布流等效果
 KCAEmitterLayerRectangle这种发射形态可以使得颗粒在一个指定的矩形区域随机的出现，使用它可以实现雪花飘落等
 效果
 
 
 */

    
    
    [self FlameEffect];
    


}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataArray.count;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  50;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    static NSString *inderfier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inderfier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inderfier];
    }
    
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
     
        [self FlameEffect];
        
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
        
    }
}

//案例一：粒子火焰效果
-(void)FlameEffect{
    
   /*
    iOS 中火焰效果是由一个个iOS的粒子特性描绘出来的，所以每个粒子的具体特性将决定火焰的具体形状，下面对粒子的常用属性做个分析：
    1、birthRate：表明火焰效果中每秒粒子的组成个数，个数越多，火焰越逼真。虽然每秒粒子数反应了火焰的燃烧效果，但并不是粒子数越多越好。粒子数过多一方面会掩盖每个粒子的一些具体细节，另一方面会给iOS图像渲染造成很大的负担。
    2、velocity：表明当前粒子速度信息，不同的粒子速度控制燃烧的剧烈程度以及火焰的燃烧方向。
    */
    
    self.view.backgroundColor = [UIColor blackColor];
//    创建一个CAEmitterLayer,大小同view一样
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.frame;
    [self.view.layer addSublayer:emitter];
    //渲染模式！！！一共有五个效果，修改了效果会有区分
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterMode = kCAEmitterLayerOutline;
    emitter.emitterShape = kCAEmitterLayerLine;
    //整体位置
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
//    emitter.position = self.view.center;
    emitter.emitterSize = CGSizeMake(50, 10);
    [emitter setValue:@"500" forKey:@"emitterCells.fire.birthRate"];
    [emitter setValue:@"1" forKey:@"emitterCells.fire.lifetime"];


    //每个图像单位
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (__bridge id)[UIImage imageNamed:@"fire"].CGImage;
    cell.name = @"fire";//粒子的名字
    cell.emissionLongitude = 0.5;
//    图像的出现频率（每秒钟图片出现的数量）
    cell.birthRate = 80;
    //每个图像的生命周期
    cell.lifetime = 3.0;
    //图片背景色，不设置就是原图
    cell.color = [UIColor yellowColor].CGColor;
    //透明度每过一秒就是减少0.5
    cell.alphaSpeed = -0.2;
    //发射速度
    cell.velocity = -1;
    //每个图像速度范围
    cell.velocityRange = 30;
    //散射的范围，目前是向四周
    cell.emissionRange = 1.1;
    //缩放比例  超大火苗
    cell.scaleSpeed = 0.3;
    //粒子y方向的加速度分量
    cell.yAcceleration = -40;
    //开始动画
    emitter.emitterCells = @[cell];
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
