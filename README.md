Don't reinvent the wheel every time you need a web backend for your apps, add one with **DataKit** in minutes!

Just spin up a server with [node](http://nodejs.org) and [MongoDB](http://www.mongodb.org) installed,
integrate the SDK into your app and you are ready to go!

**Author**: Erik Aigner [@eaignr](https://twitter.com/#!/eaignr)

### Server Configuration

Make sure you have [node](http://nodejs.org) with [npm](http://npmjs.org/) and [MongoDB](http://www.mongodb.org) running on your server. Setup your node project and install **DataKit**.

    npm install datakit
    
Then create a file `run.js` (or any other name you prefer) containing the following:

```javascript
require('datakit').run({});
```

Now start your node app and DataKit will present the following warning

    WARN:  No secret found in config, generated new one.
           Copy this secret to your DataKit iOS app and server config!

  	       66e5977931c7e48aa89c9da0ae5d3ffdff7f1a58e6819cbea062dda1fa050296 
 
  	       Terminating process.
           
Copy the newly generated secret and put it in your DataKit config. Now you can also specify additional config parameters. Although only the `secret` parameter is required, you should also specify a custom `salt`.

```javascript
require('datakit').run({
  'secret': '66e5977931c7e48aa89c9da0ae5d3ffdff7f1a58e6819cbea062dda1fa050296',
  'salt': 'mySecretSauce',
  'mongoURI': 'mongodb://<user>:<pass>@<host>:<port>/<dbName>',
  'port': 5000, // The port DataKit runs on
  'path': 'v1', // The root API path to append to the host, defauts to empty string
  'allowDestroy': false, // Flag if the server allows destroying entity collections
  'allowDrop': false, // Flag if the server allows collection drop
  'cert': 'path/to/cert', // SSL certificate
  'key': 'path/to/key', // SSL key
  'express': function (app) { /* Add your custom configuration to the express app */}
});
```

### Integrate the SDK

Link to DataKit and im port `<DataKit/DataKit.h>`. Now we only need to configure the DataKit manager and we are almost there (this needs to be done before any other DataKit objects are invoked, so the app delegate would be a good place to put it).

```objc
[DKManager setAPIEndpoint:@"http://localhost:3000];
[DKManager setAPISecret:@"66e5977931c7e48aa89c9da0ae5d3ffdff7f1a58e6819cbea062dda1fa050296"];
```

### Start Coding

Here are some examples on how to use DataKit. This is in no way the complete feature set, please look at the documentation for that (you can generate it with `sh gen_appledoc.sh`). You can throw almost anything at DataKit.

Main classes: `DKEntity`, `DKQuery`, `DKMapReduce`, `DKFile`, `DKRelation`, `DKQueryTableViewController`

#### Saving entites

```objc
DKEntity *entity = [DKEntity entityWithName:entityName];
[entity setObject:@"Erik" forKey:@"name"];
[entity setObject:@"Aigner" forKey:@"surname"];
[entity save];
```
    
#### Queries

```objc
DKQuery *query = [DKQuery queryWithEntityName:@"SearchableEntity"];
[query whereKey:@"text" matchesRegex:@"\\s+words"];

NSArray *results = [query findAll];
```
    
#### Files

```objc
DKFile *file = [DKFile fileWithName:@"BigFile" data:data];
[file save];
```
