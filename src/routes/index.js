// FILE: src/routes/index.js
// ============================================
const express = require("express");
const router = express.Router();

const likeController = require("../controllers/likeController");
const ratingController = require("../controllers/ratingController");
const orderController = require("../controllers/orderController");

// ===== LIKE ROUTES =====
router.post("/like", likeController.likeRestaurant);
router.delete("/unlike", likeController.unlikeRestaurant);
router.get("/likes/restaurant/:res_id", likeController.getLikesByRestaurant);
router.get("/likes/user/:user_id", likeController.getLikesByUser);

// ===== RATING ROUTES =====
router.post("/rating", ratingController.addRating);
router.get(
  "/ratings/restaurant/:res_id",
  ratingController.getRatingsByRestaurant
);
router.get("/ratings/user/:user_id", ratingController.getRatingsByUser);

// ===== ORDER ROUTES =====
router.post("/order", orderController.createOrder);
router.get("/orders/user/:user_id", orderController.getOrdersByUser);

module.exports = router;

// ============================================
