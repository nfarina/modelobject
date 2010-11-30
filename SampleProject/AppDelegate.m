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
	
	House *myHouse = [[[House alloc] init] autorelease];
	myHouse.capacity = 5;
	
	Cat *fluffy = [[[Cat alloc] init] autorelease];
	fluffy.name = @"Fluffy";
	
	Cat *mrWiggles = [[[Cat alloc] init] autorelease];
	mrWiggles.name = @"Mr. Wiggles";
	
	myHouse.cats = [NSArray arrayWithObjects:fluffy,mrWiggles,nil];
	
	NSLog(@"My House: %@", myHouse);
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