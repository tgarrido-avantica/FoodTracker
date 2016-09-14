//
//  MealViewController.m
//  FoodTracker
//
//  Created by Tomás Garrido Sandino on 12/9/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import "MealViewController.h"
#import "RatingControl.h"

@interface MealViewController ()

#pragma mark Properties
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet RatingControl *ratingControl;

@end

@implementation MealViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITExtFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Hide the keyword.
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark Actions

- (IBAction)selectImageFromPhotoLibrary:(UITapGestureRecognizer *)sender
{
    // Hide the keyboard.
    [self.nameTextField resignFirstResponder];
    
    // UIImagePickerController is a view controller that lets a user pick media from their photo library.
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    
    // Only allow photos to be picked, not taken.
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    // Make sure ViewController is notified when the user picks an image.
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // Dismiss the picker if the user canceled.
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    // The info dictionary contains multiple representations of the image, and this uses the original.
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    
    // Set photoImageView to display the selected image.
    self.photoImageView.image = selectedImage;
    
    // Dismiss the picker.
    [self dismissViewControllerAnimated:YES completion: nil];

}


@end
