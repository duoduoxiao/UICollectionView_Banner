//
//  ViewController.m
//  UICollectionView_Banner
//
//  Created by 钱伟龙 on 2016/9/27.
//  Copyright © 2016年 duoduo. All rights reserved.
//

#import "ViewController.h"
#import "BannerView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BannerView * view = [[BannerView alloc] initWithFrame:self.view.bounds];
    NSArray * arr = @[@"ed_user_guide1@middle",@"ed_user_guide2@middle",@"ed_user_guide3@middle",@"ed_user_guide4@middle"];
    view.imageArr = arr;
    [self.view addSubview:view];
}


@end
