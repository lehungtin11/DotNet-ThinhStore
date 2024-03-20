using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThinhStoreWF.Views
{
    public partial class ManageProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsLoggedIn"] == null || (bool)Session["IsLoggedIn"] == false)
            {
                Response.Redirect("/Views/LoginRegister.aspx");
            } else
            {
                if(Session["Username"].ToString() != "admin")
                {
                    Response.Redirect("/");
                }
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string filterType = ddlTypeFilter.SelectedValue;
            string filterName = txtNameFilter.Text.Trim();

            SqlDataSource1.SelectParameters.Clear();

            string selectCommand = "SELECT id, Name, Price, Type, Description, Image, discount, spec_os FROM Products WHERE 1=1";

            if (!string.IsNullOrEmpty(filterType))
            {
                selectCommand += " AND Type = @Type";
                SqlDataSource1.SelectParameters.Add("Type", filterType);
            }

            if (!string.IsNullOrEmpty(filterName))
            {
                selectCommand += " AND Name LIKE '%' + @Name + '%'";
                SqlDataSource1.SelectParameters.Add("Name", filterName);
            }

            SqlDataSource1.SelectCommand = selectCommand;
            GridView1.DataBind();
        }

        /*
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                try
                {
                    string filename = Path.GetFileName(FileUpload1.FileName);
                    // Lưu file vào thư mục Images trên server
                    FileUpload1.SaveAs(Server.MapPath("~/Images/") + filename);
                    // Hiển thị thông báo thành công hoặc lưu đường dẫn vào database nếu cần
                }
                catch (Exception ex)
                {
                    // Hiển thị lỗi
                }
            }
            else
            {
                // Thông báo không có file được chọn
            }
        }
        */
    }
}