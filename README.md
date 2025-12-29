# nodejs53-Sequelize-App-food
# Food Delivery API

Backend API cho ứng dụng đặt đồ ăn

## Cài đặt
npm install

## Chạy server
npm run dev

## API Endpoints

### Like nhà hàng
- POST /api/like
- DELETE /api/unlike
- GET /api/likes/restaurant/:res_id
- GET /api/likes/user/:user_id

### Rating nhà hàng  
- POST /api/rating
- GET /api/ratings/restaurant/:res_id
- GET /api/ratings/user/:user_id

### Order
- POST /api/order
- GET /api/orders/user/:user_id
