//
//  ViewController.h
//  ContactMapCoreDataAsgmt
//
//  Created by Rajesh on 19/12/15.
//  Copyright © 2015 CDAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UITextField *textName;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;

@property (strong, nonatomic) IBOutlet UITextField *textmobile;
@property (strong, nonatomic) IBOutlet UITextView *textAddress;
@property (strong, nonatomic) IBOutlet UIImageView *imagePicture;
@property (strong, nonatomic) IBOutlet UILabel *labelLocation;
- (IBAction)pickContact:(id)sender;
- (IBAction)mapController:(id)sender;
- (IBAction)gallery:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addToContacts;
- (IBAction)addContacts:(id)sender;

@property NSString *imagePath;

@property CLLocationManager *locationManager;
@end

