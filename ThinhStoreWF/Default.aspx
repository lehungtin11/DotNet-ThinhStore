<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ThinhStoreWF._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<section class="product-container">
    <div class="banner">
        <div style="" id="productCarousel" class="carousel slide" data-ride="carousel" data-interval="2000">
            <ol class="carousel-indicators">
                <!-- Các indicators sẽ được thêm vào đây bằng JavaScript -->
            </ol>
            <div class="carousel-inner">
                <!-- Các mục carousel sẽ được thêm vào đây bằng JavaScript -->
            </div>
        </div>
        <div class="top-right__banner">
            <h3 class="banner_title">Khuyến mãi nổi bật</h3>
    
            <a href="#" aria-label="TẤT NIÊN GIẢM TẤT TAY" title="TẤT NIÊN GIẢM TẤT TAY">
                <div class="top-right__item">
                    <img src="/img/slider/566.webp" alt="TẤT NIÊN GIẢM TẤT TAY" width="265" height="140">
                </div>
            </a>
    
            <a href="#" aria-label="TẾT RỒNG XẢ KHO - GIẢM GIÁ RẤT TO" title="TẾT RỒNG XẢ KHO - GIẢM GIÁ RẤT TO">
                <div class="top-right__item">
                    <img src="/img/slider/559.webp" alt="TẾT RỒNG XẢ KHO - GIẢM GIÁ RẤT TO" width="265" height="140">
                </div>
            </a>
    
            <a href="#" aria-label="ĐĂNG KÝ NHẬN THÔNG TIN MỚI NHẤT TỪ SIÊU PHẨM SAMSUNG GALAXY AI" title="ĐĂNG KÝ NHẬN THÔNG TIN MỚI NHẤT TỪ SIÊU PHẨM SAMSUNG GALAXY AI">
                <div class="top-right__item">
                    <img src="/img/slider/567.webp" alt="ĐĂNG KÝ NHẬN THÔNG TIN MỚI NHẤT TỪ SIÊU PHẨM SAMSUNG GALAXY AI" width="265" height="140">
                </div>
            </a>
    
        </div>
    </div>
    
    <!-- Nhóm acer -->
    <div class="acer product-group">
        <h3 class="group-title">
            <span>Acer</span>
        </h3>
        <div id="acer_item" runat="server" class="product-row row">
            <!-- Các sản phẩm acer ở đây -->
        </div>
    </div>

    <!-- Nhóm asus -->
    <div class="asus product-group">
        <h3 class="group-title">
            <span>Asus</span>
        </h3>
        <div id="asus_item" runat="server" class="product-row row">
            <!-- Các sản phẩm asus ở đây -->
        </div>
    </div>
    
    <!-- Nhóm Dell -->
    <div class="msi product-group">
        <h3 class="group-title">
            <span>MSI</span>
        </h3>
        <div id="msi_item" runat="server"  class="product-row row">
            <!-- Các sản phẩm msi ở đây -->
        </div>
    </div>
    
    <!-- Nhóm Phụ kiện -->
    <div class="accessory product-group">
        <h3 class="group-title">
            <span>Phụ kiện</span>
        </h3>
        <div id="accessory_item" runat="server"  class="product-row row">
            <!-- Các sản phẩm phụ kiện ở đây -->
        </div>
    </div>

    <!-- Thêm các nhóm sản phẩm khác theo cấu trúc tương tự -->

</section>

<%--<section>
    <asp:GridView ID="gvItems" CssClass="table table-striped color-table" runat="server" AutoGenerateColumns="false"  OnRowDeleting="gvItems_RowDeleting" OnRowEditing="gvItems_RowEditing" OnRowUpdating="gvItems_RowUpdating" OnRowCancelingEdit="gvItems_RowCancelingEdit">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnItemId" runat="server" Value=""/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="name" HeaderText="Name"/>
            <asp:CommandField ShowEditButton="true" />
            <asp:CommandField ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>
</section>--%>
<script>
    function handleProductClick(id) {
        console.log(id);

        // Chuyển hướng tới trang chi tiết sản phẩm
        window.location.href = '/Views/ProductDetail.aspx?id='+id;
    }
</script>


</asp:Content>
