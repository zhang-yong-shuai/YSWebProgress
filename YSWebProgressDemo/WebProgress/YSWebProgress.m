//
//  YSWebProgress.m
//  YSWebProgressDemo
//
//  Created by ZhangYongShuai on 16/9/6.
//  Copyright © 2016年 XinYiChangXiang. All rights reserved.
//

#import "YSWebProgress.h"

float const kFirstStageBoundaryValue  = .6f;
float const kSecondStageBoundaryValue = .8f;
float const kThirdStageBoundaryValue  = .95f;

NSTimeInterval const kWebProgressTimerDuration = .01f;

NSTimeInterval const kFirstStageDuration  = 2.f;
NSTimeInterval const kSecondStageDuration = 2.f;
NSTimeInterval const kThirdStageDuration  = 3.f;
NSTimeInterval const kEndStageDuaration = .12f;

#define kFirstStageOffSet  ((kFirstStageBoundaryValue - .1f) / kFirstStageDuration * kWebProgressTimerDuration)
#define kSecondStageOffSet ((kSecondStageBoundaryValue - kFirstStageBoundaryValue)/ kSecondStageDuration * kWebProgressTimerDuration)
#define kThirdStageOffSet  ((kThirdStageBoundaryValue - kSecondStageBoundaryValue) / kThirdStageDuration * kWebProgressTimerDuration)
#define kEndStageOffset ((1.f - self.willEndProgress) / kEndStageDuaration * kWebProgressTimerDuration)

@interface YSWebProgress ()

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) float willEndProgress;// 即将结束时的progress
@property (nonatomic, assign) BOOL isTerminated;    // 是否已经结束

@end

@implementation YSWebProgress
#pragma mark - life cycle
- (void)willMoveToSuperview:(UIView *)newSuperview {
    CGSize size = newSuperview.bounds.size;
    self.frame = CGRectMake(0, 0, size.width, 2);
}

#pragma mark - getters
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self addSubview:_progressView];
        _progressView.frame = self.frame;
        _progressView.progressTintColor = [UIColor greenColor];
        _progressView.trackTintColor = [UIColor whiteColor];
        _progressView.progress = 0.f;
    }
    
    return _progressView;
}

#pragma mark - set progerss
- (void)startProgress {
    self.isTerminated = NO;
    self.hidden = NO;
    self.progressView.progress = .1f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kWebProgressTimerDuration target:self selector:@selector(handleProgress:) userInfo:nil repeats:YES];
}

- (void)endProgress {
    self.willEndProgress = self.progressView.progress;
    self.isTerminated = YES;
}

#pragma mark - timer action
- (void)handleProgress:(NSTimer *)timer {
    if (self.isTerminated == NO) {
        if (self.progressView.progress < kFirstStageBoundaryValue) {
            [self handleFirstStage];
        } else if (self.progressView.progress < kSecondStageBoundaryValue) {
            [self handleSecondStage];
        } else if (self.progressView.progress < kThirdStageBoundaryValue) {
            [self handleThirdStage];
        } else {
            [self removeTimer];
        }
    } else {
        [self handleEndStage];
    }
}

- (void)removeTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - three stage methods

// 0~0.6
- (void)handleFirstStage {
    self.progressView.progress += kFirstStageOffSet;
}

// 0.6~0.8
- (void)handleSecondStage {
    self.progressView.progress += kSecondStageOffSet;
}

// 0.8~0.95
- (void)handleThirdStage {
    self.progressView.progress += kThirdStageOffSet;
}

// x~1.0
- (void)handleEndStage {
    if (self.progressView.progress < 1.f) {
        self.progressView.progress += kEndStageOffset;
    } else {
        [self removeTimer];
        self.hidden = YES;
    }
}








@end
