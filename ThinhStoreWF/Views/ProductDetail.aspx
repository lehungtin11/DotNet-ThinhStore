<%@ Page Title="Product Detail Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="ThinhStoreWF.Views.ProductDetail" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <section class="product-detail row">
        <div class="col col-xs-5 col-sm-5 col-md-5 col-lg-5">
            <div class="product-images">
                <div class="product-background">
                    <img runat="server" src="#" id="imgProduct" alt="Tên Sản Phẩm" width="150" height="243">
                </div>
            </div>
            <div class="endow">
                <div class="endow-title">
                    <p>
                        <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512">
                            <path d="M32 448c0 17.7 14.3 32 32 32h160V320H32v128zm256 32h160c17.7 0 32-14.3 32-32V320H288v160zm192-320h-42.1c6.2-12.1 10.1-25.5 10.1-40 0-48.5-39.5-88-88-88-41.6 0-68.5 21.3-103 68.3-34.5-47-61.4-68.3-103-68.3-48.5 0-88 39.5-88 88 0 14.5 3.8 27.9 10.1 40H32c-17.7 0-32 14.3-32 32v80c0 8.8 7.2 16 16 16h480c8.8 0 16-7.2 16-16v-80c0-17.7-14.3-32-32-32zm-326.1 0c-22.1 0-40-17.9-40-40s17.9-40 40-40c19.9 0 34.6 3.3 86.1 80h-86.1zm206.1 0h-86.1c51.4-76.5 65.7-80 86.1-80 22.1 0 40 17.9 40 40s-17.9 40-40 40z"></path>
                        </svg>
                        Ưu đãi thêm
                    </p>
                </div>
                <div class="endow-content">
                    <p><span style="color:#003300">Giảm thêm đến 200.000đ cho khách hàng là Học sinh - Sinh viên ( xem chi tiết)</span></p>

                    <p><span style="color:#003300">Giảm thêm 1% cho khách hàng cũ đã mua hàng tại( Xem chi tiết)</span></p>

                    <p><span style="color:#003300">Miễn phí ship hàng +&nbsp;giảm thêm đến 200.000đ&nbsp;khi mua hàng online ( xem chi tiết)</span></p>
                </div>
            </div>
        </div>
        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
            <div class="product-info">
                <h1 runat="server" id="h1Name">Tên Sản Phẩm</h1>
                <div class="d-flex align-start">
                    <div class="text-right">
                        <p runat="server" class="old-price" id="pOldPrice">$Giá</p>
                        <p runat="server" class="price" id="pPrice">$Giá</p>
                    </div>
                    <div class="product-installment text-right">
                        <span>Trả góp 0%</span>
                        <p>
                            Trả góp chỉ từ <b runat="server" id="bTraGop">9,717,000đ</b>
                        </p>
                    </div>
                </div>
                <div class="description_wrapper">
                    <h3 class="description label">Thông tin sản phẩm</h3>
                    <p runat="server" class="description" id="pDescription"></p>
                </div>
                <div id="product-specs" class="product-specs">
                    <h3>Thông Số Kỹ Thuật</h3>
                    <ul>
                        <li>CPU: <span runat="server" id="spanCPU">Thông tin CPU</span></li>
                        <li>Hệ điều hành: <span runat="server" id="spanOS">Thông tin Hệ điều hành</span></li>
                        <li>RAM: <span runat="server" id="spanRAM">Thông tin RAM</span></li>
                        <li>Bộ nhớ trong: <span runat="server" id="spanStorage">Thông tin bộ nhớ</span></li>
                        <li>Dung lượng pin: <span runat="server" id="spanBattery">Thông tin pin</span></li>
                        <li>Card VGA: <span runat="server" id="spanCardVGA">Thông tin VGA</span></li>
                        <li>Độ phân giải màn hình: <span runat="server" id="spanScreen">Thông tin màn hình</span></li>
                    </ul>
                </div>
                <span class="btn btn-primary buy-now" onclick="goBuy()">Thêm vào giỏ hàng</span>
            </div>
        </div>
    </section>
    <section class="similar-products">
        <h2>Sản phẩm tương tự</h2>
        <div runat="server" id="divSimilarProducts" class="product-list product-row">
            <!-- Các sản phẩm tương tự sẽ được thêm vào đây -->
        </div>
    </section>

    <script>
        function handleProductClick(id) {
            console.log(id);

            // Chuyển hướng tới trang chi tiết sản phẩm
            window.location.href = '/Views/ProductDetail.aspx?id=' + id;
        }

        function goBuy() {
            var userId = localStorage.getItem('userId');
            var productId = window.location.search.split('?id=')[1];
            var productName = $('#MainContent_h1Name').text();
            var productPrice = $('#MainContent_pPrice').text().replace(/[^0-9.-]+/g, ""); // Giả sử giá sản phẩm là một chuỗi số, loại bỏ ký tự không phải số
            var productImage = $('#MainContent_imgProduct').attr('src'); // Sử dụng attr('src') thay vì text() cho hình ảnh
            
            $.get('/ApiHandler.ashx', { userId, productId, orderItemQuantity: 1, typeRequest: "addOrder" }, function (data) {
                alert("Đã thêm sản phẩm " + productName + " vào giỏ hàng.");
                updateCartCount();
            });
        }

        function getCart() {
            var cart = localStorage.getItem('cart');
            return cart ? JSON.parse(cart) : [];
        }

        function saveCart(cart) {
            localStorage.setItem('cart', JSON.stringify(cart));
        }


    </script>
    
</asp:Content>
