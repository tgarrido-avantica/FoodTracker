//
//  MealTableViewController.m
//  FoodTracker
//
//  Created by Tomás Garrido Sandino on 14/9/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import "MealTableViewController.h"
#import "Meal.h"
#import "MealTableViewCell.h"
#import "MealViewController.h"

@interface MealTableViewController ()

#pragma mark Properties
@property(nonatomic) NSMutableArray *meals;

@end

@implementation MealTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Use the edit button item provided by the table view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
   
    // Load any saved meals, otherwise load sample data.
    NSArray *savedMeals = [self loadMeals];
    if (savedMeals) {
        self.meals = [NSMutableArray arrayWithArray:savedMeals];
    } else {
    // Load the sample data
    [self loadSampleMeals];
   }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.meals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Table view cells are reused and should be dequeued using a cell identifier.
    MealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MealTableViewCell" forIndexPath:indexPath];
    
    // Fetches the appropriate meal for the data source layout.
    Meal *meal = self.meals[indexPath.row];
    
    cell.nameLabel.text = meal.name;
    cell.photoImageView.image = meal.photo;
    cell.ratingControl.rating = meal.rating;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.meals removeObjectAtIndex:indexPath.row];
        [self saveMeals];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"ShowDetail"]) {
        MealViewController *mealDetailViewController = (MealViewController *)segue.destinationViewController;
        if ([sender isMemberOfClass:[MealTableViewCell class]]) {
            MealTableViewCell *selectedMealCell = (MealTableViewCell *)sender;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedMealCell];
            Meal *selectedMeal = self.meals[indexPath.row];
            mealDetailViewController.meal = selectedMeal;
        }
    }
    else if ([segue.identifier isEqual:@"AddItem"]) {
        NSLog(@"Adding new meal.");
    }
}


- (void)loadSampleMeals {
    UIImage *photo1 = [UIImage imageNamed:@"meal1"];
    Meal *meal1 = [[Meal alloc] init:@"Caprese Salad" photo:photo1 rating:4];
    
    UIImage *photo2 = [UIImage imageNamed:@"meal2"];
    Meal *meal2 = [[Meal alloc] init:@"Chicken and Potatoes"  photo:photo2 rating: 5];
    
    UIImage *photo3 = [UIImage imageNamed:@"meal3"];
    Meal *meal3 = [[Meal alloc] init:@"Pasta with Meatballs" photo:photo3 rating:3];
    self.meals = [NSMutableArray arrayWithObjects:meal1, meal2, meal3, nil];
}

- (IBAction)unwindToMealList:(UIStoryboardSegue *)sender {
    if ([sender.sourceViewController isMemberOfClass:MealViewController.class]) {
        Meal *meal = ((MealViewController *)(sender.sourceViewController)).meal;
        NSIndexPath *selectedIndexPath;
        if ((selectedIndexPath = [self.tableView indexPathForSelectedRow])) {
            // Update an existing meal.
            self.meals[selectedIndexPath.row] = meal;
            [self.tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation: UITableViewRowAnimationNone];
        }
        else {
            // Add a new meal.
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.meals.count inSection:0];
            [self.meals addObject:meal];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        // Save the meals.
        [self saveMeals];
    }
}

#pragma mark NSCoding
- (void) saveMeals {
    BOOL isSuccessfulSave = [NSKeyedArchiver archiveRootObject:self.meals toFile:[[Meal archiveURL] path]];
    if (!isSuccessfulSave) {
        NSLog(@"Failed to save meals...");
    }
}

-(NSArray *)loadMeals {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[Meal archiveURL] path]];
}
@end
