//
//  DEMainController.m
//  DEInfiniteTileMarqueeView Example
//
//  Created by Jeremy Flores on 3/27/14.
//  Copyright (c) 2014 Dream Engine Interactive, Inc. All rights reserved.
//

#import "DEMainController.h"

#import "DEInfiniteTileMarqueeView.h"

@interface DEMainController ()

@property (weak, nonatomic) IBOutlet UISwitch *mainSwitch;

@property (weak, nonatomic) IBOutlet DEInfiniteTileMarqueeView *leftMarquee;

@property (weak, nonatomic) IBOutlet DEInfiniteTileMarqueeView *rightMarquee;

@property (weak, nonatomic) IBOutlet DEInfiniteTileMarqueeView *topMarquee;

@property (weak, nonatomic) IBOutlet DEInfiniteTileMarqueeView *bottomMarquee;

@end


@implementation DEMainController

-(void)viewDidLoad {
    [super viewDidLoad];
    
   
    UIImage *leftImage = [UIImage imageNamed:@"triangle_right"];
    self.leftMarquee.tileImage = leftImage;
    self.leftMarquee.tileDuration = 0.5;
    self.leftMarquee.direction = DEInfiniteTileMarqueeViewDirectionLeftToRight;
    
    
    UIImage *rightImage = [UIImage imageWithCGImage: leftImage.CGImage
                                              scale: leftImage.scale
                                        orientation: UIImageOrientationUpMirrored];
    self.rightMarquee.tileImage = rightImage;
    self.rightMarquee.tileDuration = 0.5;
    self.rightMarquee.direction = DEInfiniteTileMarqueeViewDirectionRightToLeft;
    
    UIImage *topImage = [UIImage imageWithCGImage: leftImage.CGImage
                                              scale: leftImage.scale
                                        orientation: UIImageOrientationRight];
    self.topMarquee.tileImage = topImage;
    self.topMarquee.tileDuration = 0.5;
    self.topMarquee.direction = DEInfiniteTileMarqueeViewDirectionTopToBottom;
    
    UIImage *bottomImage = [UIImage imageWithCGImage: leftImage.CGImage
                                            scale: leftImage.scale
                                      orientation: UIImageOrientationLeft];
    self.bottomMarquee.tileImage = bottomImage;
    self.bottomMarquee.tileDuration = 0.5;
    self.bottomMarquee.direction = DEInfiniteTileMarqueeViewDirectionBottomToTop;
}

-(IBAction)switchChanged:(id)sender {
    // when we say infinite we mean infinite, so if you want to stop the marquee either hide it or remove it from its parent view.
    if (self.mainSwitch.on) {
        self.leftMarquee.hidden = NO;
        self.rightMarquee.hidden = NO;
        self.topMarquee.hidden = NO;
        self.bottomMarquee.hidden = NO;
    }
    else {
        self.leftMarquee.hidden = YES;
        self.rightMarquee.hidden = YES;
        self.topMarquee.hidden = YES;
        self.bottomMarquee.hidden = YES;
    }
}

@end
