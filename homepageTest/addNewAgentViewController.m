//
//  addNewAgentViewController.m
//  homepageTest
//
//  Created by ibs on 7/21/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "addNewAgentViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SSKeychain/SSKeychain.h>




@interface addNewAgentViewController ()

@end

@implementation addNewAgentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.suggestedMeshTableView.dataSource = self; 
    self.suggestedMeshTableView.delegate = self; 
    
    
    [self.suggestedMeshTableView reloadData];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    
    NSDictionary *parameters = @{@"accessToken": token , @"isIn" : @"0"};
    
    [manager POST:@"http://54.89.45.91/app/api/user/agent"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
              
              
              if ([responseObject[@"agents"] isKindOfClass:[NSArray class]]) {
                  NSLog(@"its an array!");
                  NSArray *jsonArray = (NSArray *)responseObject[@"agents"];
                  //     NSLog(@"jsonArray - %@",jsonArray[0]);
                  
                  NSLog(@"Number of elements %i", [jsonArray count]);
                  self.suggestedMeshesArray = jsonArray;
                  [self.suggestedMeshTableView reloadData];
              }
              else {
                  NSLog(@"its probably a dictionary");
                  NSDictionary *jsonDictionary = (NSDictionary *)responseObject[@"agents"];
                  NSLog(@"jsonDictionary - %@",jsonDictionary);
              }
              
              
              
              
              NSLog(@"JSON Loaded: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [self.suggestedMeshesArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//this function adds a mesh to the meshes an agents is in if they select row. 
{
    UIColor *myGreen =
    [UIColor colorWithRed:(57.0/255.0) green:(181.0/255.0) blue:(74.0/255.0) alpha:1.0];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell =
    
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.textColor = myGreen;
    cell.textLabel.text =
    [@"<" stringByAppendingString:[[self.suggestedMeshesArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    NSString *code = [[self.suggestedMeshesArray objectAtIndex:indexPath.row] objectForKey:@"code"];
    
    NSDictionary *parameters = @{@"accessToken": token , @"code" : code};
    
    [manager POST:@"http://54.89.45.91/app/api/user/agent/join"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSNumber *errorCode = [responseObject objectForKey:@"success"];
              NSLog(@"error:%@", errorCode);
              if ([errorCode isEqual:[[NSNumber alloc] initWithInt:1]]) {
                  [self.suggestedMeshTableView reloadData];
                  [self viewDidLoad];
                 }
              
              else {
                  [[[UIAlertView alloc]
                    initWithTitle:NSLocalizedString(@"Agent Join Failed", @"")
                    message:NSLocalizedString(@"Mesh Code Incorrect", @"")
                    delegate:nil
                    cancelButtonTitle:NSLocalizedString(@"Retry", @"")
                    otherButtonTitles: nil] show];
                  }
              
              NSLog(@"JSON Loaded: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    
}

- (IBAction)tapGestureOnTableView:(UITapGestureRecognizer *)sender {

    [self.meshCodeTextField resignFirstResponder];
}

- (IBAction)addButton:(UIButton *)sender {


    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    NSString *code = self.meshCodeTextField.text;
    NSDictionary *parameters = @{@"accessToken": token , @"code" : code};
    [manager POST:@"http://54.89.45.91/app/api/user/agent/join"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSNumber *errorCode = [responseObject objectForKey:@"success"];
              NSLog(@"error:%@", errorCode);
              
              if ([errorCode isEqual:[[NSNumber alloc] initWithInt:1]]) {
                  [self.suggestedMeshTableView reloadData];
                
                  }
              else {
                  [[[UIAlertView alloc]
                    initWithTitle:NSLocalizedString(@"Agent Join Failed", @"")
                    message:NSLocalizedString(@"Mesh Code Incorrect", @"")
                    delegate:nil
                    cancelButtonTitle:NSLocalizedString(@"Retry", @"")
                    otherButtonTitles: nil] show];
                    }
              
              NSLog(@"JSON Loaded: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}



@end
