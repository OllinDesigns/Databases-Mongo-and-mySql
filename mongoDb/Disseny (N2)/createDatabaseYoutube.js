use ('youTube');

db.createCollection("users");
db.createCollection("videos");


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


class Video {
    static generateIds(num) {
      const videoIds = [];
      for (let i = 0; i < num; i++) {
        videoIds.push(new ObjectId());
      }
      return videoIds;
    }
  }
  
  const videoIds = Video.generateIds(10);

function userHasLikedOrDislikedVideo(userId, videoId, action) {
    const video = db.videos.findOne({ _id: videoId });
    if (!video) {
        throw new Error("Video not found.");
      }
    
      const likes = video.likes || [];
      const dislikes = video.dislikes || [];
    
      if (action === "like") {
        return likes.some(like => like.userId === userId);
      } else if (action === "dislike") {
        return dislikes.some(dislike => dislike.userId === userId);
      }
    
      throw new Error("Invalid action.");
    }
    
    function handleUserLikedVideoError(userId, videoId) {
        if (!userHasLikedOrDislikedVideo(userId, videoId, "like")) {
          throw new Error("User has not liked the video.");
        } else {
          throw new Error("User has already liked the video.");
        }
      }
      
    function handleUserDislikedVideoError(userId, videoId) {
      if (!userHasLikedOrDislikedVideo(userId, videoId, "dislike")) {
        throw new Error("User has not disliked the video.");
      } else {
        throw new Error("User has already disliked the video.");
      }
    }
      
      try {
        const userId = userIds[0];
        const videoId = videoIds[0];
      
        handleUserLikedVideoError(userId, videoId);
      } catch (error) {
        console.error("Error: " + error.message);
      }
      
      try {
        const userId = userIds[0];
        const videoId = videoIds[0];
      
        handleUserDislikedVideoError(userId, videoId);
      } catch (error) {
        console.error("Error: " + error.message);
      }
      
    
class Channel {
  static generateIds(num) {
    const channelIds = [];
    for (let i = 0; i < num; i++) {
      channelIds.push(new ObjectId());
    }
    return channelIds;
  }
}

const channelIds = Channel.generateIds(6);


class Comment {
  static generateIds(num) {
    const commentIds = [];
    for (let i = 0; i < num; i ++ ) {
      commentIds.push(new ObjectId());
    }
    return commentIds;
  }
}

const commentIds = Comment.generateIds(20);


function markComment(userId, commentId, action) {
    try {
      const user = db.users.findOne({ _id: userId });
      if (!user) {
        throw new Error("User not found.");
      }
  
      const comment = user.userComments.find((c) => c.commentId === commentId);
      if (!comment) {
        throw new Error("Comment not found.");
      }
  
      const existingLike = comment.likes.find((like) => like.userId === userId);
      const existingDislike = comment.dislikes.find((dislike) => dislike.userId === userId);
  
      if (action === "like") {
        if (existingLike) {
          throw new Error("User has already liked the comment.");
        }
        if (existingDislike) {
          comment.dislikes = comment.dislikes.filter((dislike) => dislike.userId !== userId);
        }
        comment.likes.push({ userId, likeDateTime: new Date() });
      } else if (action === "dislike") {
        if (existingDislike) {
          throw new Error("User has already disliked the comment.");
        }
        if (existingLike) {
          comment.likes = comment.likes.filter((like) => like.userId !== userId);
        }
        comment.dislikes.push({ userId, dislikeDateTime: new Date() });
      } else {
        throw new Error("Invalid action.");
      }
  
      // code to update the user document in the database
      db.users.updateOne({ _id: userId }, { $set: { userComments: user.userComments } });
    } catch (error) {
      console.error("Error: " + error.message);
    }
  }
  

class Playlist {
  static generateIds(num) {
    const playlistIds = [];
    for (let i = 0; i < num; i ++ ) {
      playlistIds.push(new ObjectId());
    }
    return playlistIds;
  }
}

const playlistIds = Playlist.generateIds(6);


class Tag {
  static generateIds(num) {
      const tagIds = [];
      for(let i = 0; i < num; i++) {
          tagIds.push(new ObjectId());
      }
      return tagIds;
  }
}

const tagIds = Tag.generateIds(6);


