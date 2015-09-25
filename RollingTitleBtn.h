//
//  RollingTitleBtn.h
//  RollingTitleBtn
//
//  Created by li on 15/9/25.
//  Copyright © 2015年 医视时代. All rights reserved.
//
typedef enum
{
    DirectionLTR,
    DirectionRTL,
}RollingDirection;
#import <UIKit/UIKit.h>

@interface RollingTitleBtn : UIButton
{
    @public
    int currentIndex;
    @public
//    BOOL running;
}
@property(nonatomic,assign)BOOL isRuned;
@property(nonatomic,assign)BOOL running;
@property(nonatomic, strong)UILabel *contentLabel;
@property(nonatomic, strong)NSMutableArray *textStrings;
@property(nonatomic) float rollingSpeed;
@property(nonatomic) BOOL loops;
@property(nonatomic) RollingDirection direction;
-(void)start;
-(void)pause;
-(void)resume;
@end
