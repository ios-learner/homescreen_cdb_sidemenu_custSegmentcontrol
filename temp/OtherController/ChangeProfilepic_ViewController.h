//
//  ChangeProfilepic_ViewController.h
//  temp
//
//  Created by user148840 on 3/1/19.
//  Copyright © 2019 user148840. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ChangeProfilepicDelegate

-(void)Updatedata;

@end


@interface ChangeProfilepic_ViewController : UIViewController
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *img_Changeprofile_pic;
@property (strong, nonatomic) IBOutlet UITextField *txt_ProfilePicName;
@property (strong, nonatomic) UIImage *img;

- (IBAction)btn_add_profilepic:(id)sender;
- (IBAction)btn_save_profileinfo:(id)sender;

@property(nonatomic, retain) id<ChangeProfilepicDelegate> caller;

@end


