using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThinhStoreWF
{
    public partial class _Default : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                //BindDataToGridView();
                GetItems();
            }
            
        }

        private void GetItems()
        {
            var connectionFromConfiguration = WebConfigurationManager.ConnectionStrings["DBConnection"];
            using (SqlConnection dbConnection = new SqlConnection(connectionFromConfiguration.ConnectionString))
            {
                try
                {
                    dbConnection.Open();
                    try
                    {
                        SqlCommand command = new SqlCommand("select id, type, name, image, price, price, discount, description from products", dbConnection);


                        StringBuilder htmlOutputAsus = new StringBuilder();
                        StringBuilder htmlOutputAcer = new StringBuilder();
                        StringBuilder htmlOutputMSI = new StringBuilder();
                        StringBuilder htmlOutputAccessory = new StringBuilder();
                        SqlDataReader reader = command.ExecuteReader();

                        int index = 0;
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                string id = reader["id"].ToString();
                                string type = reader["Type"].ToString();
                                string name = reader["Name"].ToString();
                                string oldPriceStr = reader["price"].ToString();
                                string image = reader["Image"].ToString();
                                string discountStr = reader["Discount"].ToString();

                                // Chuyển đổi oldPrice và discount từ string sang int (hoặc decimal nếu cần giữ phần thập phân)
                                int oldPrice = int.Parse(oldPriceStr);

                                if(string.IsNullOrEmpty(discountStr))
                                {
                                    discountStr = "0";
                                }
                                int discount = int.Parse(discountStr);

                                // Tính số tiền giảm giá
                                int discountAmount = oldPrice * discount / 100;

                                // Tính giá mới sau khi đã giảm
                                int price = oldPrice - discountAmount;
                                CultureInfo vietnamCulture = new CultureInfo("vi-VN");

                                // Định dạng số theo tiền tệ của Việt Nam (VND)
                                string formattedPrice = price.ToString("C", vietnamCulture);

                                oldPriceStr = oldPrice.ToString("C", vietnamCulture);

                                // Tách chuỗi dựa vào dấu phẩy và lấy phần đầu tiên
                                formattedPrice = formattedPrice.Split(',')[0] + 'đ';
                                oldPriceStr = oldPriceStr.Split(',')[0] + 'đ';

                                // Nếu bạn muốn giữ phần thập phân cho giá, bạn có thể sử dụng decimal thay vì int:
                                // decimal oldPrice = decimal.Parse(oldPriceStr);
                                // decimal discount = decimal.Parse(discountStr);
                                // decimal discountAmount = oldPrice * discount / 100m; // Chú ý: sử dụng 100m để chỉ định đó là một số decimal
                                // decimal price = oldPrice - discountAmount;


                                // Khởi tạo StringBuilder dựa trên type
                                StringBuilder htmlOutput = new StringBuilder();

                                if(type == "asus")
                                {
                                    htmlOutput = htmlOutputAsus;
                                } else if(type == "acer")
                                {
                                    htmlOutput = htmlOutputAcer;
                                } else if(type == "msi")
                                {
                                    htmlOutput = htmlOutputMSI;
                                } else if(type == "accessory")
                                {
                                    htmlOutput = htmlOutputAccessory;
                                }

                                
                                
                                index++;
                                // Xây dựng HTML
                                htmlOutput.AppendLine($"<article class='product-item' data-index='{index}' onclick=\"handleProductClick({id});\">");
                                if (!string.IsNullOrEmpty(discountStr))
                                {
                                    htmlOutput.AppendLine($"<div class='ex_pricesale percent'>{discountStr}%</div>");
                                }
                                htmlOutput.AppendLine($"<img src='/img/{type}/{image}' alt='{name}'>");
                                htmlOutput.AppendLine($"<h4 class='line-clamp product-title'>{name}</h4>");
                                htmlOutput.AppendLine("<div class='price'>");
                                if (!string.IsNullOrEmpty(formattedPrice))
                                {
                                    htmlOutput.AppendLine($"<ins class='new-price'>{formattedPrice}</ins>");
                                }
                                if (!string.IsNullOrEmpty(oldPriceStr))
                                {
                                    htmlOutput.AppendLine($"<del class='old-price'>{oldPriceStr}</del>");
                                }
                                htmlOutput.AppendLine("</div>");
                                htmlOutput.AppendLine("<div class='cb_promotion_stand'>");
                                htmlOutput.AppendLine("<div class='gift-detail'>[Từ 14.1 - 9.2] Miễn phí cài đặt Windows 11, Miễn phí cân màu màn hình công nghệ cao, Balo thời trang AZ</div>");
                                htmlOutput.AppendLine("</div>");
                                htmlOutput.AppendLine("</article>");
                            }
                        }

                        // Sau khi tất cả dữ liệu đã được xử lý, gán kết quả vào các thành phần tương ứng
                        asus_item.InnerHtml = htmlOutputAsus.ToString();
                        acer_item.InnerHtml = htmlOutputAcer.ToString();
                        msi_item.InnerHtml = htmlOutputMSI.ToString();
                        accessory_item.InnerHtml = htmlOutputAccessory.ToString();
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

        private void BindDataToGridView()
        {
            try
            {
                var connectionFromConfiguration = WebConfigurationManager.ConnectionStrings["DBConnection"];
                using (SqlConnection dbConnection = new SqlConnection(connectionFromConfiguration.ConnectionString))
                {
                    try
                    {
                        dbConnection.Open();
                        try
                        {
                            SqlCommand command = new SqlCommand("select type, name, image, price, old_price, discount, description from items", dbConnection);
                            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                            DataSet dataSet = new DataSet();
                            dataAdapter.Fill(dataSet);
                            if (dataSet.Tables[0].Rows.Count > 0)
                            {
                                //gvItems.DataSource = dataSet;
                                //gvItems.DataBind();
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
            catch { 
            
            }
        }

        protected void gvItems_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void gvItems_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gvItems_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvItems_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void btnRedirect_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Contact.aspx?id=123");
        }
    }
}