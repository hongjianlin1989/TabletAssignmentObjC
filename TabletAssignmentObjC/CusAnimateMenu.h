//
//  CusAnimateMenu.h
//  TabletAssignmentObjC
//
//  Created by hongjian lin on 2/20/16.
//  Copyright © 2016 Tablet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusAnimateMenu : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray * menuItems;
@property (nonatomic, strong) UIView *viewForMenu;
@property (nonatomic, strong) UITableView *viewForTable;


@property (nonatomic, strong) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *BlurView;
@property (strong, nonatomic) UIView *contentView;

-(void) setupMenuView;
-(void) showMenu:(BOOL)yesNo;
-(void) buildMenu;

@end
