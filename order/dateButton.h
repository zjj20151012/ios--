//
//  dateButton.h
//  order
//
//  Created by zjj on 16/3/7.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bateModel.h"

@interface dateButton : UIView
/**
 *  model
 */
@property (strong,nonatomic) bateModel *bm;
/**
 *  文字视图
 */
@property (strong,nonatomic) UIButton *contentText;

+ (instancetype)contentButton;

@end
