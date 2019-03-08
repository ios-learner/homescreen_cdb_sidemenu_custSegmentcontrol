//
//  MainViewController.m
//  LGSideMenuControllerDemo
//

#import "MainViewController.h"
#import "LeftViewController.h"


@interface MainViewController ()

@property (assign, nonatomic) NSUInteger type;

@end

@implementation MainViewController

- (void)setupWithType:(NSUInteger)type {
    self.type = type;

    // -----

    if (self.storyboard) {
        // Left and Right view controllers is set in storyboard
        // Use custom segues with class "LGSideMenuSegue" and identifiers "left" and "right"

        // Sizes and styles is set in storybord
        // You can also find there all other properties

        // LGSideMenuController fully customizable from storyboard
        
        self.leftViewController = [LeftViewController new];
        self.leftViewWidth = 250.0;
        //    self.leftViewBackgroundImage = [UIImage imageNamed:@"imageLeft"];
        self.leftViewBackgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.95];
        self.rootViewCoverColorForLeftView = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.05];
    }
    else {
        self.leftViewController = [LeftViewController new];
        self.leftViewWidth = 250.0;
    //    self.leftViewBackgroundImage = [UIImage imageNamed:@"imageLeft"];
        self.leftViewBackgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.95];
        self.rootViewCoverColorForLeftView = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.05];

    }

    // -----

    UIColor *greenCoverColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.8 alpha:0.3];
   // UIColor *purpleCoverColor = [UIColor colorWithRed:0.1 green:0.0 blue:0.1 alpha:0.3];
    UIBlurEffectStyle regularStyle;

    if (UIDevice.currentDevice.systemVersion.floatValue >= 10.0) {
        regularStyle = UIBlurEffectStyleRegular;
    }
    else {
        regularStyle = UIBlurEffectStyleLight;
    }

    // -----

    
            self.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideAbove;
            self.rootViewCoverColorForLeftView = greenCoverColor;
    
    
    
}
- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super leftViewWillLayoutSubviewsWithSize:size];

    if (!self.isLeftViewStatusBarHidden) {
        self.leftView.frame = CGRectMake(0.0, 20.0, size.width, size.height-20.0);
    }
}

- (BOOL)isLeftViewStatusBarHidden {
    if (self.type == 8) {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    }

    return super.isLeftViewStatusBarHidden;
}

- (void)dealloc {
    NSLog(@"MainViewController deallocated");
}


@end
