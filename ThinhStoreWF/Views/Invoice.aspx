<%@ Page Title="Cart Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="ThinhStoreWF.Views.Invoice" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Modal -->
    <div class="modal fade" id="orderDetailsModal" tabindex="-1" aria-labelledby="orderDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orderDetailsModalLabel">Chi Tiết Đơn Hàng</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="cart-table table table-striped color-table">
                        <thead>
                            <tr>
                                <th width="200px">Hình Ảnh</th>
                                <th>Sản Phẩm</th>
                                <th>Số Lượng</th>
                            </tr>
                        </thead>
                        <tbody runat="server" id="tbodyCart">
                            <!-- Nội dung sản phẩm sẽ được đổ vào đây -->
                        </tbody>
                    </table> 
                </div>
            </div>
        </div>
    </div>
    <div style="height:100vh" class="row m-3">
        <div class="col-md-8 offset-md-2">
            <div class="card">
                <asp:Literal runat="server" ID="ltrMessage"></asp:Literal>
                <div class="card-header">
                    <h4>Lịch sử giao dịch</h4>
                </div>
                <div class="card-body">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                        ConnectionString="<%$ ConnectionStrings:DBConnection %>" 
                        SelectCommand="SELECT iv.invoiceId, iv.orderId, iv.paymentMethod, iv.paymentStatus, iv.finalPrice, iv.paymentDetails, iv.issuedDate
                        FROM invoices iv
                        LEFT JOIN orders oi ON oi.orderId = iv.orderId
                        WHERE oi.userId = 2" >
                    </asp:SqlDataSource>

                    <asp:GridView ID="GridView1" OnRowCommand="GridView1_RowCommand" CssClass="table table-striped color-table" runat="server" DataSourceID="SqlDataSource1" 
                        AutoGenerateColumns="False" DataKeyNames="invoiceId" 
                        AllowPaging="True" AllowSorting="True">
                        <Columns>
                            <asp:BoundField DataField="invoiceId" HeaderText="ID" ReadOnly="True" SortExpression="invoiceId" />
                            <asp:BoundField DataField="paymentMethod" HeaderText="Hình thức thanh toán" SortExpression="paymentMethod" />
                            <asp:BoundField DataField="paymentStatus" HeaderText="Trạng thái thanh toán" SortExpression="paymentStatus" />
                            <asp:BoundField DataField="finalPrice" HeaderText="Tổng giá trị" SortExpression="finalPrice"/>
                            <asp:BoundField DataField="paymentDetails" HeaderText="Thông tin phương thức" SortExpression="paymentDetails"/>
                            <asp:BoundField DataField="issuedDate" HeaderText="Ngày giao dịch" SortExpression="issuedDate"/>
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDetail" runat="server" 
                                                    CommandName="ShowDetails" 
                                                    CommandArgument='<%# Eval("orderId") %>' 
                                                    OnClientClick='<%# "showOrderDetails(" + Eval("orderId") + "); return false;" %>' 
                                                    Text="Chi tiết" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        function showOrderDetails(orderId) {
            var userId = localStorage.getItem('userId');
            $.ajax({
                url: '/ApiHandler.ashx', // Đường dẫn tới API hoặc trang xử lý
                type: 'GET',
                data: { userId: userId, orderId, typeRequest: "getOrdersDetail" },
                success: function(data) {
                    // Cập nhật nội dung vào .modal-body của modal

                    console.log(data);
                    $('.cart-table tbody').empty();
                    

                    if (!data) return;

                    data.forEach(function (product, index) {
                        var productHTML = `
                        <tr>
                            <td><img class="cart-product-image" src="${product.image}" alt="${product.name}"></td>
                            <td>${product.name}</td>
                            <td>${product.quantity}</td>
                        </tr>`;
                        $('.cart-table tbody').append(productHTML);
                    });
                    // Hiển thị modal
                    $('#orderDetailsModal').modal('show');
                },
                error: function(error) {
                    console.log('Error:', error);
                }
            });
            
        }
    </script>

    
</asp:Content>
