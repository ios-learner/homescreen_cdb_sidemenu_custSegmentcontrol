//
//  LeftViewCell.h
//  LGSideMenuControllerDemo
//

#import <UIKit/UIKit.h>

@interface LeftViewCell : UITableViewCell

@property (assign, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign, nonatomic) IBOutlet UIView *separatorView;
@property (strong, nonatomic) IBOutlet UIImageView *icons;

@end
