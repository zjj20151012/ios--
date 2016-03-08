//
//  dateButton.m
//  order
//
//  Created by zjj on 16/3/7.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import "dateButton.h"
#import "ViewController.h"

@interface dateButton ()

@end

@implementation dateButton

+ (instancetype)contentButton{
    return [[self alloc]init];
}

- (UIButton *)contentText{
    if ( _contentText == nil) {
        UIButton *btn = [[UIButton alloc]init];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [btn setBackgroundImage:[UIImage imageNamed:@"oreange"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 15;
        btn.selected = NO;
        [self addSubview:btn];
        _contentText = btn;
    }
    return _contentText;
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat GWidth = self.frame.size.width;
    CGFloat GHight = self.frame.size.height;
    self.contentText.frame = CGRectMake(0, 0 ,GWidth , GHight);
    
}


- (void)setBm:(bateModel *)bm{
    _bm = bm;
    [self.contentText setTitle:bm.date forState:UIControlStateNormal];
}

@end
