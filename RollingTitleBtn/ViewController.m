//
//  ViewController.m
//  RollingTitleBtn
//
//  Created by li on 15/9/25.
//  Copyright © 2015年 医视时代. All rights reserved.
//

#import "ViewController.h"
#import "RollingTitleBtn.h"
@interface ViewController ()
@property(nonatomic, strong) RollingTitleBtn *notice;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _notice = [[RollingTitleBtn alloc]init];
    _notice.frame = CGRectMake(20, 80, self.view.bounds.size.width-40, 30);
    NSMutableArray *ticketStrings = [NSMutableArray arrayWithObjects:@"第一行开始了",@"文件夹的菜市场时更换v", @"第二行开始了",nil];
    [_notice setTextStrings:ticketStrings];
    [_notice setRollingSpeed:40.f];
    _notice.contentLabel.textColor = [UIColor yellowColor];
    _notice.contentLabel.font = [UIFont systemFontOfSize:10];
    if (ticketStrings.count > 0) {
        [_notice start];
    }
    [_notice setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _notice.titleLabel.font = [UIFont systemFontOfSize:10];
    _notice.titleLabel.textAlignment = NSTextAlignmentLeft;
    _notice.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    _notice.layer.cornerRadius = 5;
    [_notice addTarget:self action:@selector(enterMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_notice];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)enterMessage:(id)sender
{
    NSLog(@"Rolling");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