db.users.insertMany([
  {
    "_id": userIds[0],
    "email": "ade@example.com",
    "password": "password123",
    "name": "AdeOkafor",
    "birthdate": ISODate("1990-05-15"),
    "genre": "male",
    "country": "Nigeria",
    "postalcode": "23401",
    "publishedVideos": [
      {
        "videoId": videoIds[1]
      },
      {
        "videoId": videoIds[0]
      }
    ],
    "userChannels": [
      {
        "channelId": channelIds[0],
        "channelName": "perros",
        "channelCreationDate" : ISODate("2023-06-13T09:00:00Z"),
        "channelDescription" : "a channel about dogs",
        "channelSuscribers" : [
          {
            "channelSuscriberId" : userIds[2]
          },
          {
            "channelSuscriberId" : userIds[3]
          },
        ]
      },
      {
        "channelId": channelIds[1],
        "channelName": "I am the walrus",
        "channelCreationDate" : ISODate("2023-06-13T09:00:00Z"),
        "channelDescription" : "a channel about walrus",
        "channelSuscribers" : [
          {
            "channelSuscriberId" : userIds[3]
          },
          {
            "channelSuscriberId" : userIds[4]
          },
        ]
      }
        ],
    "userPlaylists": [
      {
        "playlistId": playlistIds[0],
        "playlistName": "Heavy Metal"
      }
    ],
    "userComments" : [
      {
        "commentId": commentIds[0],
        "commentText" : "blablabla",
        "commentOnVideo" : videoIds[0],
      }
    ]
  },
  {
    "_id": userIds[1],
    "email": "lucia@example.com",
    "password": "pass123",
    "name": "LuciaKamau",
    "birthdate": ISODate("1988-09-22"),
    "genre": "female",
    "country": "Kenya",
    "postalcode": "00505",
    "publishedVideos": [
      {
        "videoId": videoIds[4]
      },
      {
        "videoId": videoIds[5]
      }
    ],
    "userChannels": [
      {
        "channelId": channelIds[2],
        "channelName": "MMA",
        "channelCreationDate" : ISODate("2023-06-13T09:00:00Z"),
        "channelDescription" : "a channel about mixed martial arts",
        "channelSuscribers" : [
          {
            "channelSuscriberId" : userIds[5]
          },
          {
            "channelSuscriberId" : userIds[3]
          },
        ]
      },
    ]
  },
  {
    "_id": userIds[2],
    "email": "suleiman@example.com",
    "password": "mikepass",
    "name": "SuleimanMusa",
    "birthdate": ISODate("1995-02-10"),
    "genre": "male",
    "country": "Nigeria",
    "postalcode": "900001",
    "publishedVideos": [
      {
        "videoId": videoIds[1]
      },
    ],
    "userChannels": [
      {
        "channelId": channelIds[3],
        "channelName": "Vegan power",
        "channelCreationDate" : ISODate("2023-06-13T09:00:00Z"),
        "channelDescription" : "meat is murder",
        "channelSuscribers" : [
          {
            "channelSuscriberId" : userIds[2]
          },
        ]
      },
    ]
  },
  {
    "_id": userIds[3],
    "email": "adenike@example.com",
    "password": "password456",
    "name": "AdenikeAdeleke",
    "birthdate": ISODate("1992-07-08"),
    "genre": "female",
    "country": "Nigeria",
    "postalcode": "23401",
    "publishedVideos": [
      {
        "videoId": videoIds[2]
      },
    ],
    "userChannels": []
  },
  {
    "_id": userIds[4],
    "email": "kofi@example.com",
    "password": "alexpass",
    "name": "KofiAddo",
    "birthdate": ISODate("1993-11-30"),
    "genre": "male",
    "country": "Ghana",
    "postalcode": "00233",
    "publishedVideos": [
      {
        "videoId": videoIds[8]
      },
      {
        "videoId": videoIds[7]
      },
    ],
    "userChannels": [
      {
        "channelId": channelIds[4],
        "channelName": "footbal",
        "channelCreationDate" : ISODate("2023-06-13T09:00:00Z"),
        "channelDescription" : "the best goals",
        "channelSuscribers" : [
          {
            "channelSuscriberId" : userIds[2]
          },
          {
            "channelSuscriberId" : userIds[3]
          },
          {
            "channelSuscriberId" : userIds[6]
          },          
        ]
      },
      {
        "channelId": channelIds[5],
        "channelName": "I am the seal",
        "channelCreationDate" : ISODate("2023-06-13T09:00:00Z"),
        "channelDescription" : "a channel about seals",
        "channelSuscribers" : [
          {
            "channelSuscriberId" : userIds[3]
          },
        ]
      }
    ]
  },
  {
    "_id": userIds[5],
    "email": "abdul@example.com",
    "password": "passabdul",
    "name": "AbdulMohammed",
    "birthdate": ISODate("1987-03-20"),
    "genre": "male",
    "country": "Kenya",
    "postalcode": "00100",
    "publishedVideos": [
      {
        "videoId": videoIds[9]
      },
    ],
    "userChannels": []
  },
  // Add more user documents here if needed
]);

