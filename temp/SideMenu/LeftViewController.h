//
//  LeftViewController.h
//  LGSideMenuControllerDemo
//

#import <UIKit/UIKit.h>
#import "ChangeProfilepic_ViewController.h"

@interface LeftViewController : UITableViewController<ChangeProfilepicDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *icon_profile;
@property (strong, nonatomic) IBOutlet UILabel *lbl_UserName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_versionInfo;
@property (strong, nonatomic) IBOutlet UIImageView *bg_img;
@property (strong, nonatomic) IBOutlet UIView *view_Profile;

@end
