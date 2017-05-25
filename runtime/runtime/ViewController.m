//
//  ViewController.m
//  runtime
//
//  Created by cgs on 2017/5/24.
//  Copyright © 2017年 cgs. All rights reserved.
//

#import "ViewController.h"
#import "PersonModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //消息转发  不实现实现文件eat方法
    PersonModel *person = [[PersonModel alloc] init];
    [person eat:@"苹果"];
    
    //method  swizzle
    //正常
    [person palyBall:@"bob"];
    [person washCar:@"abc"];
    //交换
    [person methodSwizzle];
    [person palyBall:@"bob"];
    [person washCar:@"abc"];
}




@end
