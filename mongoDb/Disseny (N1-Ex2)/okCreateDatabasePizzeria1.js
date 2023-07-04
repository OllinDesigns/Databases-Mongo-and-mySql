use('pizzeria');

db.createCollection("customers");
db.customers.createIndex({ "customerId": 1 }, { unique: true });
db.createCollection("orders");
db.orders.createIndex({ "orderId": 1 }, { unique: true });

class Customer {
  static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
  }
}

const customerIds = Customer.generateIds(10);

class Pizzacategory {
    static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
  }
}

const pizzacategoryIds = Pizzacategory.generateIds(2);

const store1Id = ObjectId();
const store2Id = ObjectId();

class Employee {
    static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
    }
}

const employeeIds = Employee.generateIds(5)


class Product {
    static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
    }
}

const productIds = Product.generateIds(7)


class Order {
    static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
    }
}

const orderIds = Order.generateIds(7)

const orderDateTime = new Date();

const totalPrice = Math.random() * 100;



db.customers.insertMany([
  {
    "customerId": customerIds[0],
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
    "customerId": customerIds[1],
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
    "customerId": customerIds[2],
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
    "customerId": customerIds[3],
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
    "customerId": customerIds[4],
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
    "customerId": customerIds[5],
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


// Insert order documents with customer references
db.orders.insertMany([
  {
    "orderId": orderIds[0],
    "customerId": customerIds[0],
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
                        "pizzaCategoryId" : pizzacategoryIds[0],
                        "pizzaCategoryName" : "Extra cheesy"
                    },
                    {
                        "pizzaCategoryId" : pizzacategoryIds[1],
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
                "employeeId" : employeeIds[0],
                "employee_name" : "Amadou",
                "employee_lastname" : "Diop",
                "employee_nif" : "20099807",
                "employee_phone" : "2255336",
                "employee_position" : "cook",
                "employee_store" : store1Id
            },
            {
                "employeeId" : employeeIds[1],
                "employee_name" : "Amina",
                "employee_lastname" : "Ba",
                "employee_nif" : "21088907",
                "employee_phone" : "2362057",
                "employee_position" : "cook",
                "employee_store" : store1Id
            },
            {
                "employeeId" : employeeIds[2],
                "employee_name" : "Moussa",
                "employee_lastname" : "Gueye",
                "employee_nif" : "22079808",
                "employee_phone" : "2462068",
                "employee_position" : "delivery person",
                "employee_store" : store1Id
            },
            {
                "employeeId" : employeeIds[3],
                "employee_name" : "Rama",
                "employee_lastname" : "Kane",
                "employee_nif" : "23069908",
                "employee_phone" : "2562079",
                "employee_position" : "delivery person",
                "employee_store" : store2Id
            },
            {
                "employeeId" : employeeIds[4],
                "employee_name" : "Ibrahim",
                "employee_lastname" : "Ndiaye",
                "employee_nif" : "24060009",
                "employee_phone" : "2662080",
                "employee_position" : "delivery person",
                "employee_store" : store2Id
            },
            {
                "employeeId" : employeeIds[5],
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
            "productId": productIds[0],
            "productName": "Extra Cheesy Delight",
            "productDescription": "a very cheesy pizza",
            "productImage": "C:UsersBastetPicturesCamera Rollcheesy1.png",
            "productPrice": 7.500,
            "productCategory": pizzacategoryIds[0]
          },
          {
            "productId": productIds[1],
            "productName": "Cheesy Supreme",
            "productDescription": "A pizza loaded with an assortment of cheesy toppings",
            "productImage": "C:path\tocheesy_supreme.png",
            "productPrice": 9.990,
            "productCategory": pizzacategoryIds[1]
          },
          {
            "productId": productIds[2],
            "productName": "Ultimate Cheesy Delight",
            "productDescription": "Indulge in the ultimate cheesy experience with this pizza",
            "productImage": "C:path\toultimate_cheesy_delight.png",
            "productPrice": 8.990,
            "productCategory": pizzacategoryIds[0]
          },
          {
            "productId": productIds[3],
            "productName": "Cheesy Beef Burger",
            "productDescription": "A mouthwatering beef burger with a cheesy twist",
            "productImage": "C:path\tocheesy_beef_burger.png",
            "productPrice": 6.990,
            "productCategory": "burger"
          },
          {
            "productId": productIds[4],
            "productName": "Double Cheesy Burger",
            "productDescription": "Two juicy patties and extra cheese make this burger extra delicious",
            "productImage": "C:path\todouble_cheesy_burger.png",
            "productPrice": 7.990,
            "productCategory": "burger"
          },
          {
            "productId": productIds[5],
            "productName": "Impaled IPA",
            "productDescription": "A hoppy and cheesy IPA beer for beer enthusiasts",
            "productImage": "C:path\toimpaled_ipa.png",
            "productPrice": 6.490,
            "productCategory": "drink"
          },
          {
            "productId": productIds[6],
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
            "orderItem": productIds[6],
            "productQuantity" : 2
        },
        {
            "orderItem": productIds[4],
            "productQuantity" : 2
        }
    ],
    "forDelivery": true,
    "deliveryPerson" : employeeIds[4],
    "orderDateTime": orderDateTime,
    "deliveryDateTime": orderDateTime,
    "totalPrice": totalPrice
  },
  {
    "orderId": orderIds[1],
    "customerId": customerIds[3],
    "orderDescription" : [
        {
            "orderItem": productIds[3],
            "productQuantity" : 2
        },
        {
            "orderItem": productIds[2],
            "productQuantity" : 2
        }
    ],
    "forDelivery": true,
    "deliveryPerson" : employeeIds[3],
    "orderDateTime": orderDateTime,
    "deliveryDateTime": orderDateTime,
    "totalPrice": totalPrice

  },
  {
    "orderId": orderIds[2],
    "customerId": customerIds[4],
    "orderDescription" : [
        {
            "orderItem": productIds[3],
            "productQuantity" : 2
        },
        {
            "orderItem": productIds[2],
            "productQuantity" : 2
        }
    ],
    "forDelivery": true,
    "deliveryPerson" : employeeIds[4],
    "orderDateTime": orderDateTime,
    "deliveryDateTime": orderDateTime,
    "totalPrice": totalPrice

  }

]);
