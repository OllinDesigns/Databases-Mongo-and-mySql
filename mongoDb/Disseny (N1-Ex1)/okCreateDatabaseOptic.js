use ('optic')

db.supplier.insertMany([
    {
      supplier_name: "Gaz",
      last_name: "Mawete",
      street: "Freedom Avenue",
      housenr: "10",
      floor: "1a",
      door: "2",
      city: "Kinshasa",
      postal_code: "RW430",
      country: "Democratic Republic of Congo",
      telephone: "9845523",
      fax: "9845444",
      nif: "9845444"
    },
    {
      supplier_name: "Femi",
      last_name: "Kuti",
      street: "Afrobeat Street",
      housenr: "15",
      floor: "3",
      door: "2",
      city: "Lagos",
      postal_code: "ng110",
      country: "Nigeria",
      telephone: "7358192",
      fax: "9845555",
      nif: "408516"
    },
    {
      supplier_name: "Angelique",
      last_name: "Kidjo",
      street: "Soul Avenue",
      housenr: "20",
      floor: "4b",
      door: "1",
      city: "Cotonou",
      postal_code: "bj320",
      country: "Benin",
      telephone: "5632897",
      fax: "9845666",
      nif: "510309"
    },
    {
      supplier_name: "Salif",
      last_name: "Keita",
      street: "Mali Road",
      housenr: "8",
      floor: "2c",
      door: "3",
      city: "Bamako",
      postal_code: "ml330",
      country: "Mali",
      telephone: "6785241",
      fax: "9845777",
      nif: "207908"
    }
  ])
  
  const supplier_id = db.supplier.find({}, { _id: 1 }).toArray();
  const supplier_1_id = supplier_id[0]._id;
  const supplier_2_id = supplier_id[1]._id;
  const supplier_3_id = supplier_id[2]._id;
  const supplier_4_id = supplier_id[3]._id;


  db.customers.insertMany([
    {
        customer_name: "Sadio Mané",
        customer_postcode: "16400",
        customer_phone: "6403360",
        customer_email: "mane@example.com",
        customer_registrationdate: ISODate("2019-04-14"),
        recomendedby: ""
      },
      {
        customer_name: "Pierre-Emerick Aubameyang",
        customer_postcode: "12345",
        customer_phone: "5551234",
        customer_email: "aubameyang@example.com",
        customer_registrationdate: ISODate("2020-01-01"),
        recomendedby: "Kalidou Koulibaly"
      },
      {
        customer_name: "Riyad Mahrez",
        customer_postcode: "54321",
        customer_phone: "5554321",
        customer_email: "mahrez@example.com",
        customer_registrationdate: ISODate("2020-02-02"),
        recomendedby: ""
      },
      {
        customer_name: "Hakim Ziyech",
        customer_postcode: "98765",
        customer_phone: "5559876",
        customer_email: "ziyech@example.com",
        customer_registrationdate: ISODate("2020-03-03"),
        recomendedby: "Albert Okocha"
      },
      {
        customer_name: "Thomas Partey",
        customer_postcode: "24680",
        customer_phone: "5552468",
        customer_email: "partey@example.com",
        customer_registrationdate: ISODate("2020-04-04"),
        recomendedby: "Sadio Mané"
      },
      {
        customer_name: "Kalidou Koulibaly",
        customer_postcode: "13579",
        customer_phone: "5551357",
        customer_email: "koulibaly@example.com",
        customer_registrationdate: ISODate("2020-05-05"),
        recomendedby: "Zoneziwoh Mbondgulo-Wondieh"
      },
      {
        customer_name: "Glanis Changachirere",
        customer_postcode: "97531",
        customer_phone: "5559753",
        customer_email: "changachirere@example.com",
        customer_registrationdate: ISODate("2020-06-06"),
        recomendedby: "Alex Iwobi"
      },
      {
        customer_name: "Albert Okocha",
        customer_postcode: "86420",
        customer_phone: "5558642",
        customer_email: "zaha@example.com",
        customer_registrationdate: ISODate("2020-07-07"),
        recomendedby: ""
      },
      {
        customer_name: "Alex Iwobi",
        customer_postcode: "75309",
        customer_phone: "5557530",
        customer_email: "iwobi@example.com",
        customer_registrationdate: ISODate("2020-08-08"),
        recomendedby: ""
      },
      {
        customer_name: "Eric Bailly",
        customer_postcode: "59287",
        customer_phone: "5555928",
        customer_email: "bailly@example.com",
        customer_registrationdate: ISODate("2020-09-09"),
        recomendedby: ""
      },
      {
        customer_name: "Zoneziwoh Mbondgulo-Wondieh",
        customer_postcode: "48176",
        customer_phone: "5554817",
        customer_email: "mbondgulo@example.com",
        customer_registrationdate: ISODate("2020-10-10"),
        recomendedby: "Wilfried Zaha"
      },
      {
        customer_name: "Naby Keita",
        customer_postcode: "37065",
        customer_phone: "5553706",
        customer_email: "keita@example.com",
        customer_registrationdate: ISODate("2020-11-11"),
        recomendedby: ""
      },
      {
        customer_name: "Munnira Katongole",
        customer_postcode: "26954",
        customer_phone: "5552695",
        customer_email: "katongole@example.com",
        customer_registrationdate: ISODate("2020-12-12"),
        recomendedby: ""
      },
      {
        customer_name: "Farida Charity",
        customer_postcode: "15843",
        customer_phone: "5551584",
        customer_email: "farida@example.com",
        customer_registrationdate: ISODate("2021-01-01"),
        recomendedby: "Zoneziwoh Mbondgulo-Wondieh"
      }
  ])

  const customer_id = db.customers.find({}, { _id: 1 }).toArray();
  const customer_1_id = customer_id[0]._id;
  const customer_2_id = customer_id[1]._id;
  const customer_3_id = customer_id[2]._id;
  const customer_4_id = customer_id[3]._id;
  const customer_5_id = customer_id[4]._id;
  const customer_6_id = customer_id[5]._id;
  const customer_7_id = customer_id[6]._id;
  const customer_8_id = customer_id[7]._id;
  const customer_9_id = customer_id[8]._id;
  const customer_10_id = customer_id[9]._id;
  const customer_11_id = customer_id[10]._id;
  const customer_12_id = customer_id[11]._id;
  const customer_13_id = customer_id[12]._id;
  const customer_14_id = customer_id[13]._id;

  db.glasses.insertMany([
    {
      "brand" : "Ray-Ban",
      "supplier" : ObjectId(supplier_1_id),
      "graduation" : "23.2",
      "frame_type" : "paste frame",
      "frame_color" : "red",
      "glass_color" : "transparent",
      "price" : 50.50
    },
    {
      "brand" : "Oakley",
      "supplier" : ObjectId(supplier_2_id),
      "graduation" : "15.2",
      "frame_type" : "metallic frame",
      "frame_color" : "orange",
      "glass_color" : "pink",
      "price" : 88.90
    },
    {
      "brand" : "Gucci",
      "supplier" : ObjectId(supplier_3_id),
      "graduation" : "18.5",
      "frame_type" : "floating frame",
      "frame_color" : "black",
      "glass_color" : "gray",
      "price" : 120.00
    },
    {
      "brand" : "Fendi",
      "supplier" : ObjectId(supplier_4_id),
      "graduation" : "21.7",
      "frame_type" : "paste frame",
      "frame_color" : "purple",
      "glass_color" : "brown",
      "price" : 95.75
    },
    {
      "brand" : "Ray-Ban",
      "supplier" : ObjectId(supplier_1_id),
      "graduation" : "20.3",
      "frame_type" : "floating frame",
      "frame_color" : "blue",
      "glass_color" : "green",
      "price" : 110.25
    },
    {
      "brand" : "Oakley",
      "supplier" : ObjectId(supplier_2_id),
      "graduation" : "18.9",
      "frame_type" : "metallic frame",
      "frame_color" : "silver",
      "glass_color" : "gray",
      "price" : 75.50
    },
    {
      "brand" : "Gucci",
      "supplier" : ObjectId(supplier_3_id),
      "graduation" : "16.4",
      "frame_type" : "paste frame",
      "frame_color" : "brown",
      "glass_color" : "brown",
      "price" : 95.00
    },
    {
      "brand" : "Fendi",
      "supplier" : ObjectId(supplier_4_id),
      "graduation" : "22.1",
      "frame_type" : "floating frame",
      "frame_color" : "gold",
      "glass_color" : "yellow",
      "price" : 135.00
    },
    {
      "brand" : "Ray-Ban",
      "supplier" : ObjectId(supplier_1_id),
      "graduation" : "19.6",
      "frame_type" : "metallic frame",
      "frame_color" : "black",
      "glass_color" : "gray",
      "price" : 99.99
    },
    {
      "brand" : "Oakley",
      "supplier" : ObjectId(supplier_2_id),
      "graduation" : "17.8",
      "frame_type" : "paste frame",
      "frame_color" : "white",
      "glass_color" : "transparent",
      "price" : 70.50
    }
  ])
   
  
  const glass_id = db.glasses.find({}, { _id: 1 }).toArray();
    const glass_1_id = glass_id[0]._id;
    const glass_2_id = glass_id[1]._id;
    const glass_3_id = glass_id[2]._id;
    const glass_4_id = glass_id[3]._id;
    const glass_5_id = glass_id[4]._id;
    const glass_6_id = glass_id[5]._id;
    const glass_7_id = glass_id[6]._id;
    const glass_8_id = glass_id[7]._id;
    const glass_9_id = glass_id[8]._id;
    const glass_10_id = glass_id[9]._id;

    // nuevo json generado con gpt con ISOdate format
    
    db.sales.insertMany(
      [
        {
            "sale_id" : 1,
            "sale_date" : { "$date": "2019-06-20T00:00:00Z" },
            "soldby_employee" : "Paula Gomez",
            "soldto_customer" : ObjectId(customer_13_id),
            "glass_id" : ObjectId(glass_6_id)
        },
        {
            "sale_id" : 2,
            "sale_date" : { "$date": "2022-05-28T00:00:00Z" },
            "soldby_employee" : "Immanuel Kant",
            "soldto_customer" : ObjectId(customer_11_id),
            "glass_id" : ObjectId(glass_1_id)
        },
        {
            "sale_id" : 3,
            "sale_date" : { "$date": "2021-11-11T00:00:00Z" },
            "soldby_employee" : "Delfin Quishpe",
            "soldto_customer" : ObjectId(customer_6_id),
            "glass_id" : ObjectId(glass_4_id)
        },
        {
            "sale_id" : 4,
            "sale_date" : { "$date": "2019-06-20T00:00:00Z" },
            "soldby_employee" : "Paula Gomez",
            "soldto_customer" : ObjectId(customer_14_id),
            "glass_id" : ObjectId(glass_10_id)
        },
        {
            "sale_id" : 5,
            "sale_date" : { "$date": "2022-05-28T00:00:00Z" },
            "soldby_employee" : "Immanuel Kant",
            "soldto_customer" : ObjectId(customer_8_id),
            "glass_id" : ObjectId(glass_7_id)
        },
        {
            "sale_id" : 6,
            "sale_date" : { "$date": "2021-11-11T00:00:00Z" },
            "soldby_employee" : "Delfin Quishpe",
            "soldto_customer" : ObjectId(customer_4_id),
            "glass_id" : ObjectId(glass_3_id)
        },
        {
            "sale_id" : 7,
            "sale_date" : { "$date": "2019-06-20T00:00:00Z" },
            "soldby_employee" : "Paula Gomez",
            "soldto_customer" : ObjectId(customer_13_id),
            "glass_id" : ObjectId(glass_4_id)
        },
        {
            "sale_id" : 8,
            "sale_date" : { "$date": "2022-05-28T00:00:00Z" },
            "soldby_employee" : "Immanuel Kant",
            "soldto_customer" : ObjectId(customer_2_id),
            "glass_id" : ObjectId(glass_3_id)
        },
        {
            "sale_id" : 9,
            "sale_date" : { "$date": "2021-11-11T00:00:00Z" },
            "soldby_employee" : "Delfin Quishpe",
            "soldto_customer" : ObjectId(customer_6_id),
            "glass_id" : ObjectId(glass_5_id)
        },
        {
            "sale_id" : 10,
            "sale_date" : { "$date": "2019-06-20T00:00:00Z" },
            "soldby_employee" : "Paula Gomez",
            "soldto_customer" : ObjectId(customer_7_id),
            "glass_id" : ObjectId(glass_6_id)
        },
        {
            "sale_id" : 11,
            "sale_date" : { "$date": "2022-05-28T00:00:00Z" },
            "soldby_employee" : "Immanuel Kant",
            "soldto_customer" : ObjectId(customer_8_id),
            "glass_id" : ObjectId(glass_4_id)
        },
        {
            "sale_id" : 12,
            "sale_date" : { "$date": "2021-11-11T00:00:00Z" },
            "soldby_employee" : "Delfin Quishpe",
            "soldto_customer" : ObjectId(customer_9_id),
            "glass_id" : ObjectId(glass_1_id)
        },
        {
            "sale_id" : 13,
            "sale_date" : { "$date": "2019-06-20T00:00:00Z" },
            "soldby_employee" : "Paula Gomez",
            "soldto_customer" : ObjectId(customer_6_id),
            "glass_id" : ObjectId(glass_4_id)
        },
        {
            "sale_id" : 14,
            "sale_date" : { "$date": "2022-05-28T00:00:00Z" },
            "soldby_employee" : "Immanuel Kant",
            "soldto_customer" : ObjectId(customer_4_id),
            "glass_id" : ObjectId(glass_5_id)
        },
        {
            "sale_id" : 15,
            "sale_date" : { "$date": "2021-11-11T00:00:00Z" },
            "soldby_employee" : "Delfin Quishpe",
            "soldto_customer" : ObjectId(customer_5_id),
            "glass_id" : ObjectId(glass_6_id)
        },
        {
            "sale_id" : 16,
            "sale_date" : { "$date": "2019-06-20T00:00:00Z" },
            "soldby_employee" : "Paula Gomez",
            "soldto_customer" : ObjectId(customer_4_id),
            "glass_id" : ObjectId(glass_8_id)
        },
        {
            "sale_id" : 17,
            "sale_date" : { "$date": "2022-05-28T00:00:00Z" },
            "soldby_employee" : "Immanuel Kant",
            "soldto_customer" : ObjectId(customer_6_id),
            "glass_id" : ObjectId(glass_2_id)
        },
        {
            "sale_id" : 18,
            "sale_date" : { "$date": "2021-11-11T00:00:00Z" },
            "soldby_employee" : "Delfin Quishpe",
            "soldto_customer" : ObjectId(customer_1_id),
            "glass_id" : ObjectId(glass_6_id)
        },
        {
            "sale_id" : 19,
            "sale_date" : { "$date": "2019-06-20T00:00:00Z" },
            "soldby_employee" : "Paula Gomez",
            "soldto_customer" : ObjectId(customer_7_id),
            "glass_id" : ObjectId(glass_4_id)
        },
        {
            "sale_id" : 20,
            "sale_date" : { "$date": "2022-05-28T00:00:00Z" },
            "soldby_employee" : "Immanuel Kant",
            "soldto_customer" : ObjectId(customer_4_id),
            "glass_id" : ObjectId(glass_5_id)
        }
    ])