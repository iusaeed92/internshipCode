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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
               NSArray *jsonArray = (NSArray *)responseObject[@"agents"];
               // NSLog(@"jsonArray - %@",jsonArray[0]);
               // NSLog(@"Number of elements %i", [jsonArray count]);
               self.suggestedMeshesArray = jsonArray;
               [self.suggestedMeshTableView reloadData];
               //           } else {
               //NSDictionary *jsonDictionary = (NSDictionary *)responseObject[@"agents"];
               // NSLog(@"jsonDictionary - %@",jsonDictionary);
           }
           NSLog(@"JSON Loaded: %@", responseObject);
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", error);
       }
    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.suggestedMeshesArray count];
}

//this function adds a mesh to the meshes an agents is in if they select row.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIColor *myGreen = [UIColor colorWithRed:(57.0/255.0) green:(181.0/255.0) blue:(74.0/255.0) alpha:1.0];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.textColor = myGreen;
    cell.textLabel.text = [@"<" stringByAppendingString:(self.suggestedMeshesArray)[indexPath.row][@"name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:
      [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", nil]];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *token = [SSKeychain passwordForService:@"Remesh" account:userName];
    NSString *code = (self.suggestedMeshesArray)[indexPath.row][@"code"];
    
    NSDictionary *parameters = @{@"accessToken": token , @"code" : code};
    
    [manager POST:@"http://54.89.45.91/app/api/user/agent/join"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSNumber *errorCode = responseObject[@"success"];
              if ([errorCode isEqual:@1]) {
                  [self.suggestedMeshTableView reloadData];
                  [self viewDidLoad];
              } else {
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
          }
    ];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
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
              NSNumber *errorCode = responseObject[@"success"];
              if ([errorCode isEqual:@1]) {
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
          }
    ];
}
@end
