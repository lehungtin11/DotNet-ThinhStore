<%@ Page Title="Login Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginRegister.aspx.cs" Inherits="ThinhStoreWF.Views.login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Literal ID="connectDB" runat="server"></asp:Literal>
    <div class="alert alert-success" role="alert" id="successAlert" runat="server" visible="false">
        Đăng nhập thành công!
    </div>
    <div class="alert alert-danger" role="alert" id="errorAlert" runat="server" visible="false">
        Đăng nhập thất bại!
    </div>

    <div style="height: 100vh; padding-top: 80px" class="container">
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">Đăng nhập</div>
                    <div class="card-body">
                        <asp:TextBox ID="txtLoginUsername" CssClass="form-control" placeholder="Username" runat="server"></asp:TextBox><br />
                        <asp:TextBox ID="txtLoginPassword" CssClass="form-control" TextMode="Password" placeholder="Password" runat="server"></asp:TextBox><br />
                        <asp:Button ID="btnLogin" CssClass="btn btn-primary" runat="server" Text="Đăng nhập" OnClick="btnLogin_Click" />
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">Đăng ký</div>
                    <div class="card-body">
                        <asp:TextBox ID="txtRegisterUsername" CssClass="form-control" placeholder="Username" runat="server"></asp:TextBox>
                        <br />
                        <asp:TextBox ID="txtRegisterPassword" CssClass="form-control" TextMode="Password" placeholder="Password" runat="server"></asp:TextBox>
                        <br />
                        <asp:TextBox ID="txtRegisterRePassword" CssClass="form-control" TextMode="Password" placeholder="Re-Password" runat="server"></asp:TextBox>
                        <br />
                        <asp:TextBox ID="txtRegisterEmail" CssClass="form-control" placeholder="Email" runat="server"></asp:TextBox>
                        <br />
                        
                        <asp:Button ID="btnRegister" CssClass="btn btn-success" runat="server" Text="Đăng ký" OnClick="btnRegister_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

