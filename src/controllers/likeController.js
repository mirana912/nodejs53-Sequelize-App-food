// src/controllers/likeController.js
// ============================================
const pool = require("../config/database");

const likeController = {
  // POST /api/like - Like nhà hàng
  likeRestaurant: async (req, res) => {
    try {
      const { user_id, res_id } = req.body;

      // Validate input
      if (!user_id || !res_id) {
        return res.status(400).json({
          success: false,
          message: "user_id và res_id là bắt buộc",
        });
      }

      // Check if already liked
      const [existing] = await pool.execute(
        "SELECT * FROM like_res WHERE user_id = ? AND res_id = ?",
        [user_id, res_id]
      );

      if (existing.length > 0) {
        return res.status(400).json({
          success: false,
          message: "Bạn đã like nhà hàng này rồi",
        });
      }

      // Insert like
      const [result] = await pool.execute(
        "INSERT INTO like_res (user_id, res_id, date_like) VALUES (?, ?, NOW())",
        [user_id, res_id]
      );

      res.status(201).json({
        success: true,
        message: "Like nhà hàng thành công",
        data: {
          user_id,
          res_id,
          date_like: new Date(),
        },
      });
    } catch (error) {
      console.error("Error in likeRestaurant:", error);
      res.status(500).json({
        success: false,
        message: "Lỗi server",
        error: error.message,
      });
    }
  },

  // DELETE /api/unlike - Unlike nhà hàng
  unlikeRestaurant: async (req, res) => {
    try {
      const { user_id, res_id } = req.body;

      // Validate input
      if (!user_id || !res_id) {
        return res.status(400).json({
          success: false,
          message: "user_id và res_id là bắt buộc",
        });
      }

      // Delete like
      const [result] = await pool.execute(
        "DELETE FROM like_res WHERE user_id = ? AND res_id = ?",
        [user_id, res_id]
      );

      if (result.affectedRows === 0) {
        return res.status(404).json({
          success: false,
          message: "Không tìm thấy like để xóa",
        });
      }

      res.status(200).json({
        success: true,
        message: "Unlike nhà hàng thành công",
      });
    } catch (error) {
      console.error("Error in unlikeRestaurant:", error);
      res.status(500).json({
        success: false,
        message: "Lỗi server",
        error: error.message,
      });
    }
  },

  // GET /api/likes/restaurant/:res_id - Lấy danh sách like theo nhà hàng
  getLikesByRestaurant: async (req, res) => {
    try {
      const { res_id } = req.params;

      const [likes] = await pool.execute(
        `SELECT 
          lr.user_id,
          lr.res_id,
          lr.date_like,
          u.full_name,
          u.email
        FROM like_res lr
        INNER JOIN user u ON lr.user_id = u.user_id
        WHERE lr.res_id = ?
        ORDER BY lr.date_like DESC`,
        [res_id]
      );

      res.status(200).json({
        success: true,
        message: "Lấy danh sách like thành công",
        total: likes.length,
        data: likes,
      });
    } catch (error) {
      console.error("Error in getLikesByRestaurant:", error);
      res.status(500).json({
        success: false,
        message: "Lỗi server",
        error: error.message,
      });
    }
  },

  // GET /api/likes/user/:user_id - Lấy danh sách like theo user
  getLikesByUser: async (req, res) => {
    try {
      const { user_id } = req.params;

      const [likes] = await pool.execute(
        `SELECT 
          lr.user_id,
          lr.res_id,
          lr.date_like,
          r.res_name,
          r.image,
          r.desc
        FROM like_res lr
        INNER JOIN restaurant r ON lr.res_id = r.res_id
        WHERE lr.user_id = ?
        ORDER BY lr.date_like DESC`,
        [user_id]
      );

      res.status(200).json({
        success: true,
        message: "Lấy danh sách like thành công",
        total: likes.length,
        data: likes,
      });
    } catch (error) {
      console.error("Error in getLikesByUser:", error);
      res.status(500).json({
        success: false,
        message: "Lỗi server",
        error: error.message,
      });
    }
  },
};

module.exports = likeController;

// ============================================
