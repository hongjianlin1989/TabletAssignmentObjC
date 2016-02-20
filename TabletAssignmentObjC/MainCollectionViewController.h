//
//  MainCollectionViewController.h
//  TabletAssignmentObjC
//
//  Created by Yee Peng Chia on 2/19/16.
//  Copyright © 2016 Tablet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewController : UICollectionViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIImageView *myView;
@property (nonatomic,retain) NSArray * menuItems;

@property (nonatomic, strong) UIView *viewForMenu;
@property (nonatomic, strong) UITableView *viewForTable;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@property(nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (strong, nonatomic)  UIView *contentView;


-(void)setupMenuView;

-(void)showMenu:(BOOL)yesNo;

@end
