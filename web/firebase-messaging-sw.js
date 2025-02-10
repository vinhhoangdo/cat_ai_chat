// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");

const firebaseConfig = {
  apiKey: "AIzaSyBtCR5rHQ3C_G39ehobRbQQG1RGI3-ahVQ",
  authDomain: "simple-chat-app-5840f.firebaseapp.com",
  projectId: "simple-chat-app-5840f",
  storageBucket: "simple-chat-app-5840f.firebasestorage.app",
  messagingSenderId: "346724123785",
  appId: "1:346724123785:web:db564271dbfdf28285f258",
  measurementId: "G-R9N6TFMP3G"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();