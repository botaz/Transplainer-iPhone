// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.m instead.

#import "_Person.h"

@implementation PersonID
@end

@implementation _Person

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Person";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc_];
}

- (PersonID*)objectID {
	return (PersonID*)[super objectID];
}




@dynamic state;






@dynamic first_name;






@dynamic person_id;



- (long long)person_idValue {
	NSNumber *result = [self person_id];
	return result ? [result longLongValue] : 0;
}

- (void)setPerson_idValue:(long long)value_ {
	[self setPerson_id:[NSNumber numberWithLongLong:value_]];
}






@dynamic city;






@dynamic address;






@dynamic created_at;






@dynamic last_name;






@dynamic post_code;






@dynamic country;






@dynamic modified_at;






@dynamic lastModified;








@end
