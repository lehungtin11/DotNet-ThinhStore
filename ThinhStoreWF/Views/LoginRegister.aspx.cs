using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThinhStoreWF.Views
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Login(txtLoginUsername.Text, txtLoginPassword.Text);

            /*
            // Giả sử đây là logic kiểm tra tài khoản từ database
            if (txtLoginUsername.Text == "admin" && txtLoginPassword.Text == "admin")
            {
                // Lưu thông tin vào session
                Session["IsLoggedIn"] = true;
                Session["Username"] = txtLoginUsername.Text;
                // Chuyển hướng đến trang quản lý sản phẩm
                Response.Redirect("/Views/ManageProducts.aspx");
            }
            else
            {
                // Hiển thị lỗi đăng nhập
                Response.Write("Đăng nhập thất bại. Vui lòng thử lại.");
            }
            */
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtRegisterUsername.Text;
            string password = txtRegisterPassword.Text;
            string re_password = txtRegisterRePassword.Text;
            string email = txtRegisterEmail.Text;
            // Bạn cũng sẽ cần lấy và xử lý mật khẩu tại đây, nhưng nhớ mã hóa trước khi lưu

            if(!string.IsNullOrEmpty(username) && !string.IsNullOrEmpty(password) && !string.IsNullOrEmpty(email))
            {
                if (!CheckUserExists(username, email))
                {
                    // Tài khoản không tồn tại
                    if (password == re_password)
                    {
                        Register(username, password, email);
                    }
                    else
                    {
                        alertMessage(false, "Đăng ký", "Mật khẩu nhập lại không khớp.");
                    }
                }
                else
                {
                    alertMessage(false, "Đăng ký", "Tài khoản hoặc email đã tồn tại.");
                }
            } else
            {
                alertMessage(false, "Đăng ký", "Vui lòng nhập đủ các trường bắt buộc.");
            }

        }

        protected void Login(string username, string password)
        {
            bool isSuccess = false;
            var connectionFromConfiguration = WebConfigurationManager.ConnectionStrings["DBConnection"];
            using (SqlConnection dbConnection = new SqlConnection(connectionFromConfiguration.ConnectionString))
            {
                try
                {
                    dbConnection.Open();
                    var command = new SqlCommand("SELECT userId, username, password, salt FROM users WHERE username = @username", dbConnection);
                    command.Parameters.AddWithValue("@username", username);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string storedPassword = reader["password"].ToString();
                            string salt = reader["salt"].ToString();
                            string userId = reader["userId"].ToString();
                            bool isCorrectPassword = PasswordHasher.VerifyPassword(storedPassword, salt, password);
                            if (isCorrectPassword)
                            {
                                // Đăng nhập thành công
                                isSuccess = true;
                                // Lưu thông tin vào session
                                Session["IsLoggedIn"] = true;
                                Session["Username"] = txtLoginUsername.Text;
                                Session["userId"] = userId;
                                alertMessage(isSuccess, "Đăng nhập", "");
                                // Chuyển hướng đến trang quản lý sản phẩm
                                Response.Redirect("/");
                            }
                            else
                            {
                                // Đăng nhập thất bại
                                isSuccess = false;
                            }
                        }
                        else
                        {
                            // Đăng nhập thất bại
                            isSuccess = false;
                        }
                    }
                }
                catch
                {
                    // Xử lý lỗi kết nối hoặc truy vấn
                    isSuccess = false;
                }

                alertMessage(isSuccess, "Đăng nhập", "");
            }
        }
        public bool CheckUserExists(string username, string email)
        {
            var connectionFromConfiguration = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            using (SqlConnection dbConnection = new SqlConnection(connectionFromConfiguration))
            {
                dbConnection.Open();
                var command = new SqlCommand("SELECT COUNT(*) FROM users WHERE username = @username OR email = @email", dbConnection);
                command.Parameters.AddWithValue("@username", username);
                command.Parameters.AddWithValue("@email", email);

                int userCount = (int)command.ExecuteScalar();

                return userCount > 0;
            }
        }

        protected void Register(string username, string password, string email)
        {
            var connectionFromConfiguration = WebConfigurationManager.ConnectionStrings["DBConnection"];
            using (SqlConnection dbConnection = new SqlConnection(connectionFromConfiguration.ConnectionString))
            {
                bool isSuccess = false;
                try
                {
                    var (hash, salt) = PasswordHasher.HashPassword(password);

                    dbConnection.Open();
                    var command = new SqlCommand("INSERT INTO users (username, password, salt, email) VALUES (@username, @password, @salt, @email)", dbConnection);
                    command.Parameters.AddWithValue("@username", username);
                    command.Parameters.AddWithValue("@password", hash); 
                    command.Parameters.AddWithValue("@salt", salt); 
                    command.Parameters.AddWithValue("@email", email);

                    var result = command.ExecuteNonQuery();
                    if (result > 0)
                    {
                        // Đăng ký thành công
                        isSuccess = true;
                    }
                    else
                    {
                        isSuccess = false;
                    }
                }
                catch
                {
                    // Xử lý lỗi kết nối hoặc truy vấn
                    isSuccess = false;
                }

                alertMessage(isSuccess, "Đăng ký", "");
            }
        }

        private void alertMessage(bool isSuccess, string type, string customMesage)
        {
            if (isSuccess)
            {
                successAlert.InnerText = $"{type} thành công!";
                if (!string.IsNullOrEmpty(customMesage))
                {
                    successAlert.InnerText = customMesage;
                }
                successAlert.Visible = true;
                errorAlert.Visible = false;
            } else
            {
                errorAlert.InnerText = $"{type} thất bại!";
                if (!string.IsNullOrEmpty(customMesage))
                {
                    errorAlert.InnerText = customMesage;
                }
                successAlert.Visible = false;
                errorAlert.Visible = true;
            }
        }

        public static class PasswordHasher
        {
            // Tạo hash và salt cho mật khẩu
            public static (string hash, string salt) HashPassword(string password)
            {
                byte[] salt;
                new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);

                var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 10000);
                byte[] hash = pbkdf2.GetBytes(20);

                byte[] hashBytes = new byte[36];
                Array.Copy(salt, 0, hashBytes, 0, 16);
                Array.Copy(hash, 0, hashBytes, 16, 20);

                string savedPasswordHash = Convert.ToBase64String(hashBytes);

                return (savedPasswordHash, Convert.ToBase64String(salt));
            }

            // Kiểm tra mật khẩu với hash và salt
            public static bool VerifyPassword(string savedPasswordHash, string salt, string password)
            {
                byte[] hashBytes = Convert.FromBase64String(savedPasswordHash);
                byte[] saltBytes = Convert.FromBase64String(salt);

                var pbkdf2 = new Rfc2898DeriveBytes(password, saltBytes, 10000);
                byte[] hash = pbkdf2.GetBytes(20);

                for (int i = 0; i < 20; i++)
                {
                    if (hashBytes[i + 16] != hash[i])
                    {
                        return false;
                    }
                }
                return true;
            }
        }

        private void GetAccounts(string in_id)
        {
            var connectionFromConfiguration = WebConfigurationManager.ConnectionStrings["DBConnection"];
            using (SqlConnection dbConnection = new SqlConnection(connectionFromConfiguration.ConnectionString))
            {
                try
                {
                    dbConnection.Open();
                    try
                    {
                        SqlCommand command = new SqlCommand("select type, name, image, price, price, discount, description from products", dbConnection);


                        StringBuilder htmlOutputAsus = new StringBuilder();
                        StringBuilder htmlOutputAcer = new StringBuilder();
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                string type = reader["Type"].ToString();
                                string name = reader["Name"].ToString();
                                string price = reader["Price"].ToString();
                                string oldPrice = reader["price"].ToString();
                                string image = reader["Image"].ToString();
                                string discount = reader["Discount"].ToString();

                            }
                        }
                    }
                    catch (SqlException ex)
                    {
                        connectDB.Text = "Error Select: " + ex.Message;
                    }
                }
                catch (SqlException ex)
                {
                    connectDB.Text = "Fail to connect: " + ex.Message;

                }
                finally
                {
                    dbConnection.Close();
                    dbConnection.Dispose();
                }
            }
        }

    }
}