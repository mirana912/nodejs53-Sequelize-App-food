// src/controllers/orderController.js
// ============================================
const pool = require("../config/database");
const orderController = {
  // POST /api/order - User đặt món
  createOrder: async (req, res) => {
    try {
      const { user_id, food_id, amount, arr_sub_id } = req.body;

      // Validate input
      if (!user_id || !food_id || !amount) {
        return res.status(400).json({
          success: false,
          message: "user_id, food_id và amount là bắt buộc",
        });
      }

      if (amount < 1) {
        return res.status(400).json({
          success: false,
          message: "Số lượng phải lớn hơn 0",
        });
      }

      // Generate order code
      const code = `ORD${Date.now()}${Math.floor(Math.random() * 1000)}`;

      // Convert arr_sub_id to string
      const subIdsString = arr_sub_id ? JSON.stringify(arr_sub_id) : null;

      // Insert order
      const [result] = await pool.execute(
        "INSERT INTO `order` (user_id, food_id, amount, code, arr_sub_id) VALUES (?, ?, ?, ?, ?)",
        [user_id, food_id, amount, code, subIdsString]
      );

      // Get order details
      const [orderDetails] = await pool.execute(
        `SELECT 
          o.user_id,
          o.food_id,
          o.amount,
          o.code,
          o.arr_sub_id,
          f.food_name,
          f.price,
          f.image,
          (f.price * o.amount) as total_price
        FROM \`order\` o
        INNER JOIN food f ON o.food_id = f.food_id
        WHERE o.code = ?`,
        [code]
      );

      res.status(201).json({
        success: true,
        message: "Đặt món thành công",
        data: orderDetails[0],
      });
    } catch (error) {
      console.error("Error in createOrder:", error);
      res.status(500).json({
        success: false,
        message: "Lỗi server",
        error: error.message,
      });
    }
  },

  // GET /api/orders/user/:user_id - Lấy danh sách order theo user
  getOrdersByUser: async (req, res) => {
    try {
      const { user_id } = req.params;

      const [orders] = await pool.execute(
        `SELECT 
          o.user_id,
          o.food_id,
          o.amount,
          o.code,
          o.arr_sub_id,
          f.food_name,
          f.price,
          f.image,
          f.desc,
          ft.type_name,
          (f.price * o.amount) as total_price
        FROM \`order\` o
        INNER JOIN food f ON o.food_id = f.food_id
        INNER JOIN food_type ft ON f.type_id = ft.type_id
        WHERE o.user_id = ?
        ORDER BY o.code DESC`,
        [user_id]
      );

      // Parse arr_sub_id if exists
      const ordersWithParsedSubs = orders.map((order) => {
        let parsedSubIds = [];
        if (order.arr_sub_id) {
          try {
            //Try to parse if it's a JSON string
            parsedSubIds = JSON.parse(order.arr_sub_id);
          } catch (e) {
            // If parse fails, treat as empty array
            console.warn(
              `Failed to parse arr_sub_id for order ${order.code}:`,
              e.message
            );
            parsedSubIds = [];
          }
        }
        return {
          ...order,
          arr_sub_id: parsedSubIds,
        };
      });

      res.status(200).json({
        success: true,
        message: "Lấy danh sách đơn hàng thành công",
        total: orders.length,
        data: ordersWithParsedSubs,
      });
    } catch (error) {
      console.error("Error in getOrdersByUser:", error);
      res.status(500).json({
        success: false,
        message: "Lỗi server",
        error: error.message,
      });
    }
  },
};

module.exports = orderController;
// ============================================
