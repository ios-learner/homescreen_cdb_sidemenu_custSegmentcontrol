
#import "ChangeProfilepic_ViewController.h"
#import "LeftViewController.h"
#import "MainViewController.h"


@interface ChangeProfilepic_ViewController ()

@end

@implementation ChangeProfilepic_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Creating Document Directory & Adding Image in it
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
    
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];

    //Chaeking image is present in document directory if not setting up Default image
    if(image!=nil)
        self.img_Changeprofile_pic.image=image;
    else
        self.img_Changeprofile_pic.image=[UIImage imageNamed:@"profile.jpeg"];
    
    //Adding UserName Value (in NSUserDefaults)
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"profileName"];
    //Chaeking UserName is present in NSUserDeafilt if not setting up Default Name
    
    if(savedValue!=nil)
        self.txt_ProfilePicName.text=savedValue;
    else
        self.txt_ProfilePicName.text=@"User Name";
    
    //Adjusting UIImage View Frame
    CGFloat statusbar_height = [UIApplication sharedApplication].statusBarFrame.size.height;
    
     //Adjusting Profile Pic (UIImageView) Frame
    self.img_Changeprofile_pic.frame=CGRectMake(0, self.navigationController.navigationBar.frame.size.height+statusbar_height+30, self.view.frame.size.width, self.view.frame.size.height/3.0f) ;
    
    //Adjusting Profile NAme(UITextView) View Frame
    self.txt_ProfilePicName.frame = CGRectMake(self.img_Changeprofile_pic.frame.size.width/9, self.img_Changeprofile_pic.frame.size.height, self.img_Changeprofile_pic.frame.size.width/1.3f, 30) ;
}

- (IBAction)btn_add_profilepic:(id)sender {
    //UIImage Picker Control
    UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
    pickerView.allowsEditing = YES;
    pickerView.delegate = self;
    [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerView animated:YES completion:nil];

}

- (IBAction)btn_save_profileinfo:(id)sender {
 
    // storing image into document directory
    
    NSData *pngData = UIImagePNGRepresentation(_img);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file

    
    NSString *valueToSave = self.txt_ProfilePicName.text;

    if(_img!=nil || valueToSave!=nil ){
        //Storing DataISChanged Or Not For Reload SideMenu
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"dataIsChanged"];
    
        //Storing ProfileName In NSUserDefault
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"profileName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.caller Updatedata];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _img = [info valueForKey:UIImagePickerControllerEditedImage];
    
    _img_Changeprofile_pic.image = _img;

}
@end
