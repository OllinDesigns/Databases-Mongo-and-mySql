use('pizzeria');

db.createCollection("customers");
db.customers.createIndex({ "customerId": 1 }, { unique: true });
db.createCollection("orders");
db.orders.createIndex({ "orderId": 1 }, { unique: true });

// Insert customer documents
const customer1Id = ObjectId();
const customer2Id = ObjectId();
const customer3Id = ObjectId();
const customer4Id = ObjectId();
const customer5Id = ObjectId();
const customer6Id = ObjectId();

db.customers.insertMany([
  {
    "customerId": customer1Id,
    "name": "Fulgencio",
    "surname": "Pantana",
    "personal_information": {
      "street": "Oak Street 23",
      "postalcode": "18001",
      "city": "Nairobi",
      "province": "NBI",
      "phone": "2505334"
    }
  },
  {
    "customerId": customer2Id,
    "name": "Munnira",
    "surname": "Katongole",
    "personal_information": {
      "street": "Eucalypt Road 666",
      "postalcode": "23004",
      "city": "Kisumu",
      "province": "KSM",
      "phone": "644937898"
    }
  },
  {
    "customerId": customer3Id,
    "name": "Zoneziwoh",
    "surname": "Mbondgulo-Wondieh",
    "personal_information": {
      "street": "Bonsai Avenue 69",
      "postalcode": "43002",
      "city": "Akure",
      "province": "Ondo",
      "phone": "46497898"
    }
  },
  {
    "customerId": customer4Id,
    "name": "Aisha",
    "surname": "Abdullahi",
    "personal_information": {
      "street": "Palm Grove 12",
      "postalcode": "76009",
      "city": "Lagos",
      "province": "Lagos",
      "phone": "123456789"
    }
  },
  {
    "customerId": customer5Id,
    "name": "John",
    "surname": "Smith",
    "personal_information": {
      "street": "Maple Lane 45",
      "postalcode": "98002",
      "city": "Seattle",
      "province": "Washington",
      "phone": "987654321"
    }
  },
  {
    "customerId": customer6Id,
    "name": "Maria",
    "surname": "Gonzalez",
    "personal_information": {
      "street": "Cedar Street 78",
      "postalcode": "10001",
      "city": "New York",
      "province": "New York",
      "phone": "555123456"
    }
  }
]);

const pizzaCategory1 = ObjectId();
const pizzaCategory2 = ObjectId();

const store1Id = ObjectId();
const store2Id = ObjectId();

const employee1Id = ObjectId();
const employee2Id = ObjectId();
const employee3Id = ObjectId();
const employee4Id = ObjectId();
const employee5Id = ObjectId();
const employee6Id = ObjectId();

const product1Id = ObjectId();
const product2Id = ObjectId();
const product3Id = ObjectId();
const product4Id = ObjectId();
const product5Id = ObjectId();
const product6Id = ObjectId();
const product7Id = ObjectId();

const order1Id = ObjectId();
const order2Id = ObjectId();
const order3Id = ObjectId();


const orderDateTime = new Date();

const totalPrice = Math.random() * 100;


