//
//  bateModel.h
//  order
//
//  Created by zjj on 16/3/7.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bateModel : NSObject
/**
 *  标题模型
 */
@property (strong,nonatomic)  NSString *date;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)dateModelWithDict:(NSDictionary *)dict;

@end
