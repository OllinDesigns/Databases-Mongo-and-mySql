

// We have a collection of Restaurant Objects in New York City, and we need some queries... can you help us?

// Write a query to display all documents in the Restaurants collection.
db.Restaurant.find({})


// Write a query to display the restaurant_id, name, borough, and cuisine of all documents in the Restaurants collection.
db.Restaurant.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 })


// Write a query to display the restaurant_id, name, borough, and cuisine, but excluding the _id field for all documents in the Restaurants collection.
db.Restaurant.find({}, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 })


// Write a query to display restaurant_id, name, borough, and zip code, but excluding the _id field for all documents in the Restaurants collection.
db.Restaurant.find({}, { _id: 0, restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1 })


// Write a query to show all the restaurants that are in the Bronx.
db.Restaurant.find({ "borough": "Bronx" })


// Write a query to show the first 5 restaurants that are in the Bronx.
db.Restaurant.find({ "borough": "Bronx" }).limit(5)


// Enter a query to display all 5 restaurants after skipping the first 5 that are in the Bronx.
db.Restaurant.find({ "borough": "Bronx" }).skip(5).limit(5)


// Write a query to find restaurants that have a score greater than 80 but less than 100.
db.Restaurant.find({ "grades.score": { $gt: 80, $lt: 100 } })


// Enter a query to find restaurants that are located at a longitude less than -95.754168.
db.Restaurant.find({ "address.coord.0": { $lt: -95.754168 } })


// Write a MongoDB query to find restaurants that do not serve 'American' food and have a score greater than 70 and longitude less than -65.754168.
db.Restaurant.find({
    cuisine: { $nin: ['American'] },
    "grades.score": { $gt: 70 },
    "address.coord.0": { $lt: -65.754168 }
  })
  

// Write a query to find restaurants that do not prepare 'American' food and have a score higher than 70 and which, in addition, are located in longitudes lower than -65.754168. Note: Do this query without using the $and operator.
db.Restaurant.find({
    cuisine: { $ne: 'American' },
    "grades.score": { $gt: 70 },
    "address.coord.0": { $lt: -65.754168 }
  })
  

// Enter a query to find restaurants that do not serve 'American' food, have an 'A' rating and are not in Brooklyn. The document should be displayed according to cuisine in descending order.
db.Restaurant.find({
    cuisine: { $ne: 'American' },
    "grades.grade": 'A',
    borough: { $ne: 'Brooklyn' }
  }).sort({ cuisine: -1 })
  

// Write a query to find the restaurant_id, name, borough and cuisine for those restaurants that contain 'Wil' in the first three letters of their name.
db.Restaurant.find(
    { name: { $regex: '^Wil', $options: 'i' } },
    { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }
  )
  
  

// Write a query to find the restaurant_id, name, borough, and cuisine for those restaurants that contain 'ces' in the last three letters of their name.
db.Restaurant.find(
    { name: { $regex: 'ces$', $options: 'i' } },
    { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }
  )
  

// Write a query to find the restaurant_id, name, borough and cuisine for those restaurants that contain 'Reg' anywhere in their name.
db.Restaurant.find(
    { name: { $regex: 'Reg', $options: 'i' } },
    { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }
  )
  

// Write a query to find restaurants that belong to the Bronx and prepare American or Chinese dishes.
db.Restaurant.find(
    {
      borough: 'Bronx',
      cuisine: { $in: ['American', 'Chinese'] }
    }
  )  

// Write a query to find the restaurant_id, name, borough, and cuisine for those restaurants that belong to Staten Island, Queens, Bronx, or Brooklyn.
db.Restaurant.find(
    {
      borough: { $in: ['Staten Island', 'Queens', 'Bronx', 'Brooklyn'] }
    },
    {
      restaurant_id: 1,
      name: 1,
      borough: 1,
      cuisine: 1
    }
  )
  

