using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Serialization;

namespace ThinhStoreWF
{
    public class ApiHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            var userId = context.Request.QueryString["userId"]; // Lấy userID từ query string
            var typeRequest = context.Request.QueryString["typeRequest"]; // Lấy typeRequest từ query string
            var orderItemQuantity = context.Request.QueryString["orderItemQuantity"]; // Lấy orderItemQuantity từ query string
            var orderItemId = context.Request.QueryString["orderItemId"]; // Lấy orderItemId từ query string
            var productId = context.Request.QueryString["productId"]; // Lấy productId từ query string
            var orderId = context.Request.QueryString["orderId"]; // Lấy orderId từ query string
            var jsS = new JavaScriptSerializer();
            switch (typeRequest)
            {
                case "getOrders":
                    if (string.IsNullOrEmpty(userId))
                    {
                        context.Response.Write(jsS.Serialize("NotFound"));
                    }
                    else
                    {
                        var orders = GetOrders(int.Parse(userId));
                        context.Response.Write(jsS.Serialize(orders));
                    }
                    break;
                case "getOrdersDetail":
                    if (string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(orderId))
                    {
                        context.Response.Write(jsS.Serialize("NotFound"));
                    }
                    else
                    {
                        var orders = GetOrdersDetail(int.Parse(userId), int.Parse(orderId));
                        context.Response.Write(jsS.Serialize(orders));
                    }
                    break;
                case "addOrder":
                    if(string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(productId))
                    {
                        context.Response.Write(jsS.Serialize("NotFound"));
                    } else
                    {
                        if( AddOrder(int.Parse(userId), int.Parse(productId), int.Parse(orderItemQuantity)) )
                        {
                            context.Response.Write(jsS.Serialize("Success"));
                        }
                    }
                    break;
                case "updateOrder":
                    if (string.IsNullOrEmpty(orderItemId) || string.IsNullOrEmpty(orderItemQuantity))
                    {
                        context.Response.Write(jsS.Serialize("NotFound"));
                    }
                    else
                    {
                        if( UpdateOrder(int.Parse(orderItemId), int.Parse(orderItemQuantity)) )
                        {
                            context.Response.Write(jsS.Serialize("Success"));
                        }
                    }
                    break;
                case "deleteOrder":
                    if (string.IsNullOrEmpty(orderItemId))
                    {
                        context.Response.Write(jsS.Serialize("NotFound"));
                    }
                    else
                    {
                        if( DeleteOrder(int.Parse(orderItemId)) )
                        {
                            context.Response.Write(jsS.Serialize("Success"));
                        }
                    }
                    break;
                default:
                    context.Response.Write(jsS.Serialize("Type not found!"));
                    break;
            }
        }

        private List<object> GetOrders(int userId)
        {
            var orders = new List<object>();
            var connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sql = @"
                SELECT o.orderId, oi.orderItemId, p.discount, p.id, p.image, p.name, 
                        p.price, p.type, oi.quantity,
                        (p.price - (p.price * p.discount / 100)) AS discountedPrice
                FROM order_items oi
                LEFT JOIN orders o ON o.orderId = oi.orderId
                LEFT JOIN products p ON p.id = oi.productId
                WHERE o.userId = @UserId AND o.deliveryStatus = @deliveryStatus";

                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@UserId", userId);
                    command.Parameters.AddWithValue("@deliveryStatus", "Processing");
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            orders.Add(new
                            {
                                orderId = reader["orderId"],
                                orderItemId = reader["orderItemId"],
                                id = reader["id"],
                                image = "/img/" + reader["type"] + "/" + reader["image"],
                                name = reader["name"],
                                price = reader["discountedPrice"].ToString(),
                                quantity = reader["quantity"],
                                UserId = userId
                            });
                        }
                    }
                }
            }
            return orders;
        }

        private List<object> GetOrdersDetail(int userId, int orderId)
        {
            var orders = new List<object>();
            var connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sql = @"
                SELECT o.orderId, oi.orderItemId, p.discount, p.id, p.image, p.name, 
                        p.price, p.type, oi.quantity,
                        (p.price - (p.price * p.discount / 100)) AS discountedPrice
                FROM order_items oi
                LEFT JOIN orders o ON o.orderId = oi.orderId
                LEFT JOIN products p ON p.id = oi.productId
                WHERE o.userId = @UserId AND o.deliveryStatus <> @deliveryStatus AND oi.orderId = @orderId";

                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@UserId", userId);
                    command.Parameters.AddWithValue("@orderId", orderId);
                    command.Parameters.AddWithValue("@deliveryStatus", "Processing");
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            orders.Add(new
                            {
                                orderId = reader["orderId"],
                                orderItemId = reader["orderItemId"],
                                id = reader["id"],
                                image = "/img/" + reader["type"] + "/" + reader["image"],
                                name = reader["name"],
                                price = reader["discountedPrice"].ToString(),
                                quantity = reader["quantity"],
                                UserId = userId
                            });
                        }
                    }
                }
            }
            return orders;
        }

        public bool AddOrder(int userId, int productId, int quantityToAdd)
        {
            bool isSuccess = false;
            try
            {
                var connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
                decimal productPrice = 0m; // Sử dụng kiểu decimal cho giá sản phẩm

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Lấy thông tin sản phẩm hiện tại
                    string sql = "SELECT TOP 1 price FROM products WHERE id = @productId";
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@productId", productId);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string priceValue = reader["price"].ToString();
                                decimal price;
                                if (decimal.TryParse(priceValue, out price))
                                {
                                    productPrice = price;
                                }
                                else
                                {
                                    // Xử lý trường hợp giá trị không thể chuyển đổi thành decimal
                                }
                            }
                        }
                    }

                    int? orderId = null;
                    // Kiểm tra xem đã có đơn hàng chưa
                    string orderQuery = "SELECT orderId FROM orders WHERE userId = @UserId AND deliveryStatus = 'Processing'";
                    using (SqlCommand orderCmd = new SqlCommand(orderQuery, connection))
                    {
                        orderCmd.Parameters.AddWithValue("@UserId", userId);
                        var result = orderCmd.ExecuteScalar();
                        if (result != null)
                        {
                            orderId = (int)result;
                        }
                    }

                    if (!orderId.HasValue)
                    {
                        // Tạo đơn hàng mới nếu chưa có
                        string insertOrderQuery = "INSERT INTO orders (userId, purchaseType) OUTPUT INSERTED.orderId VALUES (@UserId, 'Online')";
                        using (SqlCommand insertOrderCmd = new SqlCommand(insertOrderQuery, connection))
                        {
                            insertOrderCmd.Parameters.AddWithValue("@UserId", userId);
                            orderId = (int)insertOrderCmd.ExecuteScalar();
                        }
                    }

                    int? currentQuantity = null;
                    // Kiểm tra sản phẩm đã tồn tại trong giỏ hàng chưa
                    string itemQuery = "SELECT quantity FROM order_items WHERE orderId = @OrderId AND productId = @ProductId";
                    using (SqlCommand itemCmd = new SqlCommand(itemQuery, connection))
                    {
                        itemCmd.Parameters.AddWithValue("@OrderId", orderId.Value);
                        itemCmd.Parameters.AddWithValue("@ProductId", productId);
                        var result = itemCmd.ExecuteScalar();
                        if (result != null)
                        {
                            currentQuantity = (int)result;
                        }
                    }

                    if (currentQuantity.HasValue)
                    {
                        // Cập nhật số lượng nếu sản phẩm đã tồn tại
                        string updateItemQuery = "UPDATE order_items SET quantity = quantity + @QuantityToAdd WHERE orderId = @OrderId AND productId = @ProductId";
                        using (SqlCommand updateItemCmd = new SqlCommand(updateItemQuery, connection))
                        {
                            updateItemCmd.Parameters.AddWithValue("@QuantityToAdd", quantityToAdd);
                            updateItemCmd.Parameters.AddWithValue("@OrderId", orderId.Value);
                            updateItemCmd.Parameters.AddWithValue("@ProductId", productId);
                            updateItemCmd.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        // Thêm sản phẩm mới vào giỏ hàng nếu chưa tồn tại
                        string insertItemQuery = "INSERT INTO order_items (orderId, productId, quantity, price) VALUES (@OrderId, @ProductId, @QuantityToAdd, @Price)";
                        using (SqlCommand insertItemCmd = new SqlCommand(insertItemQuery, connection))
                        {
                            insertItemCmd.Parameters.AddWithValue("@QuantityToAdd", quantityToAdd);
                            insertItemCmd.Parameters.AddWithValue("@OrderId", orderId.Value);
                            insertItemCmd.Parameters.AddWithValue("@ProductId", productId);
                            insertItemCmd.Parameters.AddWithValue("@Price", productPrice);
                            insertItemCmd.ExecuteNonQuery();
                        }
                    }
                    isSuccess = true;
                }

            } catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                isSuccess = false;
            }
            return isSuccess;
        }

        protected bool UpdateOrder(int orderItemId, int orderItemQuantity)
        {
            bool isSuccess = false;
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE order_items SET quantity = @orderItemQuantity WHERE orderItemId = @orderItemId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@orderItemId", orderItemId);
                        command.Parameters.AddWithValue("@orderItemQuantity", orderItemQuantity);

                        connection.Open();
                        int result = command.ExecuteNonQuery();

                    }
                }
                isSuccess = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                isSuccess = false;
            }
            return isSuccess;
        }

        protected bool DeleteOrder(int orderItemId)
        {
            bool isSuccess = false;
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM order_items WHERE orderItemId = @orderItemId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@orderItemId", orderItemId);
                        connection.Open();
                        int result = command.ExecuteNonQuery();
                    }
                }
                isSuccess = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                isSuccess = false;
            }
            return isSuccess;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}