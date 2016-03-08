//
//  ViewController.m
//  order
//
//  Created by zjj on 16/3/7.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import "ViewController.h"
#import "bateModel.h"
#import "dateButton.h"

@interface ViewController ()

@property (nonatomic,weak) UIButton *add;
@property (weak,nonatomic) UIButton *delete;
@property (strong,nonatomic) NSArray *dataArr;
@property (strong,nonatomic) dateButton *dateBtn;
@property (strong,nonatomic) UIView *goodsView;
@property (strong,nonatomic) UIView *dateView;
@property (strong,nonatomic) UILabel *lb;
@property (strong,nonatomic) UIButton *tempButton;


@end

@implementation ViewController



static int i = 1;
static UILabel *l;
static NSString *yearString;
static NSString *mounthString;
static NSString *dayString;
static NSDictionary *dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tempButton = [[UIButton alloc]init];
    self.tempButton.selected = YES;
    
   self.add = [self setBtnBackGroundColor:[UIColor redColor] withTitle:@"+" titleColor:[UIColor whiteColor] withTag:1000 alsoFram:CGRectMake(0, 20, 50, 50) addTarget:@selector(btnTarget:)];
    self.delete = [self setBtnBackGroundColor:[UIColor redColor] withTitle:@"-" titleColor:[UIColor whiteColor] withTag:2000 alsoFram:CGRectMake([UIScreen mainScreen].bounds.size.width-50, 20, 50, 50) addTarget:@selector(btnTarget:)];
    self.delete.enabled = NO;

    l = [[UILabel alloc]initWithFrame:CGRectMake(175, 40, 100, 30)];
   
    l.text = @"1";
    [self.view addSubview:l];
    self.lb = [[UILabel alloc]initWithFrame:CGRectMake(120, 80, 150, 30)];
    [self.view addSubview:_lb];
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY/MM/dd"];
   
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
     NSArray *date = [locationString componentsSeparatedByString:@"/"];
    yearString = date[0];
    mounthString = date[1];
    dayString = date[2];
    NSString *year = [yearString stringByAppendingString:@"年"];
    NSString *mounth = [mounthString stringByAppendingString:@"月"];
    NSString *day = [dayString stringByAppendingString:@"日"];
    NSString *str = [[year stringByAppendingString:mounth]stringByAppendingString:day];
    self.lb.text = str;
    
    [self addGoodsView];
    
    [self addB];

    
}

- (NSArray *)dataArr{
     NSMutableArray *arr =[NSMutableArray array];
    for (int i = 1; i<32; i++) {
        NSString *str = [NSString string];
        str = [NSString stringWithFormat:@"%d",i];
        NSDictionary *d = @{
                            @"date":str,
                            };
        [arr addObject:d];
    }
    
    NSMutableArray *modelArray = [NSMutableArray array];
    if (_dataArr == nil) {
        self.dataArr = arr;
        for (NSDictionary *dic in self.dataArr) {
            bateModel *bm = [bateModel dateModelWithDict:dic];
            
            [modelArray addObject:bm];
        }

       _dataArr = modelArray;
    }
    return _dataArr;
}

/** 添加一个放东西的View */
- (void)addGoodsView{
    _goodsView = [[UIView alloc]init];
    _goodsView.frame = CGRectMake(30, 150, [UIScreen mainScreen].bounds.size.width-60,[UIScreen mainScreen].bounds.size.height-300);
    [_goodsView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_goodsView];
    _dateView = [[UIView alloc]init];
    _dateView.frame = CGRectMake(30, 110, [UIScreen mainScreen].bounds.size.width-60,30);
    [_dateView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_dateView];

}


