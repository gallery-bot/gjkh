'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "4a0667cd3b6d180b0afd89a2d691abd0",
"/": "4a0667cd3b6d180b0afd89a2d691abd0",
"icons/image.png": "67a5713828d6376924dae3e846725009",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/flutter_showcase/assets/flutter.png": "d21f1eecaeaab081ba7efec1721c0712",
"assets/packages/flutter_showcase/assets/dart.png": "f3ae419dc11ddc054a8725e2cbab4939",
"assets/packages/flutter_showcase/assets/flutter_white.png": "91cbceb6f4b8345f509ba4cde4bdcee5",
"assets/packages/flutter_showcase/assets/flutter_black.png": "3e4d716d500f9d0b927f55c48379289a",
"assets/packages/flutter_showcase/assets/github.png": "3e54ed15b9cd877c5223f5ecf64579df",
"assets/packages/flutter_showcase/assets/flutter_original.png": "cf171b29e3b2c0cb9a12223f952da7c6",
"assets/assets/flutter.png": "d21f1eecaeaab081ba7efec1721c0712",
"assets/assets/mail.png": "dc55662a996e5617957530fe4d32d06a",
"assets/assets/message.png": "4ab37fd9235ee454ef36d904f80502ff",
"assets/assets/twitter.png": "4907a786377fe693a9aa563792728683",
"assets/assets/slack.png": "efd8727d64d49659d14eee20476f8de7",
"assets/assets/person1.jpeg": "1d93c1b598e0378af0ce618fa39b2f19",
"assets/assets/github.png": "3e54ed15b9cd877c5223f5ecf64579df",
"assets/assets/MacBook.jpg": "3d3f92faf14d52e12c8a8583a2cf30c2",
"assets/assets/person2.jpeg": "94bd58214363da080f5c92298a4cb1ef",
"assets/assets/jaimeblasco.jpeg": "52e200d3b4ec4978617490d949f90d0e",
"assets/assets/demo_image.jpeg": "4129427d4b3d8ffbfda70b0bae61400b",
"assets/assets/person3.jpeg": "68f7f58edb11830b0525a4c65cc3a845",
"assets/assets/person4.jpeg": "2e9b5940fd621cd2b6ef87652e922100",
"assets/assets/github_app.png": "1fbf1eeb622038a1ea2e62036d33788a",
"assets/FontManifest.json": "18eda8e36dfa64f14878d07846d6e17f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/AssetManifest.json": "094baba6da780b0da79f31ffbffb0092",
"assets/LICENSE": "69112e10eb95eb1d40a263edad826d9e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "d01284b527abcf189b01bcebd37d03bc",
"manifest.json": "00e0b69b49487ce4f9ff0c5fac8fda49"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
