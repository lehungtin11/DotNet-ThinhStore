using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThinhStoreWF.Views
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    string username = Session["Username"].ToString();
                    LoadUserData(username);
                }
                else
                {
                    // Xử lý trường hợp người dùng chưa đăng nhập hoặc session hết hạn
                    Response.Redirect("/Views/LoginRegister.aspx");
                }
            }
        }

        private void LoadUserData(string username)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM users WHERE username = @username";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@username", username);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtFullName.Text = Server.HtmlEncode(reader["full_name"].ToString());
                            ddlGender.SelectedValue = Server.HtmlEncode(reader["gender"].ToString());
                            txtEmail.Text = Server.HtmlEncode(reader["email"].ToString());
                            txtPhone.Text = Server.HtmlEncode(reader["phone"].ToString());
                            txtAddress.Text = Server.HtmlEncode(reader["address"].ToString());
                            // Đặt giá trị cho các control khác dựa trên cột tương ứng
                        }
                    }
                }
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE users SET full_name = @FullName, email = @Email, gender = @gender, phone = @phone, address = @address WHERE username = @username";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@FullName", Server.HtmlEncode(txtFullName.Text));
                        command.Parameters.AddWithValue("@gender", ddlGender.SelectedValue);
                        command.Parameters.AddWithValue("@Email", txtEmail.Text);
                        command.Parameters.AddWithValue("@phone", txtPhone.Text);
                        command.Parameters.AddWithValue("@address", txtAddress.Text);
                        // Thêm các tham số khác tương tự

                        command.Parameters.AddWithValue("@username", Session["Username"].ToString());

                        connection.Open();
                        int result = command.ExecuteNonQuery();
                        if (result > 0)
                        {
                            lblMessage.Text = "Information updated successfully.";
                            lblMessage.CssClass = "alert alert-success";
                        }
                        else
                        {
                            lblMessage.Text = "Information update failed.";
                            lblMessage.CssClass = "alert alert-danger";
                        }
                        lblMessage.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Visible = true;
            }
        }

    }
}