- (void)addB{
    
       for (int i = 0; i < self.dataArr.count ; i++) {
          
           //总列数
           int totalCols = 7;
           //总行数
           int totalRows = 7;
           CGFloat goodsWidth = self.goodsView.frame.size.width;
           CGFloat goodsHeight = self.goodsView.frame.size.height;
           CGFloat contentViewWidth = 30;
           CGFloat contentViewHeight = 30;
           NSUInteger colNum = i/totalCols;
           NSUInteger rowNum = i%totalCols;
           NSUInteger colMargin = (goodsWidth - totalCols * contentViewWidth)/(totalCols - 1);
           NSUInteger rowMargin = (goodsHeight - totalRows * contentViewHeight)/(totalRows - 1);

           NSUInteger GWidth = rowNum*contentViewWidth +rowNum*colMargin;
           NSUInteger GHeight = colNum*contentViewHeight +colNum*rowMargin;
        
            _dateBtn = [[dateButton alloc]init];
            _dateBtn.frame = CGRectMake(GWidth, GHeight, contentViewWidth,contentViewHeight);
            [_dateBtn setBackgroundColor:[UIColor clearColor]];
            _dateBtn.bm = self.dataArr[i];
            [_dateBtn.contentText addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
           //当前按钮的title值小于当前日期，禁用
           if ([dayString intValue]>i+1) {
               _dateBtn.contentText.enabled = NO;
           }
           //当前按钮的title值等于当前日期
           if ([dayString intValue] == i+1) {
               if(_dateBtn.contentText!=self.tempButton){
                   self.tempButton.selected=NO;
                   self.tempButton=_dateBtn.contentText;
               }
               
               self.tempButton.selected=YES;
           }
           self.goodsView.clipsToBounds = YES;
            [self.goodsView addSubview:_dateBtn];

}
    NSArray *arr =@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i < arr.count ; i++) {
        //总列数
        int totalCols = 7;
        CGFloat dateWidth = self.dateView.frame.size.width;
        CGFloat contentViewWidth = 30;
        CGFloat contentViewHeight = 30;
        NSUInteger rowNum = i%totalCols;
        NSUInteger colMargin = (dateWidth - totalCols * contentViewWidth)/(totalCols - 1);
        NSUInteger GWidth = rowNum*contentViewWidth +rowNum*colMargin;
        NSString *str = arr[i];
        [self setLabel:[UIColor blackColor] withTitle:str withFont:17.0 alsoFram:CGRectMake(GWidth, 0, contentViewWidth, contentViewHeight) andTextAlig:NSTextAlignmentCenter];
    }
    
}

- (void)setLabel:(UIColor *)labelColor withTitle:(NSString *)labelTitle withFont:(CGFloat) labelFont alsoFram:(CGRect)labelFram andTextAlig:(int) alig{
    UILabel *label = [[UILabel alloc]init];
    label.text = labelTitle;
    [label setTextColor:labelColor];
    label.frame = labelFram;
    label.font = [UIFont systemFontOfSize:labelFont];
    label.textAlignment = alig;
    [self.dateView addSubview:label];
    
}

- (UIButton *)setBtnBackGroundColor:(UIColor *)backGroundCol withTitle:(NSString *)btnTitle titleColor:(UIColor *)btnTitleCol withTag:(int)tag alsoFram:(CGRect)btnFram addTarget:(SEL)btnTarget{
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundColor:backGroundCol];
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTintColor:btnTitleCol];
    btn.frame = btnFram;
    [btn addTarget:self action:btnTarget forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self.view addSubview:btn];
    return btn;
}
- (void)btnTarget:(UIButton *)sender{
    if (sender.tag == 1000) {
        i += 1;
        NSString *str = [NSString stringWithFormat:@"%d",i];
        l.text = str;
        [self checkBtnState];

    }else{
        i -= 1;
        NSString *str = [NSString stringWithFormat:@"%d",i];
        l.text = str;
        [self checkBtnState];
    }
    
}

- (void)click:(UIButton *)sender{

    NSString *year = [yearString stringByAppendingString:@"年"];
    NSString *mounth = [mounthString stringByAppendingString:@"月"];
    NSString *day = [sender.titleLabel.text stringByAppendingString:@"日"];
 
    if(sender!=self.tempButton){
        self.tempButton.selected=NO;
        self.tempButton=sender;
    }
    
    self.tempButton.selected=YES;
  
    NSString *str = [[year stringByAppendingString:mounth]stringByAppendingString:day];

    _lb.text = str;
}


- (void)checkBtnState{
    self.add.enabled = i>=1 ? YES : NO;
    self.delete.enabled = i<=1 ? NO : YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
