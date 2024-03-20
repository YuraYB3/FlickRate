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
  };

  return userProfileRef.set(userProfileData);
},
);


