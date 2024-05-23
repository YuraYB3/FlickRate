const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


exports.onNewAuth = functions.auth.user().onCreate((user) => {
  const userId = user.uid;
  const documentId = admin.firestore().collection("users").doc().id;
  const userProfileRef = admin.firestore().collection("users").doc(documentId);
  const defaultProfileImage = "https://firebasestorage.googleapis.com/v0/b/flickrate-b668e.appspot.com/o/default%2Fimage_default.png?alt=media&token=ac38e584-5776-4308-ae87-27009e002fe5";

  let userProfileImage = defaultProfileImage;
  let userName = "user";
  const reviewCount = 0;
  const userLikes = 0;

  const googleProvider = user.providerData.
      find((provider) => provider.providerId === "google.com");
  if (googleProvider) {
    userProfileImage = googleProvider.photoURL;
    userName = googleProvider.displayName;
  }

  const userProfileData = {
    documentId: documentId,
    userId: userId,
    userProfileImage: userProfileImage,
    userName: userName,
    userLikes: userLikes,
    reviewCount: reviewCount,
  };

  return userProfileRef.set(userProfileData);
},
);

/**
 * Update user reviews count
 * @param {string} userId - for concrete user
 * @param {number} incrementValue - 1 or -1 for increment or decrement
 * @return {Promise<void>}
 */
async function updateUserReviewCount(userId, incrementValue) {
  const userQuerySnapshot = await admin.firestore()
      .collection("users")
      .where("userId", "==", userId)
      .get();

  if (!userQuerySnapshot.empty) {
    await userQuerySnapshot.docs[0].ref
        .update({reviewCount: admin.firestore.FieldValue.
            increment(incrementValue)});
  } else {
    console.log("User not found");
  }
}
/**
 * Update movie reviews count
 * @param {string} movieId -for concrete movie
 * @param {number} incrementValue - 1 or -1 for increment or decrement
 * @return {Promise<void>}
 */
async function updateMovieReviewCountAndRating(movieId, incrementValue) {
  const movieQuerySnapshot = await admin.firestore()
      .collection("movies")
      .where("documentId", "==", movieId)
      .get();

  if (!movieQuerySnapshot.empty) {
    await movieQuerySnapshot.docs[0].ref
        .update({numberOfReviews: admin.firestore.FieldValue.
            increment(incrementValue)});

    const reviewsSnapshot = await admin.firestore()
        .collection("reviews")
        .where("movieId", "==", movieId)
        .get();

    let totalRating = 0;
    let reviewCount = 0;

    reviewsSnapshot.forEach((doc) => {
      totalRating += doc.data().rating;
      reviewCount++;
    });

    const newRating = reviewCount > 0 ? totalRating / reviewCount : 0;

    await movieQuerySnapshot.docs[0].ref.update({movieRating: newRating});
  } else {
    console.log("Movie not found");
  }
}

exports.onReviewCreate = functions.firestore
    .document("reviews/{reviewId}")
    .onCreate(async (snapshot) => {
      const reviewData = snapshot.data();
      const userId = reviewData.userId;
      const movieId = reviewData.movieId;

      await updateUserReviewCount(userId, 1);
      await updateMovieReviewCountAndRating(movieId, 1);
    });

exports.onReviewDelete = functions.firestore
    .document("reviews/{reviewId}")
    .onDelete(async (snapshot) => {
      const reviewData = snapshot.data();
      const userId = reviewData.userId;
      const movieId = reviewData.movieId;

      await updateUserReviewCount(userId, -1);
      await updateMovieReviewCountAndRating(movieId, -1);
    });

exports.pickDailyMovie = functions.pubsub.schedule("every day 00:00").
    timeZone("Europe/Kiev").onRun(async (context) => {
      const moviesCollection = admin.firestore().collection("movies");
      const dailyMovieCollection = admin.firestore().collection("daily_movie");

      try {
        const moviesSnapshot = await moviesCollection.get();
        const movies = [];

        moviesSnapshot.forEach((doc) => {
          movies.push({id: doc.id, ...doc.data()});
        });

        if (movies.length === 0) {
          console.log("No movies found");
          return null;
        }

        const randomMovie = movies[Math.floor(Math.random() * movies.length)];

        await dailyMovieCollection.doc("today").set(randomMovie);

        console.log("Daily movie selected:", randomMovie);
      } catch (error) {
        console.error("Error picking daily movie:", error);
      }

      return null;
    });


