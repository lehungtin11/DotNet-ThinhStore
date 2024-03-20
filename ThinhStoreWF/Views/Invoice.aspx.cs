using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThinhStoreWF.Views
{
    public partial class Invoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (Session["IsLoggedIn"] == null || (bool)Session["IsLoggedIn"] == false)
                {
                    Response.Redirect("/Views/LoginRegister.aspx");
                }
                else
                {
                    filterUser();
                }
            }
        }
        public void filterUser()
        {
            string strUserId = Session["userId"].ToString();
            int userId = int.Parse(strUserId);

            SqlDataSource1.SelectParameters.Clear();

            string selectCommand = @"
            SELECT iv.invoiceId, iv.orderId, iv.paymentMethod,
            iv.paymentStatus, iv.finalPrice, iv.paymentDetails, iv.issuedDate
            FROM invoices iv
            LEFT JOIN orders oi ON oi.orderId = iv.orderId
            WHERE 1=1
            ";

            selectCommand += " AND oi.userId = @userId";
            SqlDataSource1.SelectParameters.Add("userId", strUserId);

            SqlDataSource1.SelectCommand = selectCommand;
            GridView1.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowDetails")
            {
                try
                {
                    string orderId = e.CommandArgument.ToString();
                }
                catch
                {
                }
                
            }
        }

    }
}