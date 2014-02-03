//
//  CenterViewController.m
//  Perehvat
//
//  Created by Admin on 29.01.14.
//  Copyright (c) 2014 Alex Kardash. All rights reserved.
//

#import "CenterViewController.h"	

@interface CenterViewController ()

@end

@implementation CenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _violations = @[@"Автохлам", @"Вокзал",
                    @"Светофор", @"Перехват", @"Стакан", @"Стоп-Вандал", @"Утеря"];
    _violationDescriptions = @[@"оставленные, неэксплуатируемых транспортных средствах",
                               @"происшествия на объектах транспортной системы",
                               @"неработающие светофоры и поломанные дорожные знаки",
                               @"информации, не предусмотренной ни одной из предложенных операций",
                               @"распития спиртных напитков в неустановленных местах",
                               @"все виды вандализма",
                               @"найденные/потерянные вещи, пропавшие без вести и т.д."];
    [self.picker selectRow:3 inComponent:0 animated:NO];
    [self pickerView:_picker didSelectRow:3 inComponent:0];
    _deleteImageButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.75];
    _deleteImageButton.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)useCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        _newMedia = YES;
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Device has no camera"
                              message: nil
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction)useCameraRoll:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker  animated:YES completion:nil];
        _newMedia = NO;
    }
}

- (IBAction)deleteImage:(id)sender {
    _imageView.image = nil;
    _deleteImageButton.hidden = YES;
    [self pickerView:_picker didSelectRow:[_picker selectedRowInComponent:0] inComponent:0];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        _imageView.image = image;
        _violationsTextView.text = nil;
        _deleteImageButton.hidden = NO;
        
    if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }

}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
}

- (IBAction)infoButtonClick:(id)sender {

}

//hide keyboard
-(IBAction)textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([_addressTextField isFirstResponder] && [touch view] != _addressTextField) {
        [_addressTextField resignFirstResponder];
    } else if ([_nameTextField isFirstResponder] && [touch view] != _nameTextField) {
        [_nameTextField resignFirstResponder];
    } else if ([_commentTextField isFirstResponder] && [touch view] != _commentTextField) {
        [_commentTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _violations.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _violations[row];
} 

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (_imageView.image == nil) {
        NSString *resultString = [[NSString alloc] initWithFormat: @"%@", _violationDescriptions[row]];
        _violationsTextView.text = resultString;
        [_violationsTextView setFont:[UIFont systemFontOfSize:15]];
    }
    
}

@end
