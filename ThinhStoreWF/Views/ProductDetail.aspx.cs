using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThinhStoreWF.Views
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string productId = Request.QueryString["id"];

            if (!string.IsNullOrEmpty(productId))
            {
                GetProduct(productId);
            }
            else
            {
                Response.Redirect("/");
                // Không tìm thấy tham số id hoặc tham số không hợp lệ
            }
        }

        protected void GetProduct(string productId) {
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
                                string oldPriceStr = reader["price"].ToString();
                                string image = reader["Image"].ToString();
                                string discountStr = reader["Discount"].ToString();
                                string description = reader["description"].ToString();
                                string storage = reader["spec_storage"].ToString();
                                string screen = reader["spec_display"].ToString();
                                string ram = reader["spec_ram"].ToString();
                                string os = reader["spec_os"].ToString();
                                string cpu = reader["spec_cpu"].ToString();
                                string battery = reader["spec_battery"].ToString();
                                string cardVGA = reader["spec_card_vga"].ToString();

                                // Lấy danh sách các sản phẩm liên quan
                                GetSimilarProducts(id, type);

                                // Chuyển đổi oldPrice và discount từ string sang int (hoặc decimal nếu cần giữ phần thập phân)
                                int oldPrice = int.Parse(oldPriceStr);

                                if (string.IsNullOrEmpty(discountStr))
                                {
                                    discountStr = "0";
                                }
                                int discount = int.Parse(discountStr);

                                // Tính số tiền giảm giá
                                int discountAmount = oldPrice * discount / 100;

                                // Tính giá mới sau khi đã giảm
                                int price = oldPrice - discountAmount;

                                int traGop = price * 10 / 100;
                                CultureInfo vietnamCulture = new CultureInfo("vi-VN");

                                // Định dạng số theo tiền tệ của Việt Nam (VND)
                                string formattedPrice = price.ToString("C", vietnamCulture);

                                oldPriceStr = oldPrice.ToString("C", vietnamCulture);

                                string strTraGop = traGop.ToString("C", vietnamCulture);

                                // Tách chuỗi dựa vào dấu phẩy và lấy phần đầu tiên
                                formattedPrice = formattedPrice.Split(',')[0] + 'đ';
                                oldPriceStr = oldPriceStr.Split(',')[0] + 'đ';
                                strTraGop = strTraGop.Split(',')[0] + 'đ';

                                imgProduct.Src = $"/img/{type}/{image}";
                                imgProduct.Alt = name;
                                h1Name.InnerText = name;
                                pOldPrice.InnerText = oldPriceStr;
                                pPrice.InnerText = formattedPrice;
                                pDescription.InnerText = description;

                                spanBattery.InnerText = battery;
                                spanCPU.InnerText = cpu;
                                spanOS.InnerText = os;
                                spanRAM.InnerText = ram;
                                spanScreen.InnerText = screen;
                                spanStorage.InnerText = storage;
                                spanCardVGA.InnerText = cardVGA;
                                bTraGop.InnerText = strTraGop;


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

        private void GetSimilarProducts(string productId, string productType)
        {
            var connectionFromConfiguration = WebConfigurationManager.ConnectionStrings["DBConnection"];
            using (SqlConnection dbConnection = new SqlConnection(connectionFromConfiguration.ConnectionString))
            {
                try
                {
                    dbConnection.Open();
                    try
                    {
                        SqlCommand command = new SqlCommand("select id, type, name, image, price, price, discount, description from products where type = @type and not id = @id", dbConnection);
                        command.Parameters.AddWithValue("@id", productId);
                        command.Parameters.AddWithValue("@type", productType);

                        StringBuilder htmlOutput = new StringBuilder();
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

                                if (string.IsNullOrEmpty(discountStr))
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
                        divSimilarProducts.InnerHtml = htmlOutput.ToString();
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
    }
}