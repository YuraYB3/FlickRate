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

exports.onMovieUpdated = functions.firestore.document("movies/{movieID}")
    .onUpdate((change) => {
      const updatedDocument = change.after.data();
      const documentId = change.after.id;
      const previousDocument = change.before.data();
      console.log("Document updated with ID:", documentId);
      console.log("Previous document data:", previousDocument);
      console.log("Updated document data:", updatedDocument);
    });

exports.onMovieDeleted = functions.firestore.document("movies/{movieID}")
    .onDelete((snapshot) => {
      const deletedDocument = snapshot.data();
      const documentId = snapshot.id;
      console.log("Document deleted with ID:", documentId);
      console.log("Deleted document data:", deletedDocument);
    });

exports.onNewAuth = functions.auth.user().onCreate((user) => {
  const userId = user.uid;
  const documentId = admin.firestore().collection("users").doc().id;
  const userProfileRef = admin.firestore().collection("users").doc(documentId);
  const defaultProfileImage = "https://firebasestorage.googleapis.com/v0/b/flickrate-b668e.appspot.com/o/default%2Fimage_default.png?alt=media&token=ac38e584-5776-4308-ae87-27009e002fe5";

  let userProfileImage = defaultProfileImage;

  const googleProvider = user.providerData.
      find((provider) => provider.providerId === "google.com");
  if (googleProvider) {
    userProfileImage = googleProvider.photoURL;
  }

  const userProfileData = {
    documentId: documentId,
    userId: userId,
    userProfileImage: userProfileImage,
  };

  return userProfileRef.set(userProfileData);
});


