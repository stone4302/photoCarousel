//
//  ViewController.m
//  PhotoShow
//
//  Created by 彭丙向 on 16/3/31.
//  Copyright © 2016年 pengbingxiang. All rights reserved.
//

#import "ViewController.h"
#import "XGCirculScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)createUI{
    
    XGCirculScrollView *cirSc = [XGCirculScrollView circulScrollView];
    
    cirSc.frame = CGRectMake(20, 50, 300, 130);
    
    //    cirSc.imageNamesArray = @[@"img_00"];
    
    cirSc.imageNamesArray = @[@"img_00",@"img_01",@"img_02",@"img_03",@"img_04"];
    
    cirSc.userEnabled = YES;
    
    cirSc.scrollDirection = YES;
    
    cirSc.pageTintColor = [UIColor blueColor];
    
    cirSc.currentPageTintColor = [UIColor orangeColor];
    
    [self.view addSubview:cirSc];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
