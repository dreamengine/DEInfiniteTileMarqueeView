//
//  DEInfiniteTileMarqueeView.m
//
//  Created by Jeremy Flores on 5/8/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEInfiniteTileMarqueeView.h"

#import <QuartzCore/QuartzCore.h>

@interface DEInfiniteTileMarqueeView ()

@property (weak, nonatomic) UIView *scrollingView;
@property (strong, nonatomic) CABasicAnimation *currentScrollAnimation;

-(void) setup;

-(void) beginScrollAnimation;

@end


@implementation DEInfiniteTileMarqueeView

-(void) dealloc {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

-(id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self setup];
    }

    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];

    [self setup];
}

-(void) setup {
    // the animations will be canceled once the user leaves the app, so get a notification for when the app becomes active again so that we can restart the animation
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver: self
           selector: @selector(applicationDidBecomeActive)
               name: UIApplicationDidBecomeActiveNotification
             object: nil];

    _direction = DEInfiniteTileMarqueeViewDirectionLeftToRight;
    self.tileDuration = 1.0;
    self.currentScrollAnimation = nil;

    self.clipsToBounds = YES;

    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = self.frame.size.width*2;
    frame.size.height = self.frame.size.height;

    UIView *scrollingView = [[UIView alloc] initWithFrame:frame];
    scrollingView.opaque = NO;
    scrollingView.backgroundColor = [UIColor clearColor];

    self.scrollingView = scrollingView;

    [self addSubview:self.scrollingView];

    [self beginScrollAnimation];
}

-(void)applicationDidBecomeActive {
    [self beginScrollAnimation];
}

-(void) setTileImage:(UIImage *)tileImage {
    if (![_tileImage isEqual:tileImage]) {
        _tileImage = tileImage;
        self.scrollingView.backgroundColor = [UIColor colorWithPatternImage:tileImage];
    }
}

-(void) setDirection:(DEInfiniteTileMarqueeViewDirection)direction {
    if (_direction != direction) {
        _direction = direction;

        [self beginScrollAnimation];        
    }
}

-(void) beginScrollAnimation {
    self.currentScrollAnimation = nil;
    [self.scrollingView.layer removeAllAnimations];
    [self _animateScroll];
}

-(void) setHidden:(BOOL)hidden {
    BOOL previousHiddenState = [self isHidden];
    [super setHidden:hidden];

    // if we actually transitioned to a new hidden/unhidden state
    if (previousHiddenState != hidden) {
        if (hidden) {
            self.currentScrollAnimation = nil;
            [self.scrollingView.layer removeAllAnimations];
        }
        else {
            [self beginScrollAnimation];
        }
    }
}

-(void) _animateScroll {
    CGRect frame = self.scrollingView.frame;

    float fromValue = 0.f;
    float toValue = 0.f;
    if (self.direction == DEInfiniteTileMarqueeViewDirectionLeftToRight) {
        fromValue = -frame.size.width/2;
        toValue = 0.f;
    }
    else if (self.direction == DEInfiniteTileMarqueeViewDirectionRightToLeft) {
        fromValue = 0.f;
        toValue = -frame.size.width/2;
    }

    frame = self.scrollingView.frame;
    frame.origin.x = fromValue;
    self.scrollingView.frame = frame;
    
    int tileUnits = self.frame.size.width/self.tileImage.size.width;

    [UIView animateWithDuration: self.tileDuration*tileUnits
                          delay: 0.f
                        options: UIViewAnimationOptionCurveLinear
                     animations:
     ^{
         CGRect frame = self.scrollingView.frame;
         frame.origin.x = toValue;
         self.scrollingView.frame = frame;
     }
                     completion:
     ^(BOOL finished) {
         if (finished) {
             [self _animateScroll];
         }
     }];
}

-(void) animationDidStop:(CAAnimation *)animation finished:(BOOL)didFinish {
    if ([animation isEqual:self.currentScrollAnimation]) {
        [self _animateScroll];
    }
}

@end