db.videos.insertMany([
  {
    "_id": videoIds[0],
    "title": "gluttonous fat cat",
    "description": "Funny Cat Compilation",
    "filename": "funny_cats.mp4",
    "duration": "180 min",
    "thumbnail": "cat_thumbnail.jpg",
    "numberOfReproductions": 5000,
    "likes": [
      {
        "userId": userIds[2],
        "likeDateTime": ISODate("2023-06-13T09:00:00Z")
      },
      {
        "userId": userIds[3],
        "likeDateTime": ISODate("2023-06-14T10:30:00Z")
      }
    ],
    "dislikes": [
      {
        "userId": userIds[0],
        "dislikeDateTime": ISODate("2023-06-15T14:45:00Z")
      },
      {
        "userId": userIds[5],
        "dislikeDateTime": ISODate("2023-06-16T16:20:00Z")
      }
    ],
    "state": "public",
    "publishedBy": userIds[4],
    "publishedDateTime": ISODate("2023-06-17T08:15:00Z"),
    "tags": [
      {
        "tagId": tagIds[0],
        "tagName": "funny"
      },
      {
        "tagId": tagIds[1],
        "tagName": "turtles"
      },
      {
        "tagId" : tagIds[2],
        "tagName" : "sport",
      },
      {
        "tagId" : tagIds[3],
        "tagName" : "creepy",
      },
      {
        "tagId" : tagIds[4],
        "tagName" : "Horror",
      },
    ]
  },
  {
    "_id": videoIds[1],
    "title": "Travel Vlog: Exploring Bali",
    "description": "bali_travel_vlog.mp4",
    "filename": "bali_thumbnail.jpg",
    "duration": "18 min",
    "thumbnail": "bali_thumbnail.jpg",
    "numberOfReproductions": 10000,
    "likes": [
      {
        "userId": userIds[0],
        "likeDateTime": ISODate("2023-06-13T10:30:00Z")
      }
    ],
    "dislikes": [
      {
        "userId": userIds[1],
        "dislikeDateTime": ISODate("2023-06-13T10:30:00Z")
      }
    ],
    "state": "public",
    "publishedBy": userIds[1],
    "publishedDateTime": ISODate("2023-06-13T10:30:00Z")
  },

  {
    "_id": videoIds[2],
    "title": "Cooking Tutorial: Chocolate Cake",
    "description": "chocolate_cake_tutorial.mp4",
    "filename": "cake_thumbnail.jpg",
    "duration": "22min",
    "thumbnail": "cake_thumbnail.jpg",
    "numberOfReproductions": 7500,
    "likes": [],
    "dislikes": [],
    "state": "hidden",
    "publishedBy": userIds[2],
    "publishedDateTime": ISODate("2023-06-13T12:15:00Z")
  },
  {
    "_id": videoIds[3],
    "title": "Guitar Lesson: Beginner Basics",
    "description": "guitar_lesson_beginner.mp4",
    "filename": "guitar_thumbnail.jpg",
    "duration": "666 min",
    "thumbnail": "guitar_thumbnail.jpg",
    "numberOfReproductions": 3000,
    "likes": [
      {
        "userId": userIds[3],
        "likeDateTime": ISODate("2023-06-13T14:00:00Z")
      }
    ],
    "dislikes": [
      {
        "userId": userIds[3],
        "dislikeDateTime": ISODate("2023-06-13T14:00:00Z")
      }
    ],
    "state": "public",
    "publishedBy": userIds[4],
    "publishedDateTime": ISODate("2023-06-13T14:00:00Z")
  },
  {
    "_id": videoIds[4],
    "title": "Fitness Workout: HIIT Training",
    "description": "hiit_workout.mp4",
    "filename": "fitness_thumbnail.jpg",
    "duration": "69 min",
    "thumbnail": "fitness_thumbnail.jpg",
    "numberOfReproductions": 6000,
    "likes": [
      {
        "userId": userIds[3],
        "likeDateTime": ISODate("2023-06-13T16:30:00Z")
      }
    ],
    "dislikes": [
      {
        "userId": userIds[4],
        "dislikeDateTime": ISODate("2023-06-13T16:30:00Z")
      }
    ],
    "state": "private",
    "publishedBy": userIds[5]
    }   
  
  // Add more video documents if needed
]);