#import "_Person.h"

@interface Person : _Person {}

// Custom logic goes here.
+ (Person *)personWithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)moc;

@end
