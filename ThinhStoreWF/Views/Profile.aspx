<%@ Page Title="Profile Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="ThinhStoreWF.Views.Profile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row m-4" style="height: 100vh">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header">
                        Cập nhật thông tin
                    </div>
                    <div class="card-body">
                        <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>
                        <div class="form-group">
                            <asp:TextBox ID="txtFullName" CssClass="form-control" runat="server" placeholder="Họ tên"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:DropDownList CssClass="form-control" ID="ddlGender" runat="server">
                                <asp:ListItem Value="">Giới tính</asp:ListItem>
                                <asp:ListItem Value="Male">Nam</asp:ListItem>
                                <asp:ListItem Value="Female">Nữ</asp:ListItem>
                                <asp:ListItem Value="Other">Khác</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" TextMode="Email" placeholder="Email"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server" TextMode="Phone" placeholder="Số điện thoại"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtAddress" CssClass="form-control" TextMode="MultiLine" Columns="20" Rows="5" runat="server" placeholder="Địa chỉ"></asp:TextBox>
                        </div>
                        <!-- Add more fields as necessary -->
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Cập nhật" OnClick="btnSave_Click" />
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
