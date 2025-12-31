# nodejs53-Sequelize-App-food

<<<<<<< HEAD

# Food Delivery API

Backend API cho ứng dụng giao đồ ăn với Node.js + Express + MySQL

## Mục lục

- [Giới thiệu](#giới-thiệu)
- [Công nghệ sử dụng](#công-nghệ-sử-dụng)
- [Cài đặt](#cài-đặt)
- [Cấu trúc Database](#cấu-trúc-database)
- [API Endpoints](#api-endpoints)
- [Chạy ứng dụng](#chạy-ứng-dụng)
- [Test API](#test-api)

## Giới thiệu

Dự án API RESTful cho ứng dụng giao đồ ăn bao gồm các chức năng:

- Like/Unlike nhà hàng
- Đánh giá nhà hàng
- Đặt món ăn
- Xem lịch sử đơn hàng

## Công nghệ sử dụng

- **Node.js**
- **Express.js**
- **MySQL**
- **Docker** (cho MySQL)
- **mysql2** - MySQL client
- **dotenv** - Environment variables
- **cors** - CORS middleware

## Cài đặt

### 1. Clone repository

```bash
git clone https://github.com/mirana912/nodejs53-Sequelize-App-food.git
cd nodejs53-Sequelize-App-food
```

### 2. Cài đặt dependencies

```bash
npm install
```

### 3. Setup MySQL Database với Docker

```bash
# Khởi động MySQL container
docker run -d \
  --name food-delivery-mysql \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=your_password \
  -e MYSQL_DATABASE=food_delivery \
  mysql:8.0

# Kiểm tra container đang chạy
docker ps

# Set container tự động start
docker update --restart=always food-delivery-mysql
```

### 4. Import Database

**Cách 1: Dùng TablePlus**

1. Mở TablePlus và kết nối đến MySQL
2. Mở file `database/food_delivery.sql`
3. Run tất cả queries

**Cách 2: Dùng Terminal**

```bash
# Copy file SQL vào container
docker cp database/food_delivery.sql food-delivery-mysql:/tmp/

# Import vào database
docker exec -i food-delivery-mysql mysql -uroot -p"your_password" < database/food_delivery.sql
```

### 5. Cấu hình Environment Variables

Tạo file `.env` trong thư mục root:

```env
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=food_delivery
PORT=8080
```

## Cấu trúc Database

### Tables

| Table        | Mô tả             | Records |
| ------------ | ----------------- | ------- |
| `user`       | Người dùng        | 20      |
| `restaurant` | Nhà hàng          | 10      |
| `food_type`  | Loại món ăn       | 5       |
| `food`       | Món ăn            | 30      |
| `sub_food`   | Món phụ/topping   | 20      |
| `order`      | Đơn hàng          | 50      |
| `like_res`   | Like nhà hàng     | 80      |
| `rate_res`   | Đánh giá nhà hàng | 40      |

### Entity Relationship

```
user (1) ─────< (N) order ──────> (1) food
  │                                      │
  │                                      └──> (1) food_type
  │                                      │
  │                                      └────< (N) sub_food
  │
  ├─────< (N) like_res ───────> (1) restaurant
  │
  └─────< (N) rate_res ───────> (1) restaurant
```

## API Endpoints

### Like Restaurant

| Method | Endpoint                        | Description                      |
| ------ | ------------------------------- | -------------------------------- |
| POST   | `/api/like`                     | Like nhà hàng                    |
| DELETE | `/api/unlike`                   | Unlike nhà hàng                  |
| GET    | `/api/likes/restaurant/:res_id` | Lấy danh sách like theo nhà hàng |
| GET    | `/api/likes/user/:user_id`      | Lấy danh sách like theo user     |

**Example Request:**

```json
POST /api/like
{
  "user_id": 1,
  "res_id": 1
}
```

### Rating Restaurant

| Method | Endpoint                          | Description                |
| ------ | --------------------------------- | -------------------------- |
| POST   | `/api/rating`                     | Thêm/cập nhật đánh giá     |
| GET    | `/api/ratings/restaurant/:res_id` | Lấy đánh giá theo nhà hàng |
| GET    | `/api/ratings/user/:user_id`      | Lấy đánh giá theo user     |

**Example Request:**

```json
POST /api/rating
{
  "user_id": 1,
  "res_id": 1,
  "amount": 5
}
```

### Order Food

| Method | Endpoint                    | Description            |
| ------ | --------------------------- | ---------------------- |
| POST   | `/api/order`                | Đặt món                |
| GET    | `/api/orders/user/:user_id` | Lấy đơn hàng theo user |

**Example Request:**

```json
POST /api/order
{
  "user_id": 1,
  "food_id": 1,
  "amount": 2,
  "arr_sub_id": [1, 2, 3]
}
```

## Chạy ứng dụng

### Development Mode

```bash
npm run dev
```

Server sẽ chạy tại: `http://localhost:8080`

### Production Mode

```bash
npm start
```

## Test API

### 1. Dùng Browser (GET requests)

```
http://localhost:8080/
http://localhost:8080/api/likes/user/1
http://localhost:8080/api/ratings/restaurant/1
http://localhost:8080/api/orders/user/1
```

### 2. Dùng curl (Terminal)

```bash
# Like nhà hàng
curl -X POST http://localhost:8080/api/like \
  -H "Content-Type: application/json" \
  -d '{"user_id": 1, "res_id": 1}'

# Đặt món
curl -X POST http://localhost:8080/api/order \
  -H "Content-Type: application/json" \
  -d '{"user_id": 1, "food_id": 1, "amount": 2, "arr_sub_id": [1,2]}'

# Đánh giá
curl -X POST http://localhost:8080/api/rating \
  -H "Content-Type: application/json" \
  -d '{"user_id": 1, "res_id": 1, "amount": 5}'
```

### 3. Dùng Postman/Thunder Client

Import collection hoặc test từng endpoint với:

- Method: POST/GET/DELETE
- Headers: `Content-Type: application/json`
- Body: JSON data

## Cấu trúc thư mục

```
food-delivery-api/
├── database/
│   └── food_delivery.sql        # Database dump
├── src/
│   ├── config/
│   │   └── database.js          # MySQL config
│   ├── controllers/
│   │   ├── likeController.js    # Like logic
│   │   ├── ratingController.js  # Rating logic
│   │   └── orderController.js   # Order logic
│   ├── routes/
│   │   └── index.js             # API routes
│   └── server.js                # Entry point
├── .env                         # Environment variables
├── .gitignore
├── package.json
└── README.md
```

## Sample Data

Database đã được import với:

- 20 users (người dùng)
- 10 restaurants (nhà hàng)
- 5 food_types (loại món)
- 30 foods (món ăn)
- 20 sub_foods (topping)
- 50 orders (đơn hàng)
- 80 likes (lượt thích)
- 40 ratings (đánh giá)

## Author

**Trần Bá Hược**

- GitHub: [@mirana912](https://github.com/mirana912)

## License

---
