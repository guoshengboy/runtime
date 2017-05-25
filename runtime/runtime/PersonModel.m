//
//  PersonModel.m
//  runtime
//
//  Created by cgs on 2017/5/24.
//  Copyright © 2017年 cgs. All rights reserved.
//

#import "PersonModel.h"
#import "StandbyTargetModel.h"
#import <objc/runtime.h>

@implementation PersonModel


#pragma mark ----------第一次添加------------

/**
 动态添加方法(这个是定义了一个函数实现指针IMP)

 @param self 接收者
 @param _cmd 选择器
 */
void dynamicMethod(id self, SEL _cmd, id value) {
    
    NSLog(@"首先尝试动态添加方法");
}

/**
 第一次调此方法

 @param sel 选择器
 @return yes 消息已处理
 */
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    NSString *selStr = NSStringFromSelector(sel);
    if ([selStr isEqualToString:@"eat"]) {
        
        class_addMethod([self class], sel, (IMP)dynamicMethod, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

#pragma mark ----------第二次添加------------

/**
 启动备用接受者

 @param aSelector 选择器
 @return 改接受者的对象或类（看什么方法）
 */
-(id)forwardingTargetForSelector:(SEL)aSelector{
    
    return [[StandbyTargetModel alloc] init];
}


#pragma mark ----------第三次添加------------


-(void)drink:(NSString *)str :(NSString *)str1{
    
    NSLog(@"\n第三次添加\n");
}

/**
 函数符号制造器
 
 @param aSelector 未处理的选择器
 @return 方法的封装
 */
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (aSelector == @selector(eat:)) {
      
        if (!signature) {
            
            //可以是任意函数
            if ([[StandbyTargetModel new] respondsToSelector:@selector(eat:)]) {
                
                //可以是其他类
                signature = [StandbyTargetModel instanceMethodSignatureForSelector:@selector(eat:)];
            }
        }
    }
    return signature;
}

/**
 * 函数执行器 这个函数中可以修改很多信息，比如可以替换选方法的处理者，替换选择子，修改参数等等
   发现只要methodSignatureForSelector返回不为空 forwardInvocation这个可以和methodSignatureForSelector类与方法可以不一样
 *
 *  @param anInvocation 被转发的选择子
 */
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    
    [anInvocation setSelector:@selector(drink::)];
    //可以接受者可以不是self
    [anInvocation invokeWithTarget:self];
    
}



#pragma mark ----------method swizzle------------

/**
 黑魔法
 */
-(void)methodSwizzle{
    
    Method one = class_getInstanceMethod([self class], @selector(palyBall:));
    Method two = class_getInstanceMethod([self class], @selector(washCar:));
    
    method_exchangeImplementations(one, two);
}


/**
 玩球
 
 @param name <#name description#>
 */
-(void)palyBall:(NSString *)name{
    
    NSLog(@"%@在玩球",name);
}



/**
 洗车
 
 @param name <#name description#>
 */
-(void)washCar:(NSString *)name{
    
    NSLog(@"%@在洗车",name);
}








@end
