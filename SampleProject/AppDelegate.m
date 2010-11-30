#import "AppDelegate.h"
#import "SMModelObject.h"

@interface House : SMModelObject
@property (nonatomic, assign) NSUInteger capacity;
@property (nonatomic, copy) NSArray *cats;
@end

@implementation House
@end

@interface Cat : SMModelObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger livesRemaining;
- (void)die;
@end

@implementation Cat
- (id)init { if (self = [super init]) livesRemaining = 9; return self; }
- (void) die { livesRemaining--; }
@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {

	{
		NSMutableDictionary *house = [NSMutableDictionary dictionary];
		[house setObject:[NSNumber numberWithUnsignedInteger:5] forKey:@"capacity"];
		
		NSMutableDictionary *fluffy = [NSMutableDictionary dictionary];
		[fluffy setObject:@"Fluffy" forKey:@"name"];
		[fluffy setObject:[NSNumber numberWithUnsignedInteger:9] forKey:@"livesRemaining"];

		NSMutableDictionary *mrWiggles = [NSMutableDictionary dictionary];
		[mrWiggles setObject:@"Mr. Wiggles" forKey:@"name"];
		[mrWiggles setObject:[NSNumber numberWithUnsignedInteger:9] forKey:@"livesRemaining"];
		
		[house setObject:[NSArray arrayWithObjects:fluffy,mrWiggles,nil] forKey:@"cats"];

		NSLog(@"Dict: \n%@", house);
	}
	
	{
		House *house = [House make];
		house.capacity = 5;
		
		Cat *fluffy = [Cat make];
		fluffy.name = @"Fluffy";
		
		Cat *mrWiggles = [Cat make];
		mrWiggles.name = @"Mr. Wiggles";
		
		house.cats = [NSArray arrayWithObjects:fluffy,mrWiggles,nil];
		
		NSLog(@"My House: \n%@", house);
	}
}

@end


/*
 Dog *fido = [[Dog alloc] init];
 fido.name = @"Fido";
 
 Animal *nick = [[Animal alloc] init];
 nick.name = @"Nick";
 
 fido.owner = nick;
 fido.lives = 7;
 
 NSLog(@"Copy nick");
 Animal *zombieNick = [[nick copy] autorelease];
 NSLog(@"Zombie nick's name is %@", zombieNick.name);
 
 NSLog(@"Encode fido");
 [NSKeyedArchiver archiveRootObject:fido toFile:@"/test.txt"];
 
 NSLog(@"Decode fido");
 Dog *zombieFido = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/test.txt"];
 NSLog(@"Zombie dog's name is %@ and he has %i lives.", zombieFido.name, zombieFido.lives);
 
 NSLog(@"Compare fido to zombieFido. Equal? %i. Hash? %i and %i.", [zombieFido isEqual:fido], [zombieFido hash], [fido hash]);
 
 NSLog(@"Release nick.");
 [nick release];
 
 NSLog(@"Release fido.");
 [fido release]; 

*/