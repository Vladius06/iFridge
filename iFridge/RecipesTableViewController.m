//
//  RecipesTableViewController.m
//  iFridge
//
//  Created by Vladius on 5/15/15.
//  Copyright (c) 2015 Vladius. All rights reserved.
//

#import "RecipesTableViewController.h"
#import "DataSourse.h"

@interface RecipesTableViewController ()
@property (strong, nonatomic)NSArray *recipes;
@end

@implementation RecipesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DataSourse getData:^{
        self.recipes = [[NSArray alloc] init];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
        request.predicate = nil;
        NSManagedObjectContext *context = ((AppDelegate*)([UIApplication sharedApplication]).delegate).managedObjectContext;
        
        self.recipes = [context executeFetchRequest:request
                                              error:NULL];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.recipes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Recipe cell" forIndexPath:indexPath];
    
    Recipe *recipe = self.recipes[indexPath.row];
    cell.textLabel.text = recipe.label;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.tableView reloadData];
}

@end
