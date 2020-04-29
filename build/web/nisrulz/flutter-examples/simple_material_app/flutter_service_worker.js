'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "4b656e7bb4eba8e3a31f9dc3e3cd831b",
"/": "4b656e7bb4eba8e3a31f9dc3e3cd831b",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"assets/packages/flutter_showcase/assets/flutter.png": "d21f1eecaeaab081ba7efec1721c0712",
"assets/packages/flutter_showcase/assets/dart.png": "f3ae419dc11ddc054a8725e2cbab4939",
"assets/packages/flutter_showcase/assets/flutter_white.png": "91cbceb6f4b8345f509ba4cde4bdcee5",
"assets/packages/flutter_showcase/assets/flutter_black.png": "3e4d716d500f9d0b927f55c48379289a",
"assets/packages/flutter_showcase/assets/github.png": "3e54ed15b9cd877c5223f5ecf64579df",
"assets/packages/flutter_showcase/assets/flutter_original.png": "cf171b29e3b2c0cb9a12223f952da7c6",
"assets/FontManifest.json": "5fa2baa1355ee1ffd882bec6ab6780c7",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/AssetManifest.json": "ee23c2a93a811b2b2e27991ae4755b48",
"assets/LICENSE": "0f89873f07f178d0119365ece7ac4a31",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "eb8e34012a52bd6c3364a7ac51af5679",
"manifest.json": "306d236776e7f8d4a1e8ed735b68027d"
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
