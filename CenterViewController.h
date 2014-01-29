//
//  CenterViewController.h
//  Perehvat
//
//  Created by Admin on 29.01.14.
//  Copyright (c) 2014 Alex Kardash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CenterViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property BOOL newMedia;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
- (IBAction)save:(id)sender;
- (IBAction)infoButtonClick:(id)sender;

//hide keyboard
-(IBAction)textFieldReturn:(id)sender;

@end
	