//
//  CardView.m
//  GymApp2
//
//  Created by JEEVAN TIWARI on 01/03/17.
//  Copyright © 2017 Clairvoyant. All rights reserved.
//

#import "CardView.h"

static CGFloat radius = .3;

static int shadowOffsetWidth = 0;
static int shadowOffsetHeight = 0;
static float shadowOpacity = 0.5;

@implementation CardView


-(void)layoutSubviews{
    self.layer.cornerRadius = radius;
    UIBezierPath *shadowPath = [UIBezierPath
                                bezierPathWithRoundedRect: self.bounds
                                cornerRadius: radius];
    
    
    self.layer.masksToBounds = false;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(shadowOffsetWidth, shadowOffsetHeight);
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowPath = shadowPath.CGPath;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    return [super initWithCoder:aDecoder];
}

@end
