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

@end


@implementation DEMainController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftMarquee.direction = DEInfiniteTileMarqueeViewDirectionLeftToRight;
    UIImage *leftImage = [UIImage imageNamed:@"triangle_right"];
    self.leftMarquee.tileImage = leftImage;
    self.leftMarquee.tileDuration = 0.5;
    
    
    self.rightMarquee.direction = DEInfiniteTileMarqueeViewDirectionRightToLeft;
    UIImage *rightImage = [UIImage imageWithCGImage: leftImage.CGImage
                                              scale: leftImage.scale
                                        orientation: UIImageOrientationUpMirrored];
    self.rightMarquee.tileImage = rightImage;
    self.rightMarquee.tileDuration = 0.5;
}

-(IBAction)switchChanged:(id)sender {
    // when we say infinite we mean infinite, so if you want to stop the marquee either hide it or remove it from its parent view.
    if (self.mainSwitch.on) {
        self.leftMarquee.hidden = NO;
        self.rightMarquee.hidden = NO;
    }
    else {
        self.leftMarquee.hidden = YES;
        self.rightMarquee.hidden = YES;
    }
}

@end
