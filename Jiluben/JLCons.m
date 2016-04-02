//
//  JLCons.m
//  Jiluben
//
//  Created by Yue on 2/15/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLCons.h"

@implementation JLCons

+ (UIFont*)HEADER2_FONT
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
}

+ (UIFont*)TEXT_EDIT_FONT
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
}

+ (UIColor*)META_COLOR
{
    return [self colorWithRGBString:@"7c838a"];
}

+ (UIColor*)colorWithRGBString:(NSString*)rgb
{
    return [self colorWithRGBString:rgb alpha:1.0f];
}

/**
 * From Polyvore PVUtil
 */
+ (UIColor*)colorWithRGBString:(NSString*)rgb alpha:(CGFloat)alpha
{
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    if ([rgb hasPrefix:@"#"]) range.location = 1;
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:[rgb substringWithRange:range]] scanHexInt:&r];
    
    range.location += range.length;
    [[NSScanner scannerWithString:[rgb substringWithRange:range]] scanHexInt:&g];
    
    range.location += range.length;
    [[NSScanner scannerWithString:[rgb substringWithRange:range]] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

@end