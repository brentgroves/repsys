# **[](https://www.odata.org/getting-started/understand-odata-in-6-steps/)**

Understand OData in 6 steps
OData (Open Data Protocol) is an **[OASIS](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=odata)** standard that defines the best practice for building and consuming RESTful APIs. OData helps you focus on your business logic while building RESTful APIs without having to worry about the approaches to define request and response headers, status codes, HTTP methods, URL conventions, media types, payload formats and query options etc. OData also guides you about tracking changes, defining functions/actions for reusable procedures and sending asynchronous/batch requests etc. Additionally, OData provides facility for extension to fulfil any custom needs of your RESTful APIs.

OData RESTful APIs are easy to consume. The OData metadata, a machine-readable description of the data model of the APIs, enables the creation of powerful generic client proxies and tools. Some of them can help you interact with OData even without knowing anything about the protocol. The following 6 steps demonstrate 6 interesting scenarios of OData consumption across different programming platforms. But if you are a non-developer and would like to simply play with OData, XOData is the best start for you.

## Step 1: Requesting resources

As the REST principles go, "Everything is a Resource". As a simple start, let's see how resources can be retrieved from the OData RESTful APIs. The sample service used is the TripPin service which simulates the service of an open trip management system. Our friend, Russell Whyte, who has formerly registered TripPin, would like to find out who are the other people in it.

```bash
GET https://services.odata.org/v4/TripPinServiceRW/People HTTP/1.1
OData-Version: 4.0
OData-MaxVersion: 4.0
```

## Step 2: Requesting an individual resource

REST principles also say, that every resource is identified by a unique identifier. OData also enables defining key properties of a resource and retrieving it using the keys. In this step, Russell wants to find the information about himself by specifying his username as the key.

```bash
GET https://services.odata.org/v4/TripPinServiceRW/People('russellwhyte') HTTP/1.1
OData-Version: 4.0
OData-MaxVersion: 4.0

# response
HTTP/1.1 200 OK
Content-Length: 482
Content-Type: application/json; odata.metadata=minimal
ETag: W/'08D1D5BE987DE78B'
OData-Version: 4.0
{
'@odata.context': 'https://services.odata.org/V4/(S(ak3ckilwx5ajembdktfunu0v))/TripPinServiceRW/$metadata#People/$entity',
'@odata.id': 'https://services.odata.org/V4/(S(ak3ckilwx5ajembdktfunu0v))/TripPinServiceRW/People('russellwhyte')',
'@odata.etag': 'W/'08D1D5BE987DE78B'',
'@odata.editLink': 'https://services.odata.org/V4/(S(ak3ckilwx5ajembdktfunu0v))/TripPinServiceRW/People('russellwhyte')',
'UserName': 'russellwhyte',
'FirstName': 'Russell',
'LastName': 'Whyte',
'Emails': [
    'Russell@example.com',
    'Russell@contoso.com',
    null
],
'AddressInfo': [
    {
        'Address': '187 Suffolk Ln.',
        'City': {
            'CountryRegion': 'United States',
            'Name': 'Boise',
            'Region': 'ID'
        }
    },
    null
],
'Gender': 'Male',
'Concurrency': 635524037014841200
}


```

## Step 3: Queries

As an architecture that's built on top of the current features of the Web, RESTful APIs can also support query strings. For that, OData defines a series of system query options that can help you construct complicated queries for the resources you want. With the help of that, our friend Russell can find out the first 2 persons in the system who have registered at least one trip that costs more than 3000, and only display their first name and last name.

```bash
GET https://services.odata.org/v4/TripPinServiceRW/People?$top=2 &amp; $select=FirstName, LastName &amp; $filter=Trips/any(d:d/Budget gt 3000) HTTP/1.1
OData-Version: 4.0
OData-MaxVersion: 4.0
```

## Step 4: Creating a new resource

REST principles require the using of simple and uniform interfaces. With that regard, OData clients can expect unified interfaces of the resources. The stateless transfer of representations in REST are carried out by using different HTTP methods in the requests. After having gone through the first 3 steps, Russell thinks the system is useful. He wants to add his best friend Lewis to the system. He finds out that all he needs to do is to send a POST request containing a JSON representation of Lewis' information to the same interface from which he requested the people information.

```bash
POST https://services.odata.org/v4/(S(34wtn2c0hkuk5ekg0pjr513b))/TripPinServiceRW/People HTTP/1.1
OData-Version: 4.0
OData-MaxVersion: 4.0
Content-Length: 428
Content-Type: application/json
{
    'UserName':'lewisblack',
    'FirstName':'Lewis',
    'LastName':'Black',
    'Emails':[
        'lewisblack@example.com'
    ],
    'AddressInfo':[
        {
            Address: '187 Suffolk Ln.',
            City: {
CountryRegion: 'United States',
Name: 'Boise',
Region: 'ID'
            }
        }
    ],
    'Gender': 'Male',
    'Concurrency':635519729375200400
}
```

## Step 5: Relating resources

In RESTful APIs, resources are usually dependent with each other. For that, the concept of relationships in OData can be defined among resources to add flexibility and richness to the data model. For example, in the TripPin OData service, people are related to the trips that they've booked using the system. Knowing that, Russell would like to invite Lewis to his existing trip in the U.S. by relating that trip to Lewis.

```bash
POST https://services.odata.org/v4/(S(34wtn2c0hkuk5ekg0pjr513b))/TripPinServiceRW/People('lewisblack')/Trips/$ref HTTP/1.1
OData-Version: 4.0
OData-MaxVersion: 4.0
Content-Length: 123
Content-Type: application/json
{
    '@odata.id':'https://services.odata.org/V4/(S(34wtn2c0hkuk5ekg0pjr513b))/TripPinServiceRW/People('russellwhyte')/Trips(0)'
}
```

## Step 6: Invoking a function

In RESTful APIs, there can be some custom operations that contain complicated logic and can be frequently used. For that purpose, OData supports defining functions and actions to represent such operations. They are also resources themselves and can be bound to existing resources. After having explored the TripPin OData service, Russell finds out that the it has a function called GetInvolvedPeople from which he can find out the involved people of a specific trip. He invokes the function to find out who else other than him and Lewis goes to that trip in the U.S.

```bash
GET https://services.odata.org/v4/(S(34wtn2c0hkuk5ekg0pjr513b))/TripPinServiceRW/People('russellwhyte')/Trips(0)/Microsoft.OData.SampleService.Models.TripPin.GetInvolvedPeople()
HTTP/1.1
OData-Version: 4.0
OData-MaxVersion: 4.0
```
