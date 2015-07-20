Live Viewing
============
Deployed to Heroku [view sample here](https://iron-rails-api.herokuapp.com/train?lat=38.909706&long=-77.065357)  
May take a few moments to load this live data.

Description
=============
This API returns information for public transport in Washington D.C. 

Data for the closest 3 stations will be returned for Metro, Metrobus and Bikeshare

Usage
======
endpoints are /train, /bus, /bike
and require parameters of lat and long 
 
Example
========
An example that will return data is: ``` iron-rails-api.herokuapp.com/train?lat=38.909706&long=-77.065357 ```

Purpose
========
This was desinged as the backend of a group project at The Iron Yard.  The front and was desiged to use this API to display the data.  The final project can be viewed at [Exit Strategy](http://arhdesignco.com/exitstrategy/)

API
=====
Data returned is:
``` /train ```

```
{
  trains: [
    {
      name: 
      code: 
      distance: 
      lat: 
      long: 
      next_train: [
        {
        line: 
        min: 
        cars:
        direction: 
        },
        {
        line:
        min:
        cars:
        direction:
        }
      name: 
      code:
      }
    }
    ]
}
```

``` /bus ```

```
{
  buses: [
    {
      Lat:
      Lon: 
      Name: 
      Routes: [

      ],
      StopID: 
      distance: 
      prediction: [
      {
      RouteID: 
      DirectionText: 
      DirectionNum: 
      Minutes:
      VehicleID: 
      TripID: 
      }
      ]
      ]
    }
}
```


``` /bike ```

```
{
  bikes: [
    {
      name: 
      lat: 
      long:
      bikes_available: 
      empty_docks: 
      }
    ]
}
```