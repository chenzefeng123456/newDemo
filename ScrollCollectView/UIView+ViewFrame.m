//
//  UIView+ViewFrame.m
//  ScrollCollectView
//
//  Created by 3014 on 16/8/25.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "UIView+ViewFrame.h"

@implementation UIView (ViewFrame)

- (void)setLeft:(CGFloat)left{
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (CGFloat)left{
    return self.frame.origin.x;
}
@end
