using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThinhStoreWF.Views
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsLoggedIn"] == null || (bool)Session["IsLoggedIn"] == false)
            {
                Response.Redirect("/Views/LoginRegister.aspx");
            }
            else {}
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            int orderIdParsed;
            bool parseSuccess = int.TryParse(txtOrderId.Text, out orderIdParsed);
            if (!parseSuccess)
            {
                // Xử lý trường hợp không parse được
                ltrMessage.Text = "Invalid Order ID.";
                return;
            }

            string paymentMethod = ddlPaymentMethod.SelectedValue;
            string email = txtOrderEmail.Text;
            string phone = txtOrderPhone.Text;
            string address = txtOrderAddress.Text;
            string note = txtOrderNote.Text;
            decimal totalPrice = decimal.Parse(txtTotalPrice.Text);
            decimal discount = 0m;
            
            var connectionString = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Cập nhật trạng thái đơn hàng trong bảng 'orders'
                    string updateOrderSql = @"
                    UPDATE orders
                    SET total_price = @total_price,
                    discount = @discount,
                    orderAddress = @orderAddress,
                    orderEmail = @orderEmail,
                    orderPhone = @orderPhone,
                    orderNote = @orderNote,
                    deliveryStatus = 'Delivered'
                    WHERE orderId = @orderId;
                    ";
                    using (SqlCommand updateOrderCmd = new SqlCommand(updateOrderSql, conn))
                    {
                        updateOrderCmd.Parameters.AddWithValue("@orderId", orderIdParsed);
                        updateOrderCmd.Parameters.AddWithValue("@total_price", totalPrice);
                        updateOrderCmd.Parameters.AddWithValue("@discount", discount);
                        updateOrderCmd.Parameters.AddWithValue("@orderAddress", address);
                        updateOrderCmd.Parameters.AddWithValue("@orderEmail", email);
                        updateOrderCmd.Parameters.AddWithValue("@orderPhone", phone);
                        updateOrderCmd.Parameters.AddWithValue("@orderNote", note);
                        updateOrderCmd.ExecuteNonQuery();
                    }

                    // Thêm thông tin vào bảng 'invoices'
                    string invoiceSql = @"
                    INSERT INTO invoices (orderId, paymentStatus, finalPrice, paymentMethod ) 
                    VALUES (@OrderId, 'Paid', @FinalPrice, @PaymentMethod);
                    ";

                    using (SqlCommand invoiceCmd = new SqlCommand(invoiceSql, conn))
                    {
                        invoiceCmd.Parameters.AddWithValue("@OrderId", orderIdParsed);
                        invoiceCmd.Parameters.AddWithValue("@FinalPrice", totalPrice - discount);
                        invoiceCmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                        invoiceCmd.ExecuteNonQuery();
                    }

                    // Chuyển hướng người dùng về trang hóa đơn hoặc hiển thị thông báo thành công
                    Response.Redirect("/Views/Invoice.aspx");
                }
                catch (SqlException ex)
                {
                    ltrMessage.Text = ex.Message;
                }
            }
        }

    }
}