// Write a query to find the restaurant_id, name, borough, and cuisine for those restaurants that are NOT located in Staten Island, Queens, Bronx, or Brooklyn.
db.Restaurant.find(
    {
      borough: { $nin: ['Staten Island', 'Queens', 'Bronx', 'Brooklyn'] }
    },
    {
      restaurant_id: 1,
      name: 1,
      borough: 1,
      cuisine: 1
    }
  )
  

// Write a query to find the restaurant_id, name, borough, and cuisine for those restaurants that score less than 10.

db.Restaurant.find(
    { 
    "grades.score": { $lt: 10 },
    },
    {
    restaurant_id: 1,
      name: 1,
      borough: 1,
      cuisine: 1
}
)

// Write a query to find the restaurant_id, name, borough and cuisine for those restaurants that prepare seafood ('seafood') unless they are 'American', 'Chinese' or the restaurant name starts with the letters 'Wil'.
db.Restaurant.find(
    {
      $and: [
        { cuisine: "Seafood" },
        { cuisine: { $not: { $in: ["American", "Chinese"] } } },
        { name: { $not: { $regex: "^Wil", $options: "i" } } }
      ]
    },
    {
      restaurant_id: 1,
      name: 1,
      borough: 1,
      cuisine: 1
    }
  )
  


// Write a query to find the restaurant_id, name, and grades for those restaurants that achieve a grade of "A" and a score of 11 with an ISODate of "2014-08-11T00:00:00Z".
db.Restaurant.find(
    {
      grades: {
        $elemMatch: {
          grade: "A",
          score: 11,
          date: { $eq: ISODate("2014-08-11T00:00:00Z") }
        }
      }
    },
    {
      restaurant_id: 1,
      name: 1,
      grades: 1
    }
  )
  

// Write a query to find the restaurant_id, name, and grades for those restaurants where the 2nd element of the grades array contains a grade of "A" and a score of 9 with an ISODate of "2014-08-11T00:00:00Z" .
db.Restaurant.find(
    {
      "grades.1.grade": "A",
      "grades.1.score": 9,
      "grades.1.date": ISODate("2014-08-11T00:00:00Z")
    },
    {
      restaurant_id: 1,
      name: 1,
      grades: 1
    }
  )
  


// Write a query to find the restaurant_id, name, address, and geographic location for those restaurants where the second element of the coord array contains a value between 42 and 52.
db.Restaurant.find(
    {
      "address.coord.1": { $gt: 42, $lt: 52 }
    },
    {
      restaurant_id: 1,
      name: 1,
      address: 1,
      "address.coord": 1
    }
  )  


// Enter a query to sort restaurants by name in ascending order.
db.Restaurant.find().sort({ name: 1 })

// Enter a query to sort restaurants by name in descending order.
db.Restaurant.find().sort({ name: -1 })


// Write a query to organize restaurants by cuisine name in ascending order and by neighborhood in descending order.
db.Restaurant.find().sort(
    { cuisine: 1 },
    { borough: -1 },
    
    )

// Write a query to find out if the addresses contain the street.
db.Restaurant.find({ "address.street": { $exists: true } })


// Write a query that selects all documents in the restaurant collection where the values of the coord field are of type Double.
db.Restaurant.find({ "address.coord": { $type: "double" } })

// Write a query that selects the restaurant_id, name, and grade for those restaurants that return 0 as the remainder after dividing any of their scores by 7.
db.Restaurant.find(
    {
      "grades.score": { $mod: [7, 0] }
    },
    {
      restaurant_id: 1,
      name: 1,
      grade: 1
    },
  )

// Write a query to find the restaurant name, borough, longitude, latitude and cuisine for those restaurants that contain 'mon' somewhere in their name.
db.Restaurant.find(
    {
      name: { $regex: 'mon' }
    },
    {
      name: 1,
      borough: 1,
      "address.coord": 1,
      cuisine: 1
    }
  )
  

// Write a query to find the restaurant name, borough, longitude, latitude and cuisine for those restaurants that contain 'Mad' as the first three letters of their name.

db.Restaurant.find(
    {
      name: { $regex: '^Mad' }
    },
    {
      name: 1,
      borough: 1,
      "address.coord": 1,
      cuisine: 1
    }
  )
  