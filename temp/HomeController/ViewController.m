//
//  ViewController.m
//  cellikaDB_UISegmentView_HomeScreen
//
//  Created by user148840 on 2/25/19.
//  Copyright © 2019 user148840. All rights reserved.
//
#import "ViewController.h"

#import "LGSideMenuController.h"
#import "UIViewController+LGSideMenuController.h"
#import "LeftViewController.h"
#import "MainViewController.h"

@interface ViewController (){
  
}



@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"dataIsChanged"];
    if(savedValue!=nil)
    {
        [self.sideMenuController showLeftViewAnimated];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"dataIsChanged"];
    }
        
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.29 green:0.33 blue:0.56 alpha:1.0];
    
    self.navigationItem.title=@"Cellica DataBase1";
   self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1]};
    
    
    //segmented control tying with segmentedControlChangedValue
    
    //added by chetan sir
    CGFloat statusbar_height = [UIApplication sharedApplication].statusBarFrame.size.height;
   
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+statusbar_height,self.view.frame.size.width, 55)];
    self.segmentedControl4.sectionTitles = @[@"Forms", @"Profiles"];
    self.segmentedControl4.selectedSegmentIndex = 1;
    
    self.segmentedControl4.backgroundColor =[UIColor colorWithRed:0.29 green:0.33 blue:0.56 alpha:1.0];
    self.segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]};
    self.segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1]};
    self.segmentedControl4.selectionIndicatorColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl4.tag = 3;
    
    // self.segmentedControl4.titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:80.5]};

   
    [_segmentedControl4 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.segmentedControl4];
    
    
    //creating Button on navigation bar with image
    
    UIImage *listImage = [UIImage imageNamed:@"menu.png"];
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];

    // get the image size and apply it to the button frame
    CGRect listButtonFrame = listButton.frame;
    listButtonFrame.size = listImage.size;
    listButton.frame = listButtonFrame;
    
    [listButton setImage:listImage forState:UIControlStateNormal];
    [listButton addTarget:self
                   action:@selector(revealToggle:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *jobsButton =
    [[UIBarButtonItem alloc] initWithCustomView:listButton];
    
    self.navigationItem.leftBarButtonItem = jobsButton; //setting up navigation button
    
    // creating array for table view
    lbl_Forms = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich",@"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    lbl_Profiles = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich",@"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
   // img_Profiles = [NSMutableArray arrayWithObjects:@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png",@"b.png", nil];
    
//    UIImage *img=[UIImage imageNamed:@"ic_form"];
//    img.size.height = [NSNumber ];
   
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Place code here to perform animations during the rotation.
        // You can pass nil or leave this block empty if not necessary.
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
    {
        UIView *parent = self.view.superview;
        [self.view removeFromSuperview];
        self.view = nil; // unloads the view
        [parent addSubview:self.view]; //reloads the view from the nib
    }];
}

- (void)revealToggle:(id)sender {
    self.navigationItem.title=@"Cellica DataBase";
   [self.sideMenuController showLeftViewAnimated];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==0)
    {
        return [lbl_Forms count];
    }
    
    else
        return [lbl_Profiles count];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:simpleTableIdentifier];
        
    }
    if(_formTable.tag==1)
    {
             NSLog(@"Selected index %ld",_formTable.tag);
        cell.textLabel.text = [lbl_Forms objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=[lbl_Forms objectAtIndex:indexPath.row];
        cell.imageView.image=[UIImage imageNamed:@"ic_form.png"];
    }
    else{
          NSLog(@"Selected index2 %ld",_formTable.tag);
        cell.textLabel.text = [lbl_Profiles objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=[lbl_Profiles objectAtIndex:indexPath.row];
        cell.imageView.image= [UIImage imageNamed:@"ic_profile.png"];
        //[UIImage imageNamed:[img_Profiles objectAtIndex:indexPath.row]];
        
    }
    return cell;

}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl4 {
    if(segmentedControl4.selectedSegmentIndex==1){
          _formTable.tag = 0;
        [_formTable reloadData];
   NSLog(@"index %ld",_formTable.tag);
    }
    else{
          _formTable.tag = 1;
                [_formTable reloadData];
          NSLog(@" index2 %ld",_formTable.tag);
    }
}


@end
