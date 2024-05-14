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
exports.onReviewCreate = functions.firestore.
    document("reviews/{reviewId}").onCreate(async (snapshot) => {
      const reviewData = snapshot.data();
      const userId = reviewData.userId;
      const userQuerySnapshot = await admin.firestore().
          collection("users").where("userId", "==", userId).get();
      if (!userQuerySnapshot.empty) {
        await userQuerySnapshot.docs[0].ref.
            update({reviewCount: admin.firestore.FieldValue.increment(1)});
      } else {
        console.log("User not found");
        return null;
      }
    });
exports.onReviewDelete = functions.firestore
    .document("reviews/{reviewId}")
    .onDelete(async (snapshot) => {
      const reviewData = snapshot.data();
      const userId = reviewData.userId;
      const userQuerySnapshot = await admin.firestore()
          .collection("users")
          .where("userId", "==", userId)
          .get();
      if (!userQuerySnapshot.empty) {
        await userQuerySnapshot.docs[0].ref
            .update({reviewCount: admin.firestore.FieldValue.increment(-1)});
      } else {
        console.log("User not found");
        return null;
      }
    });


