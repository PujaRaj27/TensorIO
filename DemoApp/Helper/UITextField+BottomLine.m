//
//  UITextField+BottomLine.m
//  DemoApp
//
//  Created by Kumar Anand on 22/09/23.
//

#import <Foundation/Foundation.h>
#import "UITextField+BottomLine.h"

@implementation UITextField (BottomLine)

- (void)addBottomLine {
    CALayer *bottomLine = [CALayer layer];
    bottomLine.frame = CGRectMake(0.0, self.frame.size.height - 1, self.frame.size.width, 1.0);
    bottomLine.backgroundColor = [UIColor blackColor].CGColor;
    self.borderStyle = UITextBorderStyleNone;
    [self.layer addSublayer:bottomLine];
}




@end
