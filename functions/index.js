const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


exports.incrementRating = functions.https.onCall(async (data) => {
  try {
    const movieId = data.movieId;
    console.log("Movie id =" + movieId);
    if (!movieId) {
      throw new Error("MovieId parameter is missing");
    }
    const movieRef = admin.firestore().collection("movies").doc(movieId);
    const movieDoc = await movieRef.get();
    if (!movieDoc.exists) {
      throw new Error("MovieId not found");
    }
    const currentRating = movieDoc.data().rating;
    const updatedRating = parseFloat((currentRating + 0.1).toFixed(1));
    await movieRef.update({rating: updatedRating});
    return {message: "Rating incremented successfully"};
  } catch (error) {
    console.error("Error incrementing rating:", error);
  }
});

exports.decrementRating = functions.https.onCall(async (data) => {
  try {
    const movieId = data.movieId;
    console.log("Movie id =" + movieId);
    if (!movieId) {
      throw new Error("MovieId parameter is missing");
    }
    const movieRef = admin.firestore().collection("movies").doc(movieId);
    const movieDoc = await movieRef.get();
    if (!movieDoc.exists) {
      throw new Error("MovieId not found");
    }
    const currentRating = movieDoc.data().rating;
    const updatedRating = parseFloat((currentRating - 0.1).toFixed(1));
    await movieRef.update({rating: updatedRating});
    return {message: "Rating decremented successfully"};
  } catch (error) {
    console.error("Error decrementing rating:", error);
  }
});

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
exports.onReviewCreate = functions.firestore.
    document("reviews/{reviewId}").onCreate(async (snapshot) => {
      const reviewData = snapshot.data();
      const movieId = reviewData.movieId;
      const userId = reviewData.userId;

      const movieRef = admin.firestore().collection("movies").doc(movieId);
      const movieSnapshot = await movieRef.get();

      if (movieSnapshot.exists) {
        const movieData = movieSnapshot.data();
        const movieGenre = movieData.movieGenre;
        const movieName = movieData.movieName;

        await snapshot.ref.update({movieGenre: movieGenre,
          movieName: movieName});
        const userQuerySnapshot = await admin.firestore().
            collection("users").where("userId", "==", userId).get();
        if (!userQuerySnapshot.empty) {
          const userDocRef = userQuerySnapshot.docs[0].ref;
          return userDocRef.update({reviewCount: admin.firestore.
              FieldValue.increment(1)});
        } else {
          console.log("User not found");
          return null;
        }
      } else {
        console.log("Movie not found");
        return null;
      }
    });

