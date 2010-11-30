#import "SMModelObject.h"
#import <objc/runtime.h>

@implementation SMModelObject

+ (id)make {
	return [[[self alloc] init] autorelease];
}

- (void)enumerateIvarsUsingBlock:(void (^)(Ivar var, NSString *name, BOOL *cancel))block {

	BOOL cancel = NO;
	
	for (Class cls = [self class]; !cancel && cls != [SMModelObject class]; cls = [cls superclass]) {
		
		unsigned int varCount;
		Ivar *vars = class_copyIvarList(cls, &varCount);
		
		for (int i = 0; !cancel && i < varCount; i++) {
			Ivar var = vars[i];
			NSString *name = [[NSString alloc] initWithUTF8String:ivar_getName(var)];
			block(var, name, &cancel);
			[name release];
		}
		
		free(vars);
	}
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {

		[self enumerateIvarsUsingBlock:^(Ivar var, NSString *name, BOOL *cancel) {
			[self setValue:[aDecoder decodeObjectForKey:name] forKey:name];
		}];
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {

	[self enumerateIvarsUsingBlock:^(Ivar var, NSString *name, BOOL *cancel) {
		[aCoder encodeObject:[self valueForKey:name] forKey:name];
	}];
}

- (void)dealloc
{
	[self enumerateIvarsUsingBlock:^(Ivar var, NSString *name, BOOL *cancel) {
		if (ivar_getTypeEncoding(var)[0] == _C_ID) [self setValue:nil forKey:name];
	}];
	
	[super dealloc];
}

- (id) copyWithZone:(NSZone *)zone {
	
	id copied = [[[self class] alloc] init];
	[self enumerateIvarsUsingBlock:^(Ivar var, NSString *name, BOOL *cancel) {
		[copied setValue:[self valueForKey:name] forKey:name];
	}];
	return copied;
}

- (BOOL) isEqual:(id)other {

	__block BOOL equal = NO;
	
	if ([other isKindOfClass:[self class]]) {
		
		equal = YES;
		[self enumerateIvarsUsingBlock:^(Ivar var, NSString *name, BOOL *cancel) {
			if (![[self valueForKey:name] isEqual:[other valueForKey:name]]) {
				equal = NO;
				*cancel = YES;
			}
		}];
	}
	
	return equal;
}

- (NSUInteger)hash
{
	__block NSUInteger hash = 0;

	[self enumerateIvarsUsingBlock:^(Ivar var, NSString *name, BOOL *cancel) {
		hash += (NSUInteger)var;
	}];

	return hash;
}

- (void) writeToDescription:(NSMutableString *)description withIndent:(NSUInteger)indent {
	
	[description appendFormat:@"<%@ %p", NSStringFromClass([self class]), self];
	
	void (^addLineBreak)() = ^ {
		[description appendString:@"\n"];
		for (int i=0;i<indent;i++) [description appendString:@"\t"];
	};
	
	[self enumerateIvarsUsingBlock:^(Ivar var, NSString *name, BOOL *cancel) {
		
		addLineBreak();
		id object = [self valueForKey:name];
		
		if ([object isKindOfClass:[SMModelObject class]]) {
			[object writeToDescription:description withIndent:indent+1];
		}
		else if ([object isKindOfClass:[NSArray class]]) {
			
			[description appendFormat:@"%@ =", name];
			
			for (id child in object) {
				addLineBreak();
				[description appendString:@"\t"];
				
				if ([child isKindOfClass:[SMModelObject class]])
					[child writeToDescription:description withIndent:indent+2];
				else
					[description appendString:[child description]];
			}
		}
		else {
			[description appendFormat:@"%@ = %@", name, object];
		}
	}];
		
	[description appendString:@">"];
}

- (NSString *) description {
	NSMutableString *description = [NSMutableString string];
	[self writeToDescription:description withIndent:1];
	return description;
}

@end
