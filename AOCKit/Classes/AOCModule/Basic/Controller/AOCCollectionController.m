//
//  AOCCollectionController.m
//  AOCKit
//
//  Created by ssbm on 2021/4/26.
//

#import "AOCCollectionController.h"

@interface AOCCollectionController ()

@property (nonatomic, strong) UICollectionView *collectionView; // 集合视图
@end

@implementation AOCCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - Getter

// 集合视图
- (UICollectionView *)collectionView {
    if (_collectionView) return _collectionView;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    return _collectionView;
}

@end
