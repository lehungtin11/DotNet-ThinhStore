using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThinhStoreWF.Views
{
    public partial class CreateProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsLoggedIn"] == null || (bool)Session["IsLoggedIn"] == false)
            {
                Response.Redirect("/Views/LoginRegister.aspx");
            }
            else
            {
                if (Session["Username"].ToString() != "admin")
                {
                    Response.Redirect("/");
                }
            }
        }
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu từ các control
            string productName = txtProductName.Text.Trim();
            decimal price;
            if (!decimal.TryParse(txtPrice.Text.Trim(), out price))
            {
                // Xử lý lỗi khi giá không phải là một số
                return;
            }
            string type = ddlTypeFilter.Text.Trim();
            string description = txtDescription.Text.Trim();
            string image = txtImage.Text.Trim();
            string discount = txtDiscount.Text.Trim();
            string CPU = txtCPU.Text.Trim();
            string OS = txtOS.Text.Trim();
            string RAM = txtRAM.Text.Trim();
            string Storage = txtStorage.Text.Trim();
            string Card_VGA = txtCard_VGA.Text.Trim();
            string Battery = txtBattery.Text.Trim();
            string Display = txtDisplay.Text.Trim();

            // Thiết lập kết nối đến database
            var connectionString = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    // Mở kết nối
                    conn.Open();

                    // Tạo câu truy vấn SQL để thêm sản phẩm mới
                    string sql = "INSERT INTO Products" +
                        " (Name, Price, Type, Description, Image, Discount, spec_cpu, spec_os, spec_ram, spec_storage, spec_card_vga, spec_battery, spec_display)" +
                        " VALUES" +
                        " (@Name, @Price, @Type, @Description, @Image, @Discount, @CPU, @OS, @RAM, @Storage, @Card_VGA, @Battery, @Display)";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        // Thêm các giá trị vào câu truy vấn
                        cmd.Parameters.AddWithValue("@Name", productName);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@Type", type);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@Image", image);
                        cmd.Parameters.AddWithValue("@Discount", discount);
                        cmd.Parameters.AddWithValue("@CPU", CPU);
                        cmd.Parameters.AddWithValue("@OS", OS);
                        cmd.Parameters.AddWithValue("@RAM", RAM);
                        cmd.Parameters.AddWithValue("@Storage", Storage);
                        cmd.Parameters.AddWithValue("@Card_VGA", Card_VGA);
                        cmd.Parameters.AddWithValue("@Battery", Battery);
                        cmd.Parameters.AddWithValue("@Display", Display);

                        // Thực thi câu truy vấn
                        cmd.ExecuteNonQuery();
                    }

                    // Chuyển hướng người dùng về trang danh sách sản phẩm hoặc hiển thị thông báo thành công
                    Response.Redirect("/Views/ManageProducts.aspx");
                }
                catch
                {
                    // Xử lý lỗi kết nối hoặc truy vấn, ví dụ hiển thị thông báo lỗi
                    // Response.Write("Lỗi: " + ex.Message);
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Views/ManageProducts.aspx");
        }
    }
}