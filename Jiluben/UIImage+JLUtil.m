//
//  UIImage+JLUtil.m
//  Jiluben
//
//  Created by Yue on 1/18/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "UIImage+JLUtil.h"

@implementation UIImage (PVUtil)

// from http://stackoverflow.com/questions/1213790/how-to-get-a-color-image-in-iphone-sdk
+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size
{
    //Create a context of the appropriate size
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //Build a rect of appropriate size at origin 0,0
    CGRect fillRect = CGRectMake(0,0,size.width,size.height);
    
    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    
    //Fill the color
    CGContextFillRect(currentContext, fillRect);
    
    //Snap the picture and close the context
    UIImage* retval = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return retval;
}

@end