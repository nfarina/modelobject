#import "AppDelegate.h"
#import "SMModelObject.h"

@interface SearchResults : SMModelObject
@property (nonatomic, assign) NSUInteger totalResults;
@property (nonatomic, copy) NSArray *books;
@end

@implementation SearchResults
@end

@interface Book : SMModelObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSDictionary *authors;
@end
@implementation Book

- (void)dealloc {
	self.title = nil;
	[super dealloc];
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {

	SearchResults *results = [[SearchResults new] autorelease];
	results.totalResults = 74;
	
	Book *harryPotter = [[Book new] autorelease];
	harryPotter.title = @"Harry Potter and the Half-Blood Prince";
	harryPotter.price = 29.95;
	harryPotter.authors = [NSDictionary dictionaryWithObjectsAndKeys:
						   @"J.K. Rowling",@"Primary",
						   @"Bob's your uncle",@"Secondary",
						   nil];
	
	Book *twilight = [[Book new] autorelease];
	twilight.title = @"Twilight";
	twilight.price = 19.95;
	
	results.books = [NSArray arrayWithObjects:harryPotter,twilight,nil];
	
	NSLog(@"Search Results: \n%@", results);
}


- (void)equivalentNSDictionaryCodeThatSucks {

	NSMutableDictionary *searchResults = [NSMutableDictionary dictionary];
	[searchResults setObject:[NSNumber numberWithUnsignedInteger:74] forKey:@"totalResults"];
	
	NSMutableDictionary *harryPotter = [NSMutableDictionary dictionary];
	[harryPotter setObject:@"Harry Potter and the Half-Blood Prince" forKey:@"title"];
	[harryPotter setObject:[NSNumber numberWithFloat:29.95] forKey:@"price"];
	
	NSMutableDictionary *twilight = [NSMutableDictionary dictionary];
	[twilight setObject:@"Twilight" forKey:@"title"];
	[twilight setObject:[NSNumber numberWithFloat:19.95] forKey:@"price"];
	
	[searchResults setObject:[NSArray arrayWithObjects:harryPotter,twilight,nil] forKey:@"results"];
	
	NSLog(@"Results: \n%@", searchResults);
	
}

@end
