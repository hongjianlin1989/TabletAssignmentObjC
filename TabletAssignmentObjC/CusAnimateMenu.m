//
//  CusAnimateMenu.m
//  TabletAssignmentObjC
//
//  Created by hongjian lin on 2/20/16.
//  Copyright © 2016 Tablet. All rights reserved.
//

#import "CusAnimateMenu.h"
#define SCREEN_WIDTH_RATIO ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)/320
@interface CusAnimateMenu ()
{
    BOOL showMenu;
    BOOL zoomIn;
}
@end
@implementation CusAnimateMenu

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void) buildMenu
{
    self.menuItems = @[@"Menu Item 1", @"Menu Item 2", @"Menu Item 3", @"Menu Item 4"];
  //  self.hidden=true;
    self.alpha=0;
    [self addBlurView];
    [self addScropeView];
    self.backgroundColor= [UIColor clearColor];
}

- (void) addBlurView
{
    self.BlurView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.BlurView.backgroundColor=[UIColor blackColor];
    self.BlurView.alpha=0.6;
    [self addSubview:self.BlurView];
}

-(void) resetScorllView
{
    self.scrollView.maximumZoomScale = 1.6f;
    self.scrollView.minimumZoomScale= 0.4f;
    self.scrollView.zoomScale = 1;
    self.scrollView.delegate = self;
   // self.scrollView.hidden=true;
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
  //  self.scrollView.backgroundColor=[UIColor blueColor];
    [self centerScrollViewContents];
}

-(void) addScropeView
{
    
    if(self.scrollView == nil){
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 55*SCREEN_WIDTH_RATIO, self.frame.size.width, self.frame.size.height)];
        
        [self setupMenuView];
        [self resetScorllView];
        
        _contentView=[[UIView alloc] initWithFrame:CGRectMake(0,0,320*SCREEN_WIDTH_RATIO,568*SCREEN_WIDTH_RATIO)];
        
        [_contentView addSubview:self.viewForMenu];
        [_scrollView addSubview:_contentView];
        _scrollView.contentSize = _contentView.frame.size;
        [self addSubview:self.scrollView];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewOneFingerDragged:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [self.viewForMenu addGestureRecognizer:panRecognizer];
        
    }
    
}


- (void)scrollViewOneFingerDragged:(UIPanGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    
    CGPoint velocity = [recognizer velocityInView:_contentView];
    
    if(velocity.y > 0&&velocity.x<0)
    {
        CGFloat newZoomScale = (1+ velocity.y/15000)*self.scrollView.zoomScale ;
        zoomIn=true;
        [self.scrollView setZoomScale:newZoomScale animated:YES];
    }
    else if(velocity.y < 0&&velocity.x>0)
    {
        CGFloat newZoomScale = (1+ velocity.y/15000)*self.scrollView.zoomScale ;
        zoomIn=false;
        if (newZoomScale<=0.40) {
            showMenu=false;
            [self showMenu:showMenu];
        }else
        {
            [self.scrollView setZoomScale:newZoomScale animated:YES];
        }
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded:
            [self.scrollView setZoomScale:1 animated:YES];
            break;
            
        default:
            break;
    }
    
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.contentView.frame;
    
    if ((contentsFrame.size.width > boundsSize.width) && zoomIn==true) {
        self.scrollView.contentOffset= CGPointMake(contentsFrame.size.width-boundsSize.width, 0);
    }else if ((contentsFrame.size.width < boundsSize.width) && zoomIn==false)
    {
        self.scrollView.contentOffset= CGPointMake(-ABS(contentsFrame.size.width-boundsSize.width), 0);
        
    }else if ((contentsFrame.size.width < boundsSize.width) && zoomIn==true)
    {
        self.scrollView.contentOffset= CGPointMake(-ABS(boundsSize.width-contentsFrame.size.width), 0);
    }
    
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.contentView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}


-(void)setupMenuView{
    self.viewForMenu = [[UIView alloc] initWithFrame:CGRectMake(300.0*SCREEN_WIDTH_RATIO,0,0,0)];
    self.viewForMenu.backgroundColor = [UIColor clearColor];
    self.viewForTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,320*SCREEN_WIDTH_RATIO,200*SCREEN_WIDTH_RATIO )
                                                     style:UITableViewStylePlain];
    
    self.viewForTable.backgroundColor = [UIColor whiteColor];
    self.viewForTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.viewForTable.alpha = 1.0;
    self.viewForTable.tableFooterView = [UIView new];
    self.viewForTable.scrollEnabled=false;
    self.viewForTable.delegate = self;
    self.viewForTable.dataSource = self;
    self.viewForTable.layer.cornerRadius=3;
    self.viewForMenu.clipsToBounds=YES;
    
    [self.viewForMenu addSubview:self.viewForTable];
    
}


-(void)showMenu:(BOOL)yesNo{
    showMenu=yesNo;
    CGRect regularFrame;
    
    if (showMenu) {
      //  self.scrollView.alpha= 1;
        self.alpha=1;
    //    self.scrollView.hidden=false;
   //     self.hidden=false;
        regularFrame=CGRectMake(0, 0,320*SCREEN_WIDTH_RATIO,200*SCREEN_WIDTH_RATIO );
    }else
    {
        regularFrame=CGRectMake(300.0*SCREEN_WIDTH_RATIO,0,0,0 );
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.viewForMenu.frame=regularFrame;
        self.viewForTable.frame=self.viewForMenu.bounds;
        if (showMenu==true) {
            zoomIn=true;
            [self.scrollView setZoomScale:1.03 animated:YES];
        }
    }completion:^(BOOL finished){
        if (showMenu==false) {
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
              //  self.scrollView.alpha= 0;
                self.alpha=0;
            }completion:^(BOOL finished){
                
            }];
        }else{
            zoomIn=false;
            [self.scrollView setZoomScale:1 animated:YES];
        }
    }];
    
}

#pragma mark - UITableView Delegate and Datasource method implementation

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSString *menuOptionText = self.menuItems[indexPath.row];
    cell.textLabel.text = menuOptionText;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Futura" size:15.0];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
}



@end
