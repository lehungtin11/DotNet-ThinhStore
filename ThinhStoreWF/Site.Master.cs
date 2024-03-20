using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Optimization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace ThinhStoreWF
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"])
                {
                    var username = Session["Username"].ToString();
                    var fullname = string.Empty;
                    var userId = string.Empty;
                    // Nếu người dùng đã đăng nhập
                    btnLogout.Visible = true;
                    btnLoginRegister.Visible = false;
                    ltrUsername.Visible = true;
                    (fullname, username, userId) = getUserData(username);
                    ltrUsername.Text = "<a href='/Views/Profile.aspx'><i class=\"fa fa-user\"></i> " + Server.HtmlEncode(fullname) + " (" + Server.HtmlEncode(username) + ") </a>";

                    if (username == "admin")
                    {
                        hplManageProduct.Visible = true;
                    }

                    //ltScript.Text = $"<script type='text/javascript'>localStorage.setItem('userId', '{userId}');localStorage.setItem('username', '{username}');</script>";
                    var script = $"<script type='text/javascript'>localStorage.setItem('userId', '{userId}');localStorage.setItem('username', '{username}');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "initUser", script, false);
                }
                else
                {
                    // Nếu người dùng chưa đăng nhập
                    var script = $"<script type='text/javascript'>localStorage.removeItem(\"userId\");localStorage.removeItem(\"username\");localStorage.removeItem(\"cart\");</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "initUser", script, false);

                    btnLoginRegister.Visible = true;
                    btnLogout.Visible = false;
                }
            }
        }

        private (string fullname, string username, string userId) getUserData(string username)
        {
            string fullname = string.Empty;
            string userId = string.Empty;
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT TOP 1 * FROM users WHERE username = @username";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", username);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            fullname = reader["full_name"].ToString();
                            userId = reader["userId"].ToString();
                        }
                    }
                }
            }
            return (fullname, username, userId);
        }

        protected void GetProduct(string productId)
        {
            var connectionFromConfiguration = WebConfigurationManager.ConnectionStrings["DBConnection"];
            using (SqlConnection dbConnection = new SqlConnection(connectionFromConfiguration.ConnectionString))
            {
                try
                {
                    dbConnection.Open();
                    try
                    {
                        SqlCommand command = new SqlCommand("select id, type, name, image, price, price, discount, description, spec_card_vga, spec_storage, spec_display, spec_ram, spec_os, spec_cpu, spec_battery from products where id = @id", dbConnection);
                        command.Parameters.AddWithValue("@id", productId);
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                string id = reader["id"].ToString();
                                string type = reader["Type"].ToString();
                                string name = reader["Name"].ToString();

                            }
                        }
                    }
                    catch
                    {
                    }
                }
                catch
                {

                }
                finally
                {
                    dbConnection.Close();
                    dbConnection.Dispose();
                }
            }
        }

        public void GetCartQuantity()
        {
            var totalQuantity = 0;
            
            var cart = Session["cart"] as List<Product>;
            if (cart != null)
            {
                totalQuantity = cart.Sum(item => item.quantity);
            }
            cartQuantity.InnerText = totalQuantity.ToString();
        }

        protected void btnLoginRegister_Click(object sender, EventArgs e)
        {
            // Chuyển hướng người dùng đến trang Đăng Nhập/Đăng Ký
            Response.Redirect("/Views/LoginRegister.aspx");
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xóa session và đăng xuất
            Session["IsLoggedIn"] = false;
            Session.Remove("Username");
            
            // Chuyển hướng người dùng về trang chủ hoặc trang đăng nhập
            Response.Redirect("/");
        }

        public class Product
        {
            public string id { get; set; }
            public string image { get; set; }
            public string name { get; set; }
            public string price { get; set; }
            public int quantity { get; set; }
        }
        

    }
}