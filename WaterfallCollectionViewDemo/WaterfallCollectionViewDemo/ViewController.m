//
//  ViewController.m
//  WaterfallCollectionViewDemo
//
//  Created by 闵哲 on 2017/6/30.
//  Copyright © 2017年 Gunmm. All rights reserved.
//

#import "ViewController.h"
#import "WaterfallCollectionViewLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createcollectionView];
}


- (void)createcollectionView {
    WaterfallCollectionViewLayout *layout = [[WaterfallCollectionViewLayout alloc]init];
    layout.totalWidth = 375;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"celll"];
    [self.view addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"celll" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
