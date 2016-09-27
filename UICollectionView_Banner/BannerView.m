//
//  BannerView.m
//  TestBanner
//
//  Created by 钱伟龙 on 16/9/10.
//  Copyright © 2016年 duoduo. All rights reserved.
//

#import "BannerView.h"

@interface BannerViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView * imageView;

@end

@implementation BannerViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            [self addSubview:imageView];
            imageView;
        });
    }
    return self;
}

- (void)updateCollectionViewCellWithInfo:(NSString *)info
{
    [self.imageView setImage:[UIImage imageNamed:info]];
}


@end

@interface BannerView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong,readonly) UICollectionView * bannerCollectionView;
@property (nonatomic,strong,readonly) NSMutableArray * dataArr;
@property (nonatomic,strong,readonly) UIPageControl * pageControl;

@end

@implementation BannerView

@synthesize bannerCollectionView = _bannerCollectionView;
@synthesize dataArr = _dataArr;
@synthesize pageControl = _pageControl;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self.bannerCollectionView registerClass:[BannerViewCell class] forCellWithReuseIdentifier:@"BannerViewCellIdentifier"];
    [self addSubview:self.pageControl];
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds) - 100, CGRectGetMaxY(self.bounds) - 100, 200, 40)];
        _pageControl.pageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    }
    return _pageControl;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        [_dataArr addObject:[self.imageArr lastObject]];
        [_dataArr addObjectsFromArray:self.imageArr];
        [_dataArr addObject:[self.imageArr firstObject]];
    }
    return _dataArr;
}

- (UICollectionView *)bannerCollectionView
{
    if (!_bannerCollectionView) {
        UICollectionViewFlowLayout * collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        collectionViewFlowLayout.minimumLineSpacing = 0.f;
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        collectionViewFlowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        
        _bannerCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:collectionViewFlowLayout];
        _bannerCollectionView.pagingEnabled = YES;
        _bannerCollectionView.alwaysBounceHorizontal = YES;
        _bannerCollectionView.showsHorizontalScrollIndicator = NO;
        _bannerCollectionView.delegate = self;
        _bannerCollectionView.dataSource = self;
        [self addSubview:_bannerCollectionView];
    }
    return _bannerCollectionView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bannerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    self.pageControl.numberOfPages = self.imageArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BannerViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannerViewCellIdentifier" forIndexPath:indexPath];
    [cell updateCollectionViewCellWithInfo:[self.dataArr objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.item);
    NSLog(@"点击了%@图片",[self.dataArr objectAtIndex:indexPath.row]);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    if (offSetX == 0) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.dataArr.count - 2 inSection:0];
        [self.bannerCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    else if (offSetX == scrollView.bounds.size.width * (self.dataArr.count - 1)){
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.bannerCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    double numPage = offSetX / scrollView.bounds.size.width;
    if (numPage == 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages - 1;
    }else if (numPage == self.dataArr.count - 1){
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage = numPage - 1;
    }
}















@end
