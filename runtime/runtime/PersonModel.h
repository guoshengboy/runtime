//
//  PersonModel.h
//  runtime
//
//  Created by cgs on 2017/5/24.
//  Copyright © 2017年 cgs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

/**
 不实现实现文件
 */
-(void)eat:(NSString *)str;





/**
 黑魔法
 */
-(void)methodSwizzle;


/**
 玩球

 @param name <#name description#>
 */
-(void)palyBall:(NSString *)name;



/**
 洗车
 
 @param name <#name description#>
 */
-(void)washCar:(NSString *)name;



@end
