//
//  ContactsTableViewController.m
//  ContactMapCoreDataAsgmt
//
//  Created by Rajesh on 19/12/15.
//  Copyright © 2015 CDAC. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "AppDelegate.h"
@interface ContactsTableViewController ()

@end

@implementation ContactsTableViewController

@synthesize arrayContacts;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //load all save object from context
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *objContext = [appDelegate managedObjectContext];
    
    //prepare selection query request to fetch Student objects
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Mycontacts"];
    
    //execute fetch request
    NSError *error;
    NSArray *array = [objContext executeFetchRequest:request error:&error];
    
    arrayContacts = [[NSMutableArray alloc]initWithArray:array];
    
    if (error == nil) {
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"error:%@",error);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return arrayContacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSManagedObject *obj = [arrayContacts objectAtIndex:indexPath.row];
    
    NSString *name = [obj valueForKey:@"name"];
    NSString *nummob = [obj valueForKey:@"mobile"];
    NSString *email =[obj valueForKey:@"email"];
    
    NSString *imagePath1=[obj valueForKey:@"photo"];
    cell.imageView.image=[UIImage imageWithContentsOfFile:imagePath1];

    cell.textLabel.text = [NSString stringWithFormat:@"%@,%@,%@",nummob,name,email];
    
    
    // Configure the cell...
    
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
