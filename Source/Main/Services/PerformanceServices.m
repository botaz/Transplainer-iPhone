#import "PerformanceServices.h"
#import "SBJSON.h"
#import "DDXML.h"
#import "Person.h"

@interface PerformanceServices (private)

- (void)downloadXML;
- (void)downloadXMLTree;
- (void)downloadJSON;
- (void)downloadPLIST;

@end

@implementation PerformanceServices

SYNTHESIZE_SINGLETON_FOR_CLASS(PerformanceServices)

- (void)downloadPeopleUsingFormat:(DownloadFormat)downloadFormat
{
	switch (downloadFormat) {
		case XMLFormat:
			[self downloadXML];
			break;
		case XMLTreeFormat:
			[self downloadXMLTree];
			break;
		case JSONFormat:
			[self downloadJSON];
			break;
		case PLISTFormat:
			[self downloadPLIST];
			break;
		default:
			break;
	}
}

- (void)downloadXML
{
	[self downloadContentForUrl:SERVICEURL(@"/people.xml?limit=100") withObject:@"XML"];
}

- (void)downloadXMLTree
{
	[self downloadContentForUrl:SERVICEURL(@"/people.xml?limit=100") withObject:@"XML"];
}

- (void)downloadJSON
{
	[self downloadContentForUrl:SERVICEURL(@"/people.json?limit=100") withObject:@"JSON"];
}

- (void)downloadPLIST
{
	[self downloadContentForUrl:SERVICEURL(@"/people.plist?limit=100") withObject:@"PLIST"];
}

- (void)downloadContentForUrl:(NSString *)url withObject:(id)object
{
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:object forKey:@"object"];
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	request.shouldPresentAuthenticationDialog = TRUE;
	request.useKeychainPersistence = TRUE;
	request.numberOfTimesToRetryOnTimeout = 2;
	request.timeOutSeconds = RequestTimeOutSeconds;
	request.delegate = self;
	request.userInfo = userInfo;
	[self.networkQueue addOperation:request];
	
	[self.networkQueue go];
}

- (void)fetchStarted:(ASIHTTPRequest *)request
{
	DLog(@"fetch started");
}

- (void)fetchCompleted:(ASIHTTPRequest *)request
{
	 NSDictionary *info = request.userInfo;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:PerformanceFinishedDownloadingForFormat object:[info valueForKey:@"object"]];
	
	if (!request.error)  {
		NSArray *people = nil;
		NSString *format = [info valueForKey:@"object"];
		if ([format isEqualToString:@"XML"]) {
			DDXMLDocument *xmlDocument = [[DDXMLDocument alloc]initWithData:[request responseData] options:0 error:nil];
			people = [xmlDocument nodesForXPath:@"./people/person[1]/person" error:nil];
		} else if ([format isEqualToString:@"JSON"]) {
			SBJSON *json = [[[SBJSON alloc]init] autorelease];
			people = (NSArray *)[[json objectWithString:[request responseString] error:nil]valueForKey:@"people"];
		} else if ([format isEqualToString:@"PLIST"]) {
			people = [NSPropertyListSerialization propertyListFromData:[request responseData]
													  mutabilityOption:NSPropertyListImmutable
																format:NULL
													  errorDescription:NULL];
		}
		
		if (people && people.count > 0) {
			DLog(@"%@", people);
//			NSDate *now = [NSDate date];
			//for (NSDictionary *personDict in people) {
//				Person *person = [Person personWithDictionary:personDict managedObjectContext:self.managedObjectContext];
//				person.lastModified = now;
//			}
		}
		
		[[NSNotificationCenter defaultCenter] postNotificationName:PerformanceFinishedParsingForFormat object:[info valueForKey:@"object"]];
	}
	
	DLog(@"fetch complete");
}

- (void)fetchFailed:(ASIHTTPRequest *)request
{
	[self saveLastFetchedUrl:[request.originalURL absoluteString]];
	
	DLog(@"fetch failed");
}

- (void)queueFinished:(ASINetworkQueue *)queue
{
	DLog(@"queue finished");
}

@end
