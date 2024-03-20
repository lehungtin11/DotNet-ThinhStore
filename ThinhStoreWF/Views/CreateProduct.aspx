<%@ Page Title="Create Product" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateProduct.aspx.cs" Inherits="ThinhStoreWF.Views.CreateProduct" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Button runat="server" ID="btnBack" OnClick="btnBack_Click" Text="Trở về trang trước" CssClass="btn  btn-primary m-3"/>
    <div class="container mt-3 mb-3">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header">
                        <h4>Tạo Mới Sản Phẩm</h4>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <asp:TextBox ID="txtProductName" CssClass="form-control" runat="server" placeholder="Tên sản phẩm"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server" placeholder="Giá"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:DropDownList CssClass="form-control" ID="ddlTypeFilter" runat="server">
                                <asp:ListItem Value="">Loại sản phẩm</asp:ListItem>
                                <asp:ListItem Value="acer">Acer</asp:ListItem>
                                <asp:ListItem Value="asus">Asus</asp:ListItem>
                                <asp:ListItem Value="msi">MSI</asp:ListItem>
                                <asp:ListItem Value="accessory">Phụ kiện</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtImage" CssClass="form-control" runat="server" placeholder="Hình"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtDiscount" CssClass="form-control" runat="server" placeholder="Giảm giá"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtCPU" CssClass="form-control" runat="server" placeholder="CPU"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtOS" CssClass="form-control" runat="server" placeholder="OS"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtRAM" CssClass="form-control" runat="server" placeholder="RAM"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtStorage" CssClass="form-control" runat="server" placeholder="Storage"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtCard_VGA" CssClass="form-control" runat="server" placeholder="Card_VGA"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtBattery" CssClass="form-control" runat="server" placeholder="Battery"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtDisplay" CssClass="form-control" runat="server" placeholder="Display"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtDescription" CssClass="form-control" TextMode="MultiLine" Columns="20" Rows="5" runat="server" placeholder="Mô tả"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnCreate" CssClass="btn btn-primary" runat="server" Text="Tạo Mới" OnClick="btnCreate_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
