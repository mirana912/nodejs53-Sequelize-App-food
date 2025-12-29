// src/controllers/ratingController.js
const pool = require("../config/database");
const ratingController = {
  // POST /api/rating - Thêm đánh giá nhà hàng
  addRating: async (req, res) => {
    try {
      const { user_id, res_id, amount } = req.body;

      // Validate input
      if (!user_id || !res_id || !amount) {
        return res.status(400).json({
          success: false,
          message: "user_id, res_id và amount là bắt buộc",
        });
      }

      // Validate rating amount (1-5 stars)
      if (amount < 1 || amount > 5) {
        return res.status(400).json({
          success: false,
          message: "Điểm đánh giá phải từ 1 đến 5",
        });
      }

      // Check if already rated
      const [existing] = await pool.execute(
        "SELECT * FROM rate_res WHERE user_id = ? AND res_id = ?",
        [user_id, res_id]
      );

      if (existing.length > 0) {
        // Update existing rating
        await pool.execute(
          "UPDATE rate_res SET amount = ?, date_rate = NOW() WHERE user_id = ? AND res_id = ?",
          [amount, user_id, res_id]
        );

        return res.status(200).json({
          success: true,
          message: "Cập nhật đánh giá thành công",
          data: {
            user_id,
            res_id,
            amount,
            date_rate: new Date(),
          },
        });
      }

      // Insert new rating
      await pool.execute(
        "INSERT INTO rate_res (user_id, res_id, amount, date_rate) VALUES (?, ?, ?, NOW())",
        [user_id, res_id, amount]
      );

      res.status(201).json({
        success: true,
        message: "Thêm đánh giá thành công",
        data: {
          user_id,
          res_id,
          amount,
          date_rate: new Date(),
        },
      });
    } catch (error) {
      console.error("Error in addRating:", error);
      res.status(500).json({
        success: false,
        message: "Lỗi server",
        error: error.message,
      });
    }
  },

  // GET /api/ratings/restaurant/:res_id - Lấy danh sách đánh giá theo nhà hàng
  getRatingsByRestaurant: async (req, res) => {
    try {
      const { res_id } = req.params;

      const [ratings] = await pool.execute(
        `SELECT 
          rr.user_id,
          rr.res_id,
          rr.amount,
          rr.date_rate,
          u.full_name,
          u.email
        FROM rate_res rr
        INNER JOIN user u ON rr.user_id = u.user_id
        WHERE rr.res_id = ?
        ORDER BY rr.date_rate DESC`,
        [res_id]
      );

      // Calculate average rating
      const avgRating =
        ratings.length > 0
          ? ratings.reduce((sum, r) => sum + r.amount, 0) / ratings.length
          : 0;

      res.status(200).json({
        success: true,
        message: "Lấy danh sách đánh giá thành công",
        total: ratings.length,
        average_rating: parseFloat(avgRating.toFixed(2)),
        data: ratings,
      });
    } catch (error) {
      console.error("Error in getRatingsByRestaurant:", error);
      res.status(500).json({
        success: false,
        message: "Lỗi server",
        error: error.message,
      });
    }
  },

  // GET /api/ratings/user/:user_id - Lấy danh sách đánh giá theo user
  getRatingsByUser: async (req, res) => {
    try {
      const { user_id } = req.params;

      const [ratings] = await pool.execute(
        `SELECT 
          rr.user_id,
          rr.res_id,
          rr.amount,
          rr.date_rate,
          r.res_name,
          r.image,
          r.desc
        FROM rate_res rr
        INNER JOIN restaurant r ON rr.res_id = r.res_id
        WHERE rr.user_id = ?
        ORDER BY rr.date_rate DESC`,
        [user_id]
      );

      res.status(200).json({
        success: true,
        message: "Lấy danh sách đánh giá thành công",
        total: ratings.length,
        data: ratings,
      });
    } catch (error) {
      console.error("Error in getRatingsByUser:", error);
      res.status(500).json({
        success: false,
        message: "Lỗi server",
        error: error.message,
      });
    }
  },
};

module.exports = ratingController;

// ============================================
