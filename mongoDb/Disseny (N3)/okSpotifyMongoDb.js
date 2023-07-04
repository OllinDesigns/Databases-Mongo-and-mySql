use('spo');

class User {
  static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
  }
}

const userIds = User.generateIds(10);

const premiumUserIds = User.generateIds(10);


class Playlist {
  static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
  }
}

const playlistIds = Playlist.generateIds(10);


class Music {
  static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
  }
}

const musicIds = Music.generateIds(10);


class Album {
  static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
  }
}

const albumIds = Album.generateIds(2);


class Artist {
  static generateIds(num) {
    const ids = [];
    for (let i = 0; i < num; i++) {
      ids.push(new ObjectId());
    }
    return ids;
  }
}

const artistIds = Artist.generateIds(1);


// insert collections and documents

db.users.insertMany([
  {
    _id: userIds[0],
    email: 'example1@example.com',
    password: 'password123',
    username: 'exampleuser1',
    dateOfBirth: ISODate('1990-01-01'),
    sex: 'male',
    country: 'United States',
    postalCode: '12345',
    followedArtists: [artistIds[0], artistIds[1]],
    favoriteAlbums: [albumIds[0], albumIds[1]],
    favoriteSongs: [musicIds[0], musicIds[1]],
    userType: 'free',
  },
  {
    _id: premiumUserIds[0],
    email: 'example2@example.com',
    password: 'password456',
    username: 'exampleuser2',
    dateOfBirth: ISODate('1995-02-02'),
    sex: 'female',
    country: 'Canada',
    postalCode: '67890',
    followedArtists: [artistIds[2], artistIds[1]],
    favoriteAlbums: [albumIds[0], albumIds[1]], 
    favoriteSongs: [musicIds[0], musicIds[1]],
    userType: 'premium',
    subscription: {
      startDate: ISODate('2023-07-01'),
      renewalDate: ISODate('2023-08-01'),
      paymentMethod: 'credit card',
      paymentHistory: [
        {
          date: ISODate('2023-07-01'),
          orderNumber: 'ORD001',
          total: 9.99,
        },
        {
          date: ISODate('2023-08-01'),
          orderNumber: 'ORD002',
          total: 9.99,
        },
      ],
      paymentDetails: {
        cardNumber: '**** **** **** 1234',
        expiryMonth: '12',
        expiryYear: '2025',
        securityCode: '123',
      },
    },
  },
  {
    _id: premiumUserIds[1],
    email: 'example3@example.com',
    password: 'password789',
    username: 'exampleuser3',
    dateOfBirth: ISODate('1992-03-03'),
    sex: 'male',
    country: 'Australia',
    postalCode: '54321',
    followedArtists: [artistIds[0], artistIds[1]],
    favoriteAlbums: [albumIds[0], albumIds[1]], 
    favoriteSongs: [musicIds[0], musicIds[1]],
    userType: 'premium',
    subscription: {
      startDate: ISODate('2023-07-01'),
      renewalDate: ISODate('2023-08-01'),
      paymentMethod: 'PayPal',
      paymentHistory: [
        {
          date: ISODate('2023-07-01'),
          orderNumber: 'ORD003',
          total: 9.99,
        },
      ],
      paymentDetails: {
        paypalUsername: 'example3@example.com',
      },
    },
  },
  // Add more user documents
]);

db.playlists.insertMany([
  {
    _id: playlistIds[0],
    title: 'My Favorite Songs',
    numberOfSongs: 10,
    creationDate: ISODate('2023-07-01'),
    userId: userIds[0],
    deleted: false,
    deletedDate: null,
    type: 'active',
    sharedWith: [premiumUserIds[1]],
    songs: [musicIds[0], musicIds[1]],
  },
  {
    _id: playlistIds[1],
    title: 'Party Mix',
    numberOfSongs: 20,
    creationDate: ISODate('2023-07-02'),
    userId: userIds[1],
    deleted: false,
    deletedDate: null,
    type: 'active',
    sharedWith: [],
    songs: [musicIds[0], musicIds[1]],
  },
]);

db.playlists.updateOne(
  { _id: playlistIds[0] },
  {
    $set: {
      deleted: true,
      deletedDate: ISODate('2023-07-03'),
      type: 'deleted',
    },
  }
);

db.music.insertMany([
  {
    _id: musicIds[0],
    title: 'Song 1',
    duration: 180,
    timesPlayed: 1000,
    albumId: albumIds[0],
    artistId: artistIds[0],
    addedBy: [
      {
        userId: userIds[0],
        date: ISODate('2023-07-01'),
      },
    ],
  },
  {
    _id: musicIds[1],
    title: 'Song 2',
    duration: 200,
    timesPlayed: 1500,
    albumId: albumIds[0],
    artistId: artistIds[0],
    addedBy: [
      {
        userId: userIds[1],
        date: ISODate('2023-07-02'),
      },
    ],
  },
  // add more music documents
]);

db.albums.insertMany([
  {
    _id: albumIds[0],
    title: 'Album 1',
    year: 2022,
    coverImage: 'album1.jpg',
    songs: [musicIds[0], musicIds[1]],
    artistId: artistIds[0], 
  },
  // Add more album documents
]);

db.artists.insertMany([
  {
    _id: artistIds[0],
    name: 'Artist 1',
    image: 'artist1.jpg',
    relatedArtists: [artistIds[1], artistIds[2]],
  },
  // Add more artist documents
]);
