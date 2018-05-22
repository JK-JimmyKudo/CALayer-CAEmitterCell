//
//  ViewController.m
//  CALayer层动画详解
//
//  Created by PW on 2018/5/22.
//  Copyright © 2018年 Oriental Horizon. All rights reserved.
//

#import "ViewController.h"
#import "EmitterButton.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>





@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UIView *tableViewHeadView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width , self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    self.tableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    
    self.tableViewHeadView.backgroundColor = [UIColor orangeColor];
    
    self.tableView.tableHeaderView = self.tableViewHeadView;
    
    
    EmitterButton *button = [[EmitterButton alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    [self.tableViewHeadView addSubview:button];
    
    button.choseClick = ^(EmitterButton *button) {
        NSLog(@"ddd");
    };
    
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

    
    
//    [self FlameEffect];
    


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
        [self emitterAnimate1];
    }else if (indexPath.row == 2){
        [self emitterAnimate];
    }else if (indexPath.row == 3){
        [self emitterAnimate3];
    }
}

//案例一：粒子火焰效果
-(void)FlameEffect{
    
   /*
    iOS 中火焰效果是由一个个iOS的粒子特性描绘出来的，所以每个粒子的具体特性将决定火焰的具体形状，下面对粒子的常用属性做个分析：
    1、birthRate：表明火焰效果中每秒粒子的组成个数，个数越多，火焰越逼真。虽然每秒粒子数反应了火焰的燃烧效果，但并不是粒子数越多越好。粒子数过多一方面会掩盖每个粒子的一些具体细节，另一方面会给iOS图像渲染造成很大的负担。
    2、velocity：表明当前粒子速度信息，不同的粒子速度控制燃烧的剧烈程度以及火焰的燃烧方向。
    */
    
    self.tableView.backgroundColor = [UIColor blackColor];
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
    cell.emissionLongitude = 0.0;
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


//鬼火效果
-(void) emitterAnimate1{
    self.tableView.backgroundColor = [UIColor blackColor];
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.name = @"fire";
    emitterCell.emissionLongitude = 0.8;
    emitterCell.velocity = -1; //粒子速度 负数表明向上燃烧
    emitterCell.velocityRange = 50; //粒子速度范围
    emitterCell.emissionRange = 1.1; //周围发射角度
    emitterCell.yAcceleration =  -200; //粒子y方向的加速度分量
    emitterCell.scaleSpeed = 0.7; //缩放比例  超大火苗
//    emitterCell.color = UIColor(red: 0 ,green: 0.4 ,blue:0.2 ,alpha:0.1).cgColor
    emitterCell.color = [UIColor colorWithRed:0 green:0.4 blue:0.2 alpha:0.1].CGColor;
//    emitterCell.contents = UIImage(named: "fire")!.cgImage
    emitterCell.contents = (__bridge id )([UIImage imageNamed:@"fire"].CGImage);
    
    
    
    
//    //每个图像单位
//    CAEmitterCell *cell = [CAEmitterCell emitterCell];
//    cell.contents = (__bridge id)[UIImage imageNamed:@"fire"].CGImage;
//    cell.name = @"fire";//粒子的名字
//    cell.emissionLongitude = 0.0;
//    //    图像的出现频率（每秒钟图片出现的数量）
//    cell.birthRate = 80;
//    //每个图像的生命周期
//    cell.lifetime = 3.0;
//    //图片背景色，不设置就是原图
//    cell.color = [UIColor yellowColor].CGColor;
//    //透明度每过一秒就是减少0.5
//    cell.alphaSpeed = -0.2;
//    //发射速度
//    cell.velocity = -1;
//    //每个图像速度范围
//    cell.velocityRange = 30;
//    //散射的范围，目前是向四周
//    cell.emissionRange = 1.1;
//    //缩放比例  超大火苗
//    cell.scaleSpeed = 0.3;
//    //粒子y方向的加速度分量
//    cell.yAcceleration = -40;
//    //开始动画
    
    
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = self.view.frame;
    emitterLayer.position = self.view.center; //粒子发射位置
    emitterLayer.emitterPosition = CGPointMake(emitterLayer.frame.size.width / 2.0, emitterLayer.frame.size.height / 2.0);
    [self.view.layer addSublayer:emitterLayer];

//    emitterLayer.emitterSize = CGSize(width: 50, height: 10)//控制大小
    emitterLayer.emitterSize = CGSizeMake(50, 10);
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    emitterLayer.emitterCells = @[emitterCell];
    
    [emitterLayer setValue:@"500" forKey:@"emitterCells.fire.birthRate"];
    [emitterLayer setValue:@"1" forKey:@"emitterCells.fire.lifetime"];
    

}

//霓虹效果
-(void) emitterAnimate{
    self.tableView.backgroundColor = [UIColor blackColor];
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.name = @"nenolight";
    emitterCell.emissionLongitude  = 1.2;// emissionLongitude:x-y 平面的 发 射方向
    emitterCell.velocity = 50;// 粒子速度
    emitterCell.velocityRange = 50;// 粒子速度范围
    emitterCell.scaleSpeed = -0.2;// 速度缩放比例 超大火苗
    emitterCell.scale = 0.1;  //缩放比例
    //R G B alpha 颜色速度渐变
    emitterCell.greenSpeed = -0.1;
    emitterCell.redSpeed = -0.2;
    emitterCell.blueSpeed = 0.1;
    emitterCell.alphaSpeed = -0.2;
    emitterCell.birthRate = 100; // 一秒钟会产生粒子的个数
    emitterCell.lifetime = 4; //粒子生命周期
    emitterCell.color = [UIColor whiteColor].CGColor;
//    emitterCell.contents = UIImage(named: "neonlight")!.cgImage
    emitterCell.contents = (__bridge id )([UIImage imageNamed:@"nenolight"].CGImage);
    
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.position = self.view.center;// 粒子发射位置
    emitterLayer.emitterSize = CGSizeMake(2, 2); // 控制粒子大小
    emitterLayer.renderMode = kCAEmitterLayerBackToFront;
    emitterLayer.emitterMode = kCAEmitterLayerOutline;// 控制发射源模式 即形状
    emitterLayer.emitterShape = kCAEmitterLayerCircle;
    emitterLayer.emitterCells = @[emitterCell];
    [self.view.layer addSublayer:emitterLayer];
}



//雪花效果
-(void)emitterAnimate3{
    self.tableView.backgroundColor = [UIColor blackColor];
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.name = @"snow";
    emitterCell.birthRate = 150; // 每秒产生的粒子数量
    emitterCell.lifetime = 5; //粒子的生命周期
//    //yAcceleration 和 xAcceleration 分别表示颗粒在y和x方向上面运动的加速度
    emitterCell.yAcceleration = 70.0;
    emitterCell.xAcceleration = 10.0;
    emitterCell.velocity = 20.0; //velocity表示粒子运动的速度
    emitterCell.emissionLongitude = -M_PI_2;//表示颗粒初始时刻发射的方向(-M_PI_2 表示竖直往上发射)
    emitterCell.velocityRange = 200;//加上这句代码之后，随机产生的速度范围为 -180(20 - 200) 到 220(20 + 200)
    emitterCell.emissionRange = -M_PI_2 * 1.2;//我们可以将发射器的发射角度随机化
//    //R G B alpha 颜色速度渐变
//    emitterCell.color = UIColor(red: 0.9 ,green: 1.0 ,blue:1.0 ,alpha:1).cgColor
    emitterCell.color = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1].CGColor;
    emitterCell.greenSpeed = 0.3;
    emitterCell.redSpeed = 0.3;
    emitterCell.blueSpeed = 0.3;
    emitterCell.scaleSpeed = -0.03;// 速度缩放比例
    emitterCell.scale = 0.1;  //缩放比例
    emitterCell.scaleRange = 0.1;
//    emitterCell.contents = UIImage(named: "snow")!.cgImage
    
    emitterCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"snow"].CGImage);
    
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
//    //确定发射器的位置及尺寸
//    emitterLayer.position = CGPoint(x: self.view.center.x, y: -70)
    emitterLayer.position = CGPointMake(self.view.center.x, -70);
//    emitterLayer.emitterSize = CGSize(width: UIScreen.main.bounds.size.width, height: 50)
    emitterLayer.emitterSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 50);
        emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    emitterLayer.emitterCells = @[emitterCell];
    [self.view.layer addSublayer:emitterLayer];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
