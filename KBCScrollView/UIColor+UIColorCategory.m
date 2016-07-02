//
//  UIColor+UIColorCategory.m
//
//  Created by Konstantin Blokhin on 25.02.14.
//  Copyright (c) 2014 Konstantin Blokhin. All rights reserved.
//

#import "UIColor+UIColorCategory.h"

@implementation UIColor (UIColorCategory)

+(UIColor*) randomColor {
    UIColor* colorForReturn = nil;
    int randomColorNum = arc4random_uniform(13);
    switch (randomColorNum) {
        case 0:
            colorForReturn = [UIColor blackColor];
            break;
        case 1:
            colorForReturn = [UIColor darkGrayColor];
            break;
        case 2:
            colorForReturn = [UIColor lightGrayColor];
            break;
        case 3:
            colorForReturn = [UIColor grayColor];
            break;
        case 4:
            colorForReturn = [UIColor redColor];
            break;
        case 5:
            colorForReturn = [UIColor greenColor];
            break;
        case 6:
            colorForReturn = [UIColor blueColor];
            break;
        case 7:
            colorForReturn = [UIColor cyanColor];
            break;
        case 8:
            colorForReturn = [UIColor yellowColor];
            break;
        case 9:
            colorForReturn = [UIColor magentaColor];
            break;
        case 10:
            colorForReturn = [UIColor orangeColor];
            break;
        case 11:
            colorForReturn = [UIColor purpleColor];
            break;
        case 12:
            colorForReturn = [UIColor brownColor];
            break;
            
        default:
            colorForReturn = [UIColor greenColor];
            break;
    }
    
    return colorForReturn;
}

@end
