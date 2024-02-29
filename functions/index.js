const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sayHello = functions.https.onCall(()=>{
  return "Hi there";
});

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

