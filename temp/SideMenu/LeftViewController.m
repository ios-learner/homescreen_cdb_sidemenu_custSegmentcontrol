//
//  LeftViewController.m
//  LGSideMenuControllerDemo
//

#import "LeftViewController.h"
#import "LeftViewCell.h"
#import "MainViewController.h"
#import "UIViewController+LGSideMenuController.h"
#import "ChangeProfilepic_ViewController.h"
#import "LGSideMenuController.h"
#import "UIViewController+LGSideMenuController.h"

@interface LeftViewController ()

@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) NSArray *iconsArray;


@end

@implementation LeftViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.lbl_UserName.text=@"Vishal Rajput";
    self.lbl_versionInfo.text=@"Version 6.0.0 Build 3-1-2019";
    
    self.icon_profile.frame=CGRectMake(10, self.view.frame.size.height/29.5f,  self.view.frame.size.height/10.0f,  self.view.frame.size.height/10.0f);
    
     self.icon_profile.layer.cornerRadius = self.icon_profile.frame.size.width / 2;
     self.icon_profile.clipsToBounds = YES;
    
    ///////////////////////
    [self Updatedata];
    //////////////////////
    //setting Username Label Frame
    self.lbl_UserName.frame=CGRectMake(10, self.view.frame.size.height/8.0f, self.view.frame.size.width, self.view.frame.size.height/13.0f);
    
    //setting Version Label Frame
    self.lbl_versionInfo.frame=CGRectMake(10, self.view.frame.size.height/6.5f, self.view.frame.size.width, self.view.frame.size.height/9.0f);
    
    //setting Background Image Frame
    self.bg_img.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/4.0f);
    
    //setting View Frame
    self.view_Profile.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/4.0f);


    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    
    [_icon_profile setUserInteractionEnabled:YES];
    [_icon_profile addGestureRecognizer:singleTap];
    
    
    self.titlesArray = @[
                         @"Backup Manager",
                         @"Template Manager",
                         @"Settings",
                         @"Device ID",
                         @"Help & Feedback"];
    self.iconsArray = @[
                        @"icon_backup",
                        @"icon_template",
                        @"icon_setting",
                        @"icon_device",
                        @"icon_help"];

    // -----

    
}

-(void)tapDetected{
    NSLog(@"single Tap on imageview");
    
    ChangeProfilepic_ViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController_Profilepic"];
    ViewController.caller = self;
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)])  //Method to check method Working
    {   //For Above IOS 6.0
         [self presentViewController:ViewController animated:YES completion:nil];
        
    }

}


- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   

    cell.titleLabel.text = self.titlesArray[indexPath.row];
    cell.icons.image=[UIImage imageNamed:[self.iconsArray objectAtIndex:indexPath.row]];
    
   // cell.separatorView.hidden = (indexPath.row <= 3 || indexPath.row == self.titlesArray.count-1);
   // cell.userInteractionEnabled = (indexPath.row != 1 && indexPath.row != 3);

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   // return (indexPath.row == 1 || indexPath.row == 3) ? 22.0 : 44.0;
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainViewController *mainViewController = (MainViewController *)self.sideMenuController;

    if (indexPath.row == 0) {
        if (mainViewController.isLeftViewAlwaysVisibleForCurrentOrientation) {
            [mainViewController showRightViewAnimated:YES completionHandler:nil];
        }
        else {
            [mainViewController hideLeftViewAnimated:YES completionHandler:^(void) {
                [mainViewController showRightViewAnimated:YES completionHandler:nil];
            }];
        }
    }
    else if (indexPath.row == 2) {
        UINavigationController *navigationController = (UINavigationController *)mainViewController.rootViewController;
        UIViewController *viewController;

        if ([navigationController.viewControllers.firstObject isKindOfClass:[mainViewController class]]) {
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OtherViewController"];
        }
        else {
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        }

        [navigationController setViewControllers:@[viewController]];

        // Rarely you can get some visual bugs when you change view hierarchy and toggle side views in the same iteration
        // You can use delay to avoid this and probably other unexpected visual bugs
        [mainViewController hideLeftViewAnimated:YES delay:0.0 completionHandler:nil];
    }
    else {
        UIViewController *viewController = [UIViewController new];
        viewController.view.backgroundColor = [UIColor whiteColor];
        viewController.title = self.titlesArray[indexPath.row];

        UINavigationController *navigationController = (UINavigationController *)mainViewController.rootViewController;
        [navigationController pushViewController:viewController animated:YES];

        [mainViewController hideLeftViewAnimated:YES completionHandler:nil];
    }
}

-(void)Updatedata
{
    //Checking Image Is Present In document Directory or Not
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
    
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    
    //Checking ProfileName Is Present In NSUserDefault or Not
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"profileName"];
    if(savedValue!=nil){
        self.lbl_UserName.text=savedValue;
        
    }
    else{
        self.lbl_UserName.text=@"User Name";
    }
    
    if(image!=nil){
        self.icon_profile.image=image;
        
    }
    else{
        self.icon_profile.image=[UIImage imageNamed:@"profile.jpeg"];
    }
}

@end
