//
//  STViewController.m
//  CollectionTest
//
//  Created by tracy Pesin on 6/17/14.
//  Copyright (c) 2014 Songza. All rights reserved.
//

#import "STViewController.h"

@interface STViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout *layout;
@property (nonatomic) NSArray *data;

@end


@implementation STViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 10.0;
        _layout.minimumLineSpacing = 10.0;
        _layout.sectionInset = UIEdgeInsetsMake(20.0, 10.0, 20.0, 10);
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        } else {
            _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        }
        _layout.itemSize = CGSizeMake(200.0, 50.0);
    }
    return _layout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - Model

- (NSArray *)data {
    if (!_data) {
        _data = @[ @[@"r", @"r", @"r"],
                   @[@"g", @"g", @"g", @"g", @"g"],
                   @[@"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b", @"b"] ];
    }
    return  _data;
}

- (UIColor *)colorAtIndexPath:(NSIndexPath *)indexPath {
    NSString *colorId = self.data[indexPath.section][indexPath.row];
    UIColor *color;
    if ([colorId isEqualToString:@"r"]) {
        return [UIColor redColor];
    } else if ([colorId isEqualToString:@"g"]) {
        return [UIColor greenColor];
    } else {
        return [UIColor blueColor];
    }
    return color;
}

#pragma mark - CollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [self colorAtIndexPath:indexPath];
    
    return cell;
}

@end
