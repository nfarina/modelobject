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
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {

	// Test creation of new objects
	
	SearchResults *results = [SearchResults new];
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
	
	// Test the description method
	
	NSLog(@"Search Results: \n%@", results);
	
	// Test that we can enumerate through an object's property names
	
	for (NSString *key in twilight)
		NSLog(@"Twilight has a member named: %@", key);
	
	// Test that copy produces a new object with copied members.
	
	SearchResults *copied = [[results copy] autorelease];
	
	NSLog(@"Copied: %@", copied);
	NSLog(@"Copied results have same pointer? %i but are they equal? %i", copied == results, [copied isEqual:results]);
	
	// Test that encoding/decoding produces a copied object that satisfies isEqual.
	
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:results];
	
	NSLog(@"Encoded to data of length %i", [data length]);
	
	SearchResults *decoded = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	
	NSLog(@"Decoded: %@", decoded);
	NSLog(@"Encoded results are equal? %i", [decoded isEqual:results]);
	
	// Test that releasing results releases its "books" member.
	
	NSArray *books = results.books;
	int booksRetainCountBeforeParentRelease = [books retainCount];
	[results release];
	NSLog(@"Results released. Books array retain count was %i, now %i", booksRetainCountBeforeParentRelease, [books retainCount]);
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
