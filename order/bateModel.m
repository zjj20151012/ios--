//
//  bateModel.m
//  order
//
//  Created by zjj on 16/3/7.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import "bateModel.h"

@interface bateModel ()
/**
 *  arr
 */
@property (strong,nonatomic) NSArray *arr;
@end

@implementation bateModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {

    self.date = dict[@"date"];

    }
    return self;
}

+ (instancetype)dateModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}



@end
