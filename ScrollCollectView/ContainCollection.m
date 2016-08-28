//
//  ContainCollection.m
//  ScrollCollectView
//
//  Created by 3014 on 16/8/26.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "ContainCollection.h"
#import "ContainCollectionViewCell.h"
@interface ContainCollection ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ContainCollection
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"ContainCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([ContainCollectionViewCell class])];
        self.backgroundColor = [UIColor clearColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ScrollViewItem:) name:LoanSelectItemNotification object:nil];
    }
    return self;
}

- (void)ScrollViewItem:(NSNotificationCenter *)center{
    [self scrollToItemAtIndexPath:[center valueForKey:@"object"] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return  self.source.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ContainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ContainCollectionViewCell class]) forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *contrller = self.source[indexPath.row];
    contrller.view.frame = cell.frame;
    [cell.contentView addSubview:contrller.view];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width, self.frame.size.height-64);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x;
    NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:LoanScrollContentNotification object:path];
}

@end
