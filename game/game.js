/* Galaga - Vanilla JavaScript + HTML5 Canvas 
No frameworks, no build steps. The whole game runs client-side, which is why it containerizers so cleanly.
It's just static files served by a web server.

Assets: drop player.png, enemy.png, and bullet.png into the ./assets/. If an image is missing or fails 
to load, the game draws a colored shape instead, so it stays playable even before you add art.
*/

(() => {
    "use strict";

    // Canvas & context
    const canvas = document.getElementById("game");
    const ctx = canvas.getContext("2d");
    const W = canvas.width;
    const H = canvas.height;

    // HUD elements
    const scoreEl = document.getElementById("score");
    const highEl = document.getElementById("highscore");
    const livesEl = document.getElementById("lives");
    const overlay = document.getElementById("overlay");
    const overlayTitle = document.getElementById("overlay-title");
    const overlayText = document.getElementById("overlay-text");

    // asset loading (with graceful fallback)
    function loadImage(src) {
        const img = new Image();
        img.loaded = false;
        img.onload = () => (img.loaded = true);
        img.onerror = () => (img.loaded = false); // fall back option to colored shapes
        img.src = src;
        return img;
    }

    const sprites = {
        player: loadImage("assets/player.png"),
        enemy: loadImage("assets/enemy.png"),
        bullet: loadImage("assets/bullet.png"),
    };

    // game state
    const STATE = { MENU: "menu", PLAYING: "playing", OVER: "over" };
    let state = STATE.MENU;

    let score = 0;
    let highScore = Number(localStorage.getItem("galaga-high") || 0);
    let lives = 3;

    highEl.textContent = highScore;

    // Player
    const player = {
        w: 40,
        h: 40,
        x: W / 2 - 20,
        y: H - 60,
        speed: 5,
        cooldown: 0, //frames until next shot allowed
    };

    // Entity arrays
    let bullets = []; // player bullets
    let enemyBullets = [];
    let enemies = [];

    // formation movement (idle side to side drift)
    let formationDir = 1; // 1 = right, -1 = left
    let formationSpeed = 0.6;
}

)