// Insert order documents with customer references
db.orders.insertMany([
  {
    "orderId": order1Id,
    "customerId": customer1Id,
    "orderData": [
      {
        "category" : [
            {
                "categoryName" : "burger"
            }, 
            {
                "categoryName" : "drink"
            },
            {
                "categoryName" : "pizza",
                "pizzaCategory" : [
                    {
                        "pizzaCategoryId" : pizzaCategory1,
                        "pizzaCategoryName" : "Extra cheesy"
                    },
                    {
                        "pizzaCategoryId" : pizzaCategory2,
                        "pizzaCategoryName" : "Extra cheesy Delight"
                    },
                ]
            },
        ],
        "store": [
          {
            "storeId": store1Id,
            "storeName": "Cheesy Times Nairobi",
            "storeAddress": "Camel Street 96",
            "storePostcode": "18099",
            "storeTown": "Nairobi",
            "province": "NBI"
          },
          {
            "storeId": store2Id,
            "storeName": "Cheesy Times Tokyo",
            "storeAddress": "Yakuza Street 777",
            "storePostcode": "12345",
            "storeTown": "Tokyo",
            "province": "Tokyo"
          }
        ]
      },
      {
        "employee": [
            {
                "employeeId" : employee1Id,
                "employee_name" : "Amadou",
                "employee_lastname" : "Diop",
                "employee_nif" : "20099807",
                "employee_phone" : "2255336",
                "employee_position" : "cook",
                "employee_store" : store1Id
            },
            {
                "employeeId" : employee2Id,
                "employee_name" : "Amina",
                "employee_lastname" : "Ba",
                "employee_nif" : "21088907",
                "employee_phone" : "2362057",
                "employee_position" : "cook",
                "employee_store" : store1Id
            },
            {
                "employeeId" : employee3Id,
                "employee_name" : "Moussa",
                "employee_lastname" : "Gueye",
                "employee_nif" : "22079808",
                "employee_phone" : "2462068",
                "employee_position" : "delivery person",
                "employee_store" : store1Id
            },
            {
                "employeeId" : employee4Id,
                "employee_name" : "Rama",
                "employee_lastname" : "Kane",
                "employee_nif" : "23069908",
                "employee_phone" : "2562079",
                "employee_position" : "delivery person",
                "employee_store" : store2Id
            },
            {
                "employeeId" : employee5Id,
                "employee_name" : "Ibrahim",
                "employee_lastname" : "Ndiaye",
                "employee_nif" : "24060009",
                "employee_phone" : "2662080",
                "employee_position" : "delivery person",
                "employee_store" : store2Id
            },
            {
                "employeeId" : employee6Id,
                "employee_name" : "Julia",
                "employee_lastname" : "Smith",
                "employee_nif" : "25050109",
                "employee_phone" : "2762091",
                "employee_position" : "cook",
                "employee_store" : store2Id
            },
        ]
      },
      {
        "products": [
          {
            "productId": product1Id,
            "productName": "Extra Cheesy Delight",
            "productDescription": "a very cheesy pizza",
            "productImage": "C:UsersBastetPicturesCamera Rollcheesy1.png",
            "productPrice": 7.500,
            "productCategory": pizzaCategory1
          },
          {
            "productId": product2Id,
            "productName": "Cheesy Supreme",
            "productDescription": "A pizza loaded with an assortment of cheesy toppings",
            "productImage": "C:path\tocheesy_supreme.png",
            "productPrice": 9.990,
            "productCategory": pizzaCategory1
          },
          {
            "productId": product3Id,
            "productName": "Ultimate Cheesy Delight",
            "productDescription": "Indulge in the ultimate cheesy experience with this pizza",
            "productImage": "C:path\toultimate_cheesy_delight.png",
            "productPrice": 8.990,
            "productCategory": pizzaCategory2
          },
          {
            "productId": product4Id,
            "productName": "Cheesy Beef Burger",
            "productDescription": "A mouthwatering beef burger with a cheesy twist",
            "productImage": "C:path\tocheesy_beef_burger.png",
            "productPrice": 6.990,
            "productCategory": "burger"
          },
          {
            "productId": product5Id,
            "productName": "Double Cheesy Burger",
            "productDescription": "Two juicy patties and extra cheese make this burger extra delicious",
            "productImage": "C:path\todouble_cheesy_burger.png",
            "productPrice": 7.990,
            "productCategory": "burger"
          },
          {
            "productId": product6Id,
            "productName": "Impaled IPA",
            "productDescription": "A hoppy and cheesy IPA beer for beer enthusiasts",
            "productImage": "C:path\toimpaled_ipa.png",
            "productPrice": 6.490,
            "productCategory": "drink"
          },
          {
            "productId": product7Id,
            "productName": "Cheesy Cocktail",
            "productDescription": "A cheesy twist on a classic cocktail",
            "productImage": "C:path\tocheesy_cocktail.png",
            "productPrice": 7.990,
            "productCategory": "drink"
          }
        ]
      }
    ],
    "orderDescription" : [
        {
            "orderItem": product1Id,
            "productQuantity" : 2
        },
        {
            "orderItem": product4Id,
            "productQuantity" : 2
        }
    ],
    "forDelivery": true,
    "deliveryPerson" : employee5Id,
    "orderDateTime": orderDateTime,
    "deliveryDateTime": orderDateTime,
    "totalPrice": totalPrice
  },
  {
    "orderId": order2Id,
    "customerId": customer3Id,
    "orderDescription" : [
        {
            "orderItem": product4Id,
            "productQuantity" : 2
        },
        {
            "orderItem": product6Id,
            "productQuantity" : 2
        }
    ],
    "forDelivery": true,
    "deliveryPerson" : employee4Id,
    "orderDateTime": orderDateTime,
    "deliveryDateTime": orderDateTime,
    "totalPrice": totalPrice

  },
  {
    "orderId": order3Id,
    "customerId": customer5Id,
    "orderDescription" : [
        {
            "orderItem": product5Id,
            "productQuantity" : 2
        },
        {
            "orderItem": product1Id,
            "productQuantity" : 2
        }
    ],
    "forDelivery": true,
    "deliveryPerson" : employee2Id,
    "orderDateTime": orderDateTime,
    "deliveryDateTime": orderDateTime,
    "totalPrice": totalPrice

  }

]);
