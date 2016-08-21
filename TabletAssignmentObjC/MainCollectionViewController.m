//
//  MainCollectionViewController.m
//  TabletAssignmentObjC
//
//  Created by Yee Peng Chia on 2/19/16.
//  Copyright © 2016 Tablet. All rights reserved.
//

#import "MainCollectionViewController.h"
#import "MyCollectionViewCell.h"


@interface MainCollectionViewController ()
{
    BOOL showMenu;
    
}
@end

@implementation MainCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"hello world");
    
    UIImage *dotsImage = [UIImage imageNamed:@"dots"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:dotsImage
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(barButtonTapped:)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    [self BuildMenu];
}

- (void) BuildMenu
{
    self.menu= [[CusAnimateMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.menu.delegate=self;
    [self.menu buildMenu];
    [self.view addSubview:self.menu];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Implementation

- (void)barButtonTapped:(id)sender {
    showMenu=!showMenu;
    [self.menu showMenu:showMenu];
}

#pragma mark - CusAnimateMenuDelegate
- (NSArray *) SetsOfElementNeedForCusAnimateMenuDelegate
{
    return @[@"Menu Item 1", @"Menu Item 2", @"Menu Item 3", @"Menu Item 4"];
}
- (void) MenuDidClosed:(BOOL) menuShow
{
    showMenu=menuShow;
}
- (void) MenuItemDidSelected:(NSIndexPath *)indexPath
{
    NSLog(@"Selected");
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"photo_%lu", indexPath.row];
    UIImage *image = [UIImage imageNamed:imageName];
    [cell.imageView setImage:image];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    return CGSizeMake(bounds.size.width, bounds.size.width);
}


@end
