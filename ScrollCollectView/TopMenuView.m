//
//  TopMenuView.m
//  ScrollCollectView
//
//  Created by 3014 on 16/8/25.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "TopMenuView.h"
#import "LoanMenuView.h"

#define WIDTH     [UIScreen mainScreen].bounds.size.width
#define HIDTH         [UIScreen mainScreen].bounds.size.height
@interface TopMenuView ()
@property(nonatomic,strong)LoanMenuView  *menuView;
@end
@implementation TopMenuView

- (LoanMenuView *)menuView{
    if (!_menuView) {
        UICollectionViewFlowLayout *lay = [UICollectionViewFlowLayout new];
        lay.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _menuView = [[LoanMenuView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 44) collectionViewLayout:lay];
        _menuView.backgroundColor = [UIColor clearColor];
        [self addSubview:_menuView];
    }
    return _menuView;
}

+ (void)showMenuView:(UIView *)view Source:(NSArray *)menuName{
    TopMenuView *menu = [[TopMenuView alloc] initWithFrame:CGRectMake(0, 0,WIDTH , 64)];
    menu.backgroundColor = [UIColor blueColor];
    menu.menuView.source = menuName;
    [view addSubview:menu];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
