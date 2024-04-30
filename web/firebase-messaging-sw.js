importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: 'AIzaSyB8isyPP32vRgMTtTc66OGFWf9mSayuGWI',
    appId: '1:78116113745:web:ac096cbeb9283f486e5770',
    messagingSenderId: '78116113745',
    projectId: 'rosheta-b6472',
    authDomain: 'rosheta-b6472.firebaseapp.com',
    storageBucket: 'rosheta-b6472.appspot.com',
    measurementId: 'G-1XRWZPNC9Z',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});