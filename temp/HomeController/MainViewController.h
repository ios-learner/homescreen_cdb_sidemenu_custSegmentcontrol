//
//  MainViewController.h
//  LGSideMenuControllerDemo
//

#import "LGSideMenuController.h"

@interface MainViewController : LGSideMenuController

@property (nonatomic, assign) BOOL pic_changed;

- (void)setupWithType:(NSUInteger)type;

@end
