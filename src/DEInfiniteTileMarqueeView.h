//
//  DEInfiniteTileMarqueeView.h
//
//  Created by Jeremy Flores on 5/8/13.
//  Copyright (c) 2013 Dream Engine Interactive, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum DEInfiniteTileMarqueeViewDirection {
    DEInfiniteTileMarqueeViewDirectionUnset,
    DEInfiniteTileMarqueeViewDirectionLeftToRight,
    DEInfiniteTileMarqueeViewDirectionRightToLeft,
    DEInfiniteTileMarqueeViewDirectionTopToBottom,
    DEInfiniteTileMarqueeViewDirectionBottomToTop
} DEInfiniteTileMarqueeViewDirection;


@interface DEInfiniteTileMarqueeView : UIView

/*
 
 NB: Your marquee views should be integer multiples of your tileImage's width. E.g. if your tileImage has a width of 25pt, your marquee view should be 25pt, 50pt, 75pt, 100pt, etc.
 
 */

/*
 
 The direction in which the marquee should scroll.
 
 Default is DEInfiniteTileMarqueeViewDirectionLeftToRight.
 
 */
@property (nonatomic) DEInfiniteTileMarqueeViewDirection direction;

/*
 
 How long it takes for a tile to move a tileWidth distance. E.g. for a tile with 20pt width and a tileDuration of 2.0, it will take that tile 2 seconds to move from 0pt to 20pt.
 
 Default is 1.0.
 
 */
@property (nonatomic) NSTimeInterval tileDuration;

/*
 
 The image that should be tiled. If a dynamic view should be tiled, you could first render that view to a UIImage (screenshot) and provide that image to the marquee view.
 
 Default is nil.
 
 */
@property (strong, nonatomic) UIImage *tileImage;

@end
