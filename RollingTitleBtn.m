//
//  RollingTitleBtn.m
//  RollingTitleBtn
//
//  Created by li on 15/9/25.
//  Copyright © 2015年 医视时代. All rights reserved.
//

#import "RollingTitleBtn.h"
#import <QuartzCore/QuartzCore.h>
@implementation RollingTitleBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        self.isRuned = NO;
    }
    return self;
}
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    
//}
-(void)setupView{
    //设置默认背景颜色
    [self setBackgroundColor:[UIColor clearColor]];
    [self setClipsToBounds:YES];
    
    // Set the Font
//    UIFont *tickerFont = [UIFont fontWithName:@"Marker Felt" size:22.0];
//    UIFont *font = [UIFont systemFontOfSize:14];
    //添加滚动内容label
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_contentLabel setBackgroundColor:[UIColor clearColor]];
    [_contentLabel setNumberOfLines:1];
    
    //[_contentLabel setFont:font];
    [self addSubview:_contentLabel];
    //是否重复
    self.loops = YES;
    //滚动方向
    self.direction = DirectionLTR;
}
-(void)animateCurrentTickerString{
    NSString *currentString = [self.textStrings objectAtIndex:currentIndex];
    
    //Calculate the size of the text and update the frame size of the ticker label
    CGRect textRect = [currentString boundingRectWithSize:CGSizeMake(9999, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:_contentLabel.font,NSFontAttributeName, nil] context:nil];
    // Setup some starting and end points
    float staringX = 0.0f;
    float endX = 0.0f;
    switch (self.direction) {
        case DirectionRTL:
            staringX = -textRect.size.width;
            endX = self.frame.size.width;
            break;
        case DirectionLTR:
            staringX = self.frame.size.width;
            endX = -textRect.size.width;
        default:
            break;
    }
    // Set starting position
    [_contentLabel setFrame:CGRectMake(staringX, _contentLabel.frame.origin.y, textRect.size.width, self.frame.size.height)];
    
    // Set the string
    [_contentLabel setText:currentString];
    
    // Calculate a uniform duration for the item
    float duration = (textRect.size.width + self.frame.size.width) / self.rollingSpeed;
    // Create a UIView animation
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(tickerMoveAnimationDidStop:finish:context:)];
    
    // Update end position
    CGRect tickerFrame = _contentLabel.frame;
    tickerFrame.origin.x = endX;
    [_contentLabel setFrame:tickerFrame];
    
    [UIView commitAnimations];
}
-(void)tickerMoveAnimationDidStop:(NSString *)animationID finish:(NSNumber *)finish context:(void *)context{
    // Update the index
    currentIndex++;
    
    //Check the index count
    if (currentIndex >= [self.textStrings count]) {
        currentIndex = 0;
        
        //Check if we should loop
        if (!self.loops) {
            _running = NO;
            return;
        }
    }
    
    //Animate
    [self animateCurrentTickerString];
}

#pragma mark - Ticker Animation handling
-(void)start{
    [self.layer removeAllAnimations];
    // Set the index to 0 on starting
    currentIndex = 0;
    _isRuned = YES;
    // Set running
    _running = YES;
    
    //Start the animation
    [self animateCurrentTickerString];
}
-(void)pause{
    // Check if running
    if (_running) {
        // Pause the layer
        [self pauseLayer:self.layer];
        
        _running = NO;
    }
}

-(void)resume{
    // Check not running
    if (!_running) {
        //Resume the layer
        [self resumeLayer:self.layer];
        
        _running = YES;
    }
}

#pragma  mark -UIView layer animaion utiltiles
-(void)pauseLayer:(CALayer *)layer{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}
-(void)resumeLayer:(CALayer *)layer{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}
@end
