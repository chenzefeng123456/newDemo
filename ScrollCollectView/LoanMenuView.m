//
//  LoanMenuView.m
//  ScrollCollectView
//
//  Created by 3014 on 16/8/25.
//  Copyright © 2016年 3014. All rights reserved.
//
#define ItemWidth  50
#define ItemHeight 30
#define InsetsGap  10
#define MiddleGap  10


#import "LoanMenuView.h"
#import "LoanMenuCell.h"
#import "UIView+ViewFrame.h"
@interface LoanMenuView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UIView *shadow;
@end
@implementation LoanMenuView

- (UIView *)shadow{
    if (!_shadow) {
        _shadow = [[UIView alloc] initWithFrame:CGRectMake(InsetsGap, 35, 50, 2)];
        _shadow.backgroundColor = [UIColor redColor];
        [self addSubview:_shadow];
    }
    return _shadow;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        UINib *nib = [UINib nibWithNibName:@"LoanMenuCell" bundle:nil];
        [self registerNib:nib forCellWithReuseIdentifier:@"LoanMenuCell"];
        [self insertSubview:self.shadow aboveSubview:self.subviews.lastObject];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveScrollItemNotification:) name:LoanScrollContentNotification object:nil];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.source.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LoanMenuCell";
    LoanMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.source[indexPath.row];
    return cell;
                                                                                                                              
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self scrollSelectView:indexPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:LoanSelectItemNotification object:indexPath];
}
- (void)receiveScrollItemNotification:(NSNotificationCenter *)center{
    [self scrollSelectView:[center valueForKey:@"object"]];
}

- (void)scrollSelectView:(NSIndexPath *)path{
    LoanMenuCell *cell = (LoanMenuCell *)[self cellForItemAtIndexPath:path];
    if ((cell.frame.origin.x + InsetsGap + ItemWidth)-self.contentOffset.x >= self.frame.size.width) {
        CGRect rect = CGRectMake(cell.frame.origin.x +InsetsGap+MiddleGap, 35, cell.frame.size.width,cell.frame.size.height );
        [self scrollRectToVisible:rect animated:YES];
        
    }else if ((cell.frame.origin.x - InsetsGap - ItemWidth)-self.contentOffset.x <= 0){
        CGRect rect = CGRectMake(cell.frame.origin.x - InsetsGap, 35, cell.frame.size.width, cell.frame.size.height);
        [self scrollRectToVisible:rect animated:YES];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.shadow.left = cell.left;
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
