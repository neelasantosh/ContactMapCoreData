//
//  ViewController.m
//  ContactMapCoreDataAsgmt
//
//  Created by Rajesh on 19/12/15.
//  Copyright © 2015 CDAC. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize textAddress,textEmail,textmobile,textName,labelLocation,imagePicture,imagePath,locationManager;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //initialize image path
    NSArray *pathArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    
    imagePath=[NSString stringWithFormat:@"%@/profile.png",[pathArray objectAtIndex:0]];
    
    //show the image stored in App's documents folder after loading of the app
   // imagePicture.image=[UIImage imageWithContentsOfFile:imagePath];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //get latest/last object from location array
    CLLocation *loc = [locations lastObject];
    CLLocationCoordinate2D locCordinate = loc.coordinate;
    labelLocation.text = [NSString stringWithFormat:@"%f,%f",locCordinate.latitude,locCordinate.longitude];
    
}



- (IBAction)pickContact:(id)sender {
    
    ABPeoplePickerNavigationController *peoplePickerCon = [[ABPeoplePickerNavigationController alloc]init];
    
    peoplePickerCon.peoplePickerDelegate = self;
    [self presentViewController:peoplePickerCon animated:true completion:nil];
}

-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSLog(@"The Contact:%@",person);
    [peoplePicker dismissViewControllerAnimated:true completion:nil];
    
    //get first name from person record
    // CFTypeRef v = ABRecordCopyValue(<#ABRecordRef record#>, <#ABPropertyID property#>)
    
    CFTypeRef cftypeFName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    //convert core foundation type into NSString
    NSString *fname = (__bridge_transfer NSString *) cftypeFName;
    
    NSString *lastname = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    textName.text=[NSString stringWithFormat:@"%@ %@",fname,lastname];
    
    //get multiple values like mobile or email from person record
    ABMultiValueRef phoneRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    //get one phone at time from multivalue type
    long count = ABMultiValueGetCount(phoneRef);
    for (int i=0; i<count; i++)
    {
        CFTypeRef cfTypePhone = ABMultiValueCopyValueAtIndex(phoneRef, i);
        NSString *phone = (__bridge_transfer NSString *)cfTypePhone;
        textmobile.text = phone;
        
        NSLog(@"%d, %@",i,phone);
    }
    ABMultiValueRef emailRef = ABRecordCopyValue(person, kABPersonEmailProperty);
    //get one phone at time from multivalue type
    long count1 = ABMultiValueGetCount(emailRef);
    for (int i=0; i<count1; i++)
    {
        CFTypeRef cfTypeEmail = ABMultiValueCopyValueAtIndex(emailRef, i);
        NSString *email = (__bridge_transfer NSString *)cfTypeEmail;
        textEmail.text = email;
        
        NSLog(@"%d, %@",i,email);
    }
}


- (IBAction)mapController:(id)sender {
    
   
    
}

- (IBAction)gallery:(id)sender {
    
    UIImagePickerController *imageCon=[[UIImagePickerController alloc]init];
    
    //set gallery as image src
    imageCon.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //set delegate
    imageCon.delegate = self;
    imageCon.allowsEditing = true;
    
    //show the controller
    [self presentViewController:imageCon animated:true completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImage=[info objectForKey:UIImagePickerControllerEditedImage]; //info is object of Dictionary here
    
    imagePicture.image = pickedImage;
    
    //close image picker controller
    [picker dismissViewControllerAnimated:true completion:nil];
    
    //save picked image at image path
    NSData *imageData=UIImagePNGRepresentation(pickedImage);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager createFileAtPath:imagePath contents:imageData attributes:nil];
    
    NSLog(@"Image Path:%@",imagePath);
}


- (IBAction)addContacts:(id)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *objContext = [appDelegate managedObjectContext];
    
    //create a new empty entity for student in object context
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Mycontacts" inManagedObjectContext:objContext];
    
    
    NSNumber *mobile=[NSNumber numberWithInt:[textmobile.text intValue]];
    NSNumber *lat=[NSNumber numberWithInt:[labelLocation.text floatValue]];
    
    NSArray *pathArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    imagePath=[NSString stringWithFormat:@"%@/%@.png",[pathArray objectAtIndex:0],mobile];
    
    NSData *imageData = UIImagePNGRepresentation(imagePicture.image);
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:imagePath contents:imageData attributes:nil];
    //set atrribute values in empty object
    [obj setValue:textAddress.text forKey:@"address"];
    [obj setValue:textEmail.text forKey:@"email"];
    [obj setValue:textName.text forKey:@"name"];
    [obj setValue:imagePath forKey:@"photo"];
    NSNumber *numMobile = [NSNumber numberWithInt:[textmobile.text intValue]];
    [obj setValue:numMobile forKey:@"mobile"];
    
    
    //save object context
    NSError *error;
    BOOL result = [objContext save:&error];
    NSLog(@"Result: %d,Error:%@",result,error);
    
    if (result == true) {
        textAddress.text =@"";
        textName.text = @"";
        textEmail.text =@"";
        textmobile.text =@"";
        labelLocation.text = @"";
        imagePicture.image=nil;
      
    }
}
    
    

@end
