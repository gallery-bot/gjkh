'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "bd8b4c72dcdc0ce22b2c5915fa16c26e",
"/": "bd8b4c72dcdc0ce22b2c5915fa16c26e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/sounds/icon_choose.mp3": "eb3b9abeb1bed74623b8690a24ae8c0b",
"assets/sounds/short_press_like.mp3": "1ebd24cc9ef7426405d8e82f5037fc54",
"assets/sounds/box_up.mp3": "ff0fdcb1245318c63ec7d4d7ddefb7a8",
"assets/sounds/box_down.mp3": "c4d9310b6f4efad031b63cbcd8c9258e",
"assets/sounds/icon_focus.mp3": "ccf0ddc44269838eb514e07f31ea9020",
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
"assets/FontManifest.json": "18eda8e36dfa64f14878d07846d6e17f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/AssetManifest.json": "6bd6280c88304ecf01f7714935848d3e",
"assets/LICENSE": "8f3b2e66f7115492e3dc1ce399748fc6",
"assets/images/haha.gif": "b9cfa53d1c197f02870d3c8105f7fecb",
"assets/images/haha2.png": "a14eb1806fc08ca15b927724bfbc536d",
"assets/images/angry2.png": "aea763a94e4af2dffd718ddc4b41bb00",
"assets/images/like.gif": "14cb8e5c9949696df36fe4787521bf0f",
"assets/images/ic_like.png": "f36832e836f3b549c0b645db2e4b4f64",
"assets/images/sad2.png": "08b34fc8ebdd889b5039813c8524039c",
"assets/images/love.gif": "ac035abbf8fa0631cdcf9f17569b6f50",
"assets/images/wow2.png": "8727e1acfe20de708e32e62068d9717a",
"assets/images/ic_like_fill.png": "69b1bfddfff77967b6d600cf6f0b97d2",
"assets/images/angry.gif": "7b55ebf841b097d75c3a3efa7caf2135",
"assets/images/wow.gif": "9ce632aa816e765e36d2d37946b6a960",
"assets/images/love2.png": "c0a77e55cbe731d062ee59dbc5ec18d9",
"assets/images/sad.gif": "9fa24da8b75ac12313a9afb83f2c3e57",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "dccd5cb7c3df45ca5e4a7d5443928b49",
"manifest.json": "45f063870e5cf120a39396ce0a2a2312"
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
