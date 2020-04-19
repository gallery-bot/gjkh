'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "8ab62934f6b64617ffb02dbf818fd763",
"/": "8ab62934f6b64617ffb02dbf818fd763",
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
"assets/assets/albums.json": "9ec560cc78a733dd3a2b12c17719efc9",
"assets/FontManifest.json": "18eda8e36dfa64f14878d07846d6e17f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/AssetManifest.json": "9eace89f53b643eaaa74149a28911a56",
"assets/LICENSE": "d5ec9e1355568a8477890f7fd70fc2ad",
"assets/images/dash_dart_dark.png": "ed4a76c0ff90ce740861e2f7bce8a853",
"assets/images/dash_dart.png": "742d2248e4b76e1d4021dcb7d43e141d",
"assets/images/mesi.png": "1193e84d0125ad7cc86649198f0386c6",
"assets/images/characters/vegeta.png": "478e4df9b97bd112fa5921bfaedbdcdc",
"assets/images/characters/gohan.png": "dbd1a7f3845927a00390605e6bbb1b7d",
"assets/images/characters/boo.png": "c8d39aa35d9491e17f267012b6516b1c",
"assets/images/characters/frieza.png": "d32807fb626d788865ccbaebaf66dfbc",
"assets/images/characters/broly.png": "d27d85090b3d757b535862029ef9d838",
"assets/images/characters/cell.png": "0bc07dc7183778fe884bae8c7ed970ea",
"assets/images/characters/goku.png": "24a923b922c5f6511903cbf4069183e6",
"assets/images/twitter_flutter_bg.png": "f179e6f3c18556c70fdcf58fe0fa28d6",
"assets/images/credit_cards/chip.png": "32228bc7f27a6d4f5efb6bfb23f3d8ad",
"assets/images/credit_cards/chip_logo.png": "3bef268e9de7dfc96f587a287e86100b",
"assets/images/shoes/2.png": "a0cd607237ec1cb0683f4206996299dd",
"assets/images/shoes/3.png": "8ea360e79f98624d080d16ab5dfd4d33",
"assets/images/shoes/4.png": "50cf016f0231bf6d5dae9b3dfe3305a5",
"assets/images/shoes/1.png": "7fc2c6b1334a9fa685336aca4ad846b5",
"assets/images/twitter_flutter_logo.jpg": "8a7ecc44800a7d19fea8380929cf5757",
"assets/images/mario_logo.png": "daf731f8c7df30ccae9c991edaaeba39",
"assets/images/balls/ball2.png": "85f2db46c56aa9f8db188e8d8e42d940",
"assets/images/balls/ball1.png": "a1163f2d7cf83328a7b62c1f8d7ef8d9",
"assets/images/balls/ball3.png": "77dd6e807f3bc50ac4227b08269dbffc",
"assets/images/balls/ball4.png": "8241ae73551acb56b9d615871c0535c2",
"main.dart.js": "6e3820dd286c0ef3bae5d9ce488e9e3f"
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
