

var sliderProducts = [
    {
        image: "/img/slider/18_Jul9ad01c82769b0d85949abe6bc1eeee06.jpg",
        name: "18_Jul9ad01c82769b0d85949abe6bc1eeee06.jpg"
    },
    {
        image: "/img/slider/14_Dec3c8bb2d1549933cb49e99e5ac8927ed3.jpg",
        name: "14_Dec3c8bb2d1549933cb49e99e5ac8927ed3.jpg"
    },
    {
        image: "/img/slider/27_Julb770209ae06e9aaf422768eac1a097e8.jpg",
        name: "27_Julb770209ae06e9aaf422768eac1a097e8.jpg"
    },
    {
        image: "/img/slider/02_Janed7b3157ef035162bae224c5c0584749.jpg",
        name: "02_Janed7b3157ef035162bae224c5c0584749.jpg"
    },
    {
        image: "/img/slider/13_Decf94af3722b7ffd3e072b782831b06337.jpg",
        name: "13_Decf94af3722b7ffd3e072b782831b06337.jpg"
    }
]

function addProductsToSection(products, sectionClass) {
    products.forEach(function (product, index) {
        var productHTML = `
            <article class="product-item" data-index="${index}">
                ${product.discount ? "<div class='ex_pricesale percent'>" + product.discount + "%</div>" : ""}
                <img src="${product.image}" alt="${product.name}">
                <h4 class="line-clamp product-title">${product.name}</h4>
                <div class="price">
                    ${product.price ? "<ins class='new-price'>" + product.price + "</ins>" : ""}
                    ${product.old_price ? "<del class='old-price'>" + product.old_price + "</del>" : ""}
                </div>
                <div class="cb_promotion_stand">
                    <div class="gift-detail">
                        [Từ 14.1-9.2]&nbsp;Miễn phí cài đặt Windows 11, Miễn phí cân màu màn hình công nghệ cao, Balo thời trang AZ 
                    </div>
                </div>
            </article>`;
        $(sectionClass + ' .product-row').append(productHTML);
    });

    // Event listener cho chi tiết sản phẩm
    $(sectionClass + ' .product-item').on('click', function () {
        var index = $(this).data('index');
        localStorage.setItem('selectedProduct', JSON.stringify(products[index]));
        localStorage.setItem('similarProducts', JSON.stringify(products)); // Lưu tất cả sản phẩm tương tự
        window.location.href = '/Views/ProductDetail.aspx';
    });

    // Event listener riêng cho nút "Mua Ngay"
    $(sectionClass + ' .product-item .buy-now').on('click', function (e) {
        e.stopPropagation();
        var index = $(this).data('index');
        var product = products[index];

        var cart = getCart();
        cart.push(product); // Thêm sản phẩm vào giỏ hàng
        saveCart(cart); // Lưu giỏ hàng

        alert("Đã thêm sản phẩm " + product.name + " vào giỏ hàng.");
    });

}

// Hàm để lấy giỏ hàng từ localStorage hoặc tạo mới nếu chưa có
function getCart() {
    var cart = localStorage.getItem('cart');
    return cart ? JSON.parse(cart) : [];
}

// Hàm để lưu giỏ hàng vào localStorage
function saveCart(cart) {
    localStorage.setItem('cart', JSON.stringify(cart));
}

async function updateCartCount() {
    try {
        var userId = localStorage.getItem('userId');
        if (userId) {
            const data = await $.ajax({
                url: '/ApiHandler.ashx',
                type: 'GET',
                data: { userId: userId, typeRequest: "getOrders" }
            });
            localStorage.setItem('cart', JSON.stringify(data));
            const cart = JSON.parse(localStorage.getItem('cart')) || [];
            let totalQuantity = cart.reduce((total, item) => total + item.quantity, 0);
            document.getElementById('cartQuantity').innerText = totalQuantity; // Cập nhật số lượng trên giao diện
            console.log('Update cart');
            return cart;
        }
    } catch (err) {
        console.log('Error at updateCartCount ', err);
    }
}

function addImagesToCarousel(products) {
    var carouselInner = $('#productCarousel .carousel-inner');
    var indicators = $('#productCarousel .carousel-indicators');
    carouselInner.empty();
    indicators.empty();

    products.forEach(function (product, index) {
        var isActive = index === 0 ? 'active' : '';

        // Thêm slide
        var slideHTML = `
            <div class="carousel-item ${isActive}">
            <div class="img-warp d-block w-100">
                <img src="${product.image}" alt="${product.name}">
            </div>
            </div>`;
        carouselInner.append(slideHTML);

        // Thêm indicator với chữ
        var indicatorHTML = `
            <li data-target="#productCarousel" data-slide-to="${index}" class="${isActive}">
                <span class="indicator-text">${product.name}</span> <!-- Thêm chữ ở đây -->
            </li>`;
        indicators.append(indicatorHTML);
    });
}

addImagesToCarousel(asusProducts);



$(document).ready(function () {
    //addProductsToSection(acerProducts, '.acer');
    //addProductsToSection(asusProducts, '.asus');
    //addProductsToSection(msiProducts, '.msi');
    //addProductsToSection(accessoryProducts, '.accessory');
    updateCartCount();
    $('.dropdown-content a').on('click', function (e) {
        e.preventDefault(); // Ngăn chặn hành vi mặc định của liên kết
        var category = $(this).attr('href').substring(1); // Lấy phần sau dấu '#' trong href

        // Lưu danh sách sản phẩm tương ứng với nhóm đã chọn
        switch (category) {
            case 'acer':
                localStorage.setItem('selectedCategory', JSON.stringify(asusProducts));
                break;
            case 'asus':
                localStorage.setItem('selectedCategory', JSON.stringify(asusProducts));
                break;
            case 'msi':
                localStorage.setItem('selectedCategory', JSON.stringify(msiProducts));
                break;
            case 'accessory':
                console.log('hello')
                localStorage.setItem('selectedCategory', JSON.stringify(accessoryProducts));
                break;
            // Thêm các case khác tương tự nếu cần
        }

        window.location.href = `/page/${category}.html`; // Chuyển hướng đến trang nhóm sản phẩm
    });

    // Gọi hàm này khi muốn cập nhật carousel với hình ảnh sản phẩm mới
    addImagesToCarousel(sliderProducts); // Thay đổi 'sliderProducts' tùy theo nhóm sản phẩm

});