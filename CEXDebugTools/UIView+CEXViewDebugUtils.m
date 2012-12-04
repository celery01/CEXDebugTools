//
//  UIView+CEXViewDebugUtils.m
//  CEXDebugTools
//
//  Created by Yi Lin on 12/5/12.
//  Copyright (c) 2012 Yi Lin. All rights reserved.
//

#import "UIView+CEXViewDebugUtils.h"
#import <QuartzCore/QuartzCore.h>

NSString *CEXViewDebugUtilsPositionTextLayerName = @"CEXViewDebugUtilsPositionTextLayerName";

@implementation UIView (CEXViewDebugUtils)

- (void)showVisualFrameInfo
{
    self.layer.borderWidth = 1;
    
    self.layer.borderColor = [UIColor colorWithRed:((arc4random() % 256) / 255.f)
                                             green:((arc4random() % 256) / 255.f)
                                              blue:((arc4random() % 256) / 255.f)
                                             alpha:1].CGColor;
    
    NSString *displayString = NSStringFromCGRect(self.frame);
    CGSize stringSize = [displayString sizeWithFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
    
    CATextLayer * textLayer = [CATextLayer layer];
    textLayer.name = CEXViewDebugUtilsPositionTextLayerName;
    textLayer.string = displayString;
    textLayer.fontSize = [UIFont smallSystemFontSize];
    textLayer.foregroundColor = [UIColor colorWithRed:((arc4random() % 256) / 255.f)
                                                green:((arc4random() % 256) / 255.f)
                                                 blue:((arc4random() % 256) / 255.f)
                                                alpha:1].CGColor;
    
    CGRect textLayerBounds = CGRectZero;
    textLayerBounds.size = stringSize;
    textLayerBounds = CGRectInset(textLayerBounds, -5, -5);
    textLayer.bounds = textLayerBounds;
    textLayer.position = CGPointMake(CGRectGetMaxX(self.bounds) - CGRectGetMidX(textLayerBounds),
                                     -CGRectGetMidY(textLayerBounds));
    
    
    NSArray *sublayers = self.layer.sublayers;
    CALayer *inTextLayer = nil;
    for(CALayer *layer in sublayers) {
        if([layer.name isEqualToString:CEXViewDebugUtilsPositionTextLayerName]) {
            inTextLayer = layer;
            break;
        }
        
    }
    
    if(inTextLayer) {
        [self.layer replaceSublayer:inTextLayer with:textLayer];
    }
    else
        [self.layer addSublayer:textLayer];
    
    
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
}

@end
