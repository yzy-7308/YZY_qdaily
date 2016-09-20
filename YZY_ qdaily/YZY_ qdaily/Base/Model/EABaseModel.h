//
//  BaseModel.h
//  EAKit
//
//  Created by Eiwodetianna on 16/9/19.
//  Copyright © 2016年 Eiwodetianna. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface EABaseModel : NSObject
/**
 *  基类初始化方法
 *
 *  @param dic model对应的字典
 *
 */
- (instancetype)initWithDic:(NSDictionary *)dic;
/**
 *  基类构造器方法
 *
 *  @param dic model对应的字典
 *
 */
+ (instancetype)modelWithDic:(NSDictionary *)dic;
@end
NS_ASSUME_NONNULL_END
