<%@ Page Title="Cart Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ThinhStoreWF.Views.Cart" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="m-3">
        <a class="btn btn-primary" href="/Views/Invoice.aspx">
            <i class="fa fa-money" aria-hidden="true"></i> 
            Lịch sử giao dịch
        </a>
    </div>
    <div class="container mt-3 mb-3">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card">
                <asp:Literal runat="server" ID="ltrMessage"></asp:Literal>
                <div class="card-header">
                    <h4>Thông tin đơn hàng</h4>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <asp:DropDownList CssClass="form-control" ID="ddlPaymentMethod" runat="server">
                            <asp:ListItem Value="">-- Hình thức thanh toán --</asp:ListItem>
                            <asp:ListItem Value="cash">Thanh toán khi nhận hàng</asp:ListItem>
                            <asp:ListItem Value="transfer">Chuyển khoản</asp:ListItem>
                            <asp:ListItem Value="momo">Momo</asp:ListItem>
                            <asp:ListItem Value="zalopay">Zalo Pay</asp:ListItem>
                            <asp:ListItem Value="visa">Visa</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtOrderEmail" CssClass="form-control" runat="server" placeholder="Email"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtOrderPhone" CssClass="form-control" runat="server" placeholder="Số điện thoại"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtOrderAddress" CssClass="form-control" TextMode="MultiLine" Columns="20" Rows="5" runat="server" placeholder="Địa chỉ giao hàng"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtOrderNote" CssClass="form-control" TextMode="MultiLine" Columns="20" Rows="5" runat="server" placeholder="Ghi chú đơn hàng"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtTotalPrice" CssClass="form-control" runat="server" placeholder="Tổng tiền" ></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtOrderId" CssClass="form-control" runat="server" placeholder="OrderId" ></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <section class="cart-total">
        <h2 runat="server" id="h2TotalPrice">Tổng Cộng: $1200</h2>
        <asp:Button runat="server" ID="btnCheckout" class="btn btn-success btn-checkout" Text="Thanh Toán" OnClick="btnCheckout_Click"/>
    </section>
    <section class="cart-container">
        <table class="cart-table table table-striped color-table">
            <thead>
                <tr>
                    <th width="200px">Hình Ảnh</th>
                    <th>Sản Phẩm</th>
                    <th>Số Lượng</th>
                    <th>Giá</th>
                    <th></th>
                </tr>
            </thead>
            <tbody runat="server" id="tbodyCart">
                <!-- Nội dung sản phẩm sẽ được đổ vào đây -->
            </tbody>
        </table>        
    </section>
    
    <%--<section class="cart-total">
        <h2>Tổng Cộng: $1200</h2>
        <span class="btn btn-success btn-checkout" id="checkout-button">Thanh Toán</span>
    </section>--%>

    <script>
        var cart = getCart(); // Lấy giỏ hàng từ localStorage

        $(document).ready(function () {

            $('#checkout-button').click(function () {
                // Lấy tất cả các checkbox đã được tích
                var selectedProducts = $('.product-checkbox:checked').map(function () {
                    return $(this).val();
                }).get();
                console.log(selectedProducts)
                if (selectedProducts.length > 0) {
                    // Gửi request đến server để cập nhật trạng thái thanh toán
                    $.ajax({
                        url: '/ApiHandler.ashx',
                        type: 'POST',
                        data: {
                            typeRequest: "checkout",
                            orderItemIds: selectedProducts
                        },
                        success: function (response) {
                            console.log('Thanh toán thành công');

                        },
                        error: function (error) {
                            console.log('Error: ', error);
                        }
                    });
                } else {
                    alert('Vui lòng chọn sản phẩm để thanh toán.');
                }
            });

            // Hàm chuyển đổi định dạng giá tiền thành số
            function parsePrice(priceStr) {
                return parseInt(priceStr.replace(/\./g, '').replace(/\D/g, ''));
            }

            async function updateCartTable() {
                $('.cart-table tbody').empty();
                var total = 0;
                const cart = await updateCartCount(); // Đợi cho updateCartCount hoàn thành

                if (!cart) return; // Nếu không có giỏ hàng, thoát khỏi hàm

                cart.forEach(function (product, index) {
                    var price = parsePrice(product.price); // Giả sử bạn đã định nghĩa hàm parsePrice
                    var productHTML = `
                    <tr>
                        <td><img class="cart-product-image" src="${product.image}" alt="${product.name}"></td>
                        <td>${product.name}</td>
                        <td><input class="quantity" type="number" value="${product.quantity || 1}" min="0" data-index="${index}"></td>
                        <td data-price="${price * (product.quantity || 1)}">${(price * (product.quantity || 1)).toLocaleString('vi-VN')} ₫</td>
                        <td><span class="btn btn-primary delete-btn" data-index="${index}">Xóa</span></td>
                    </tr>`;
                    $('.cart-table tbody').append(productHTML);
                    $('#MainContent_txtOrderId').hide().val(product.orderId);

                    total += price * (product.quantity || 1);
                });

                updateTotal(total); // Giả sử bạn đã định nghĩa hàm updateTotal
            }


            function updateTotal(total) {
                console.log(total);
                $('#MainContent_txtTotalPrice').hide().val(total);
                $('.cart-total h2').text("Tổng Cộng: " + total.toLocaleString('vi-VN') + " ₫");
            }

            function updateOrder(orderItemId, orderItemQuantity) {
                $.get('/ApiHandler.ashx', { orderItemId, orderItemQuantity, typeRequest: "updateOrder" }, function (data) {
                    updateCartTable();
                    console.log('Update order ', data);
                });
            }

            function deleteOrder(orderItemId) {
                $.get('/ApiHandler.ashx', { orderItemId, typeRequest: "deleteOrder" }, function (data) {
                    updateCartTable();
                    console.log('Delete order ', data);
                });
            }

            // Hàm để xóa sản phẩm khỏi giỏ hàng
            function removeFromCart(index) {
                /*
                cart.splice(index, 1); // Xóa sản phẩm khỏi mảng
                saveCart(cart); // Lưu giỏ hàng cập nhật vào localStorage
                updateCartTable(); // Cập nhật bảng
                */

                var orderItemId = cart[index].orderItemId;
                deleteOrder(orderItemId)
            }

            

            $(document).on('change', '.quantity', function() {
                var index = $(this).data('index');
                var quantity = Math.max(0, parseInt($(this).val())); // Đảm bảo số lượng không âm
                $(this).val(quantity); // Cập nhật số lượng trên giao diện

                var price = parsePrice(cart[index].price);
                /*
                cart[index].quantity = quantity; // Cập nhật số lượng trong giỏ hàng
                saveCart(cart); // Lưu giỏ hàng vào localStorage
                */

                var orderItemId = cart[index].orderItemId;
                updateOrder(orderItemId, quantity);

                /*
                var newTotal = price * quantity;
                $(this).closest('tr').find('td[data-price]').text(newTotal.toLocaleString('vi-VN') + " ₫");
                recalculateTotal();
                */
            });

            function recalculateTotal() {
                var newTotal = 0;
                $('.cart-table tbody tr').each(function() {
                    var price = parsePrice($(this).find('td[data-price]').text());
                    newTotal += price;
                });
                updateTotal(newTotal);
            }

            $(document).on('click', '.delete-btn', function() {
                var index = $(this).data('index');
                removeFromCart(index);
                // recalculateTotal();
            });


            updateCartTable(); // Cập nhật bảng khi trang tải xong
        });

    </script>
</asp:Content>