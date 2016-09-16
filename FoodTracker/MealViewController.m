//
//  MealViewController.m
//  FoodTracker
//
//  Created by Tomás Garrido Sandino on 12/9/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import "MealViewController.h"
#import "RatingControl.h"
#import "NSString+NSStringUtilities.h"

@interface MealViewController ()

#pragma mark Properties
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet RatingControl *ratingControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation MealViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Handle the text field’s user input through delegate callbacks.
    self.nameTextField.delegate = self;
    
    // Enable the Save button only if the text field has a valid Meal name.
    [self checkValidMealName];
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
    [self checkValidMealName];
    self.navigationItem.title = textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // Disable the Save button while editing.
    self.saveButton.enabled = false;
}

- (void) checkValidMealName {
    NSString * text = [NSString stringByNilCoalesce:self.nameTextField.text];
    self.saveButton.enabled = ![text isBlank];
}

#pragma mark Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (self.saveButton == sender) {
        NSString *name = self.nameTextField.text ? self.nameTextField.text : @"";
        UIImage *photo = self.photoImageView.image;
        NSInteger rating = self.ratingControl.rating;
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        self.meal = [[Meal alloc] init:name photo:photo rating:rating];

    }
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
