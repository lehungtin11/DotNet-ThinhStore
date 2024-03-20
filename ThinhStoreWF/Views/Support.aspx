<%@ Page Title="Support Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Support.aspx.cs" Inherits="ThinhStoreWF.Views.Support" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .page-title-container h1 {
            color: #ff671d;
            font-size: 80px;
            line-height: 1.15;
            margin-bottom: 0;
            max-width: 945px;
        }
        .page-title-container {
            display: table;
            height: 100%;
            max-height: 650px;
            min-height: 380px;
            padding-top: 60px;
            position: relative;
            width: 100%;
        }
        .app-dl-banner__section.section, .page-title-container.section, .top-banner-content .section {
            max-width: 1200px;
        
        }
        .section {
            margin: 0 auto;
        }
        .page-title-content {
            display: table-cell;
            padding-bottom: 25px;
            position: relative;
            vertical-align: middle;
            z-index: 10;
        }
        .content-wrapper--vertical-spacing, .dnd-section {
            padding: 30px 20px;
        }
        .dnd-section>.row-fluid {
            max-width: 1920px;
            margin :0 auto;
        }
        .dnd-section .dnd-column {
            padding: 0 20px;
        }
        .section {
            margin: 0 auto;
            max-width: 1080px;
            position: relative;
        }
        .card-row, .card-row__desc {
            text-align: center;
        }
        .card-row__card {
            display: inline-block;
            margin-right: -5px;
            padding: 15px;
            text-align: center;
            vertical-align: top;
            width: 33.333%;
        }
        .card-row__card-img {
            margin: 0 auto;
            max-width: 120px;
        }
        img {
            max-width: 100%;
        }
        .card-row__card-title {
            color: #ff671d;
            font-size: 20px;
            font-weight: 600;
            line-height: 28px;
            margin-bottom: 8px;
            text-align: center;
        }
    </style>
    <main class="body-container-wrapper">
        <div class="container-fluid body-container body-container--contact">
      <div class="row-fluid-wrapper">
      <div class="row-fluid">
      <div class="span12 widget-span widget-type-cell " style="" data-widget-type="cell" data-x="0" data-w="12">
      
      <div class="row-fluid-wrapper row-depth-1 row-number-1 dnd-section" style="background-color: rgb(60, 60, 59);padding: 30px 20px;">
      <div class="row-fluid ">
      <div class="span12 widget-span widget-type-custom_widget dnd-module" style="" data-widget-type="custom_widget" data-x="0" data-w="12">
      <div id="hs_cos_wrapper_dnd_area-module-1" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="background-color: rgb(60, 60, 59);" data-hs-cos-general-type="widget" data-hs-cos-type="module"><div class="page-title-container section" data-color="#3C3C3B" style="background-color: #3C3C3B">
        <div class="page-title-content">
          <h1 class="appear in-left appeared">Liên hệ hỗ trợ</h1>
          
        </div>
        <div class="page-title-img">
          <div class="page-title-img__gradient" style="background: linear-gradient(180deg, #3C3C3B -10%, rgba(60, 60, 59 ,0) 100%);"></div>          
        </div>
      </div></div>
      
      </div><!--end widget-span -->
      </div><!--end row-->
      </div><!--end row-wrapper -->
      
      <div class="row-fluid-wrapper row-depth-1 row-number-2 dnd-section">
      <div class="row-fluid ">
      <div class="span12 widget-span widget-type-cell dnd-column" style="" data-widget-type="cell" data-x="0" data-w="12">
      
      <div class="row-fluid-wrapper row-depth-1 row-number-3 dnd-row">
      <div class="row-fluid ">
      <div class="span12 widget-span widget-type-custom_widget dnd-module" style="" data-widget-type="custom_widget" data-x="0" data-w="12">
      <div id="hs_cos_wrapper_widget_1606103449415" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module"><div class="section card-row-container py-3">
        
      
        
      
        <div class="city-dropdown" style="display: none;">
            <div class="city-dropdown__desc">You are in:</div>  
            <div class="form-field field-select">          
                <select id="city-dropdown" class="card-row__city-dropdown">             
                    
                        <option value="vietnam">Vietnam</option>
                    
                </select>
            </div> 
        </div>
      
        
            
            <div class="city-panel" style="display: block;" id="group-vietnam">
            
      
              <div class="card-row">
                
                  <div class="card-row__card">
                    
                    <div class="card-row__card-img">
                      <img alt="icn_map" class=" lazyloaded" src="https://www.lalamove.com/hubfs/Lalamove%20Website%202020/icon/icn_map.svg">
                    </div>
                    
      
                    <div class="card-row__card-title">
                      Trung tâm hỗ trợ TP.HCM
                    </div>
                    <div class="card-row__card-desc">
                      <p style="text-align: justify;">Phòng 1004, Lầu 10, Tòa C, Tòa nhà Waseco, Số 10, Đường Phổ Quang, Phường 2, Quận Tân Bình, TP.HCM.</p>
                    </div>
      
                    
                    
                    
                    
                    
                    <div class="card-row__card-btn">
                      <a href="">
                        
                      </a>
                    </div>
                  </div>              
                
                  <div class="card-row__card">
                    
                    <div class="card-row__card-img">
                      <img alt="icn_map" class=" lazyloaded" src="https://www.lalamove.com/hubfs/Lalamove%20Website%202020/icon/icn_map.svg">
                    </div>
                    
      
                    <div class="card-row__card-title">
                      Điểm hỗ trợ Q. Tân Phú
                    </div>
                    <div class="card-row__card-desc">
                      <p style="text-align: justify;">Số <span>212 Đường Kênh 19/5, Phường Tây Thạnh, Quận Tân Phú, TP.HCM.</span></p>
      <p>&nbsp;</p>
                    </div>
      
                    
                    
                    
                    
                    
                    <div class="card-row__card-btn">
                      <a href="">
                        
                      </a>
                    </div>
                  </div>              
                
                  <div class="card-row__card">
                    
                    <div class="card-row__card-img">
                      <img alt="icn_map" class=" lazyloaded" src="https://www.lalamove.com/hubfs/Lalamove%20Website%202020/icon/icn_map.svg">
                    </div>
                    
      
                    <div class="card-row__card-title">
                      Điểm hỗ trợ  Thủ Đức
                    </div>
                    <div class="card-row__card-desc">
                      <p style="text-align: justify;">Số 183, <span>Đường </span>Lê Văn Chí, <span>Phường </span>Linh Trung, <span>Quận</span>&nbsp;Thủ Đức, TP.<span>HCM</span>.</p>
      <p>&nbsp;</p>
                    </div>
      
                    
                    
                    
                    
                    
                    <div class="card-row__card-btn">
                      <a href="">
                        
                      </a>
                    </div>
                  </div>              
                
                  <div class="card-row__card">
                    
                    <div class="card-row__card-img">
                      <img alt="icn_map" class=" lazyloaded" src="https://www.lalamove.com/hubfs/Lalamove%20Website%202020/icon/icn_map.svg">
                    </div>
                    
      
                    <div class="card-row__card-title">
                      Điểm hỗ trợ  Bình Dương
                    </div>
                    <div class="card-row__card-desc">
                      <p style="text-align: justify;"><span>Ô 14B, Đường D23, Khu dân cư Việt-Sing, Phường An Phú, TP. Thuận An, Tỉnh Bình Dương.</span></p>
      <p>&nbsp;</p>
                    </div>
      
                    
                    
                    
                    
                    
                    <div class="card-row__card-btn">
                      <a href="">
                        
                      </a>
                    </div>
                  </div>              
                
                  <div class="card-row__card">
                    
                    <div class="card-row__card-img">
                      <img alt="icn_map" class=" lazyloaded" src="https://www.lalamove.com/hubfs/Lalamove%20Website%202020/icon/icn_map.svg">
                    </div>
                    
      
                    <div class="card-row__card-title">
                      Trung tâm hỗ trợ Hà Nội
                    </div>
                    <div class="card-row__card-desc">
                      <p style="text-align: justify;">Phòng 1004, Tầng 7, Số 7, Đường Trần Phú, Phường Điện Biên, Quận Ba Đình, Hà Nội.</p>
      <p>&nbsp;</p>
                    </div>
      
                    
                    
                    
                    
                    
                    <div class="card-row__card-btn">
                      <a href="">
                        
                      </a>
                    </div>
                  </div>              
                
                  <div class="card-row__card">
                    
                    <div class="card-row__card-img">
                      <img alt="icn_map" class=" lazyloaded" src="https://www.lalamove.com/hubfs/Lalamove%20Website%202020/icon/icn_map.svg">
                    </div>
                    
      
                    <div class="card-row__card-title">
                      Điểm hỗ trợ  Hà Nội
                    </div>
                    <div class="card-row__card-desc">
                      <p style="text-align: justify;"><span>Tầng 1 - Lô 48-BT5, Khu đô thị mới Cầu Bươu, Xã Tân Triều, Huyện Thanh Trì, Hà Nội.</span></p>
      <p>&nbsp;</p>
                    </div>
      
                    
                    
                    
                    
                    
                    <div class="card-row__card-btn">
                      <a href="">
                        
                      </a>
                    </div>
                  </div>              
                
                  <div class="card-row__card">
                    
                    <div class="card-row__card-img">
                      <img alt="icn_call" class=" lazyloaded" src="https://www.lalamove.com/hubfs/Lalamove%20Website%202020/icon/icn_call.svg">
                    </div>
                    
      
                    <div class="card-row__card-title">
                      Hỗ trợ dịch vụ
                    </div>
                    <div class="card-row__card-desc">
                      <p>Hãy liên hệ với Dịch vụ chăm sóc khách hàng của chúng tôi tại <strong>mục Chat trong Ứng dụng</strong> tại đơn hàng của bạn để được tư vấn hỗ trợ.</p>
                    </div>
                    <div class="card-row__card-btn">
                      <a href="">
                      </a>
                    </div>
                  </div>
                  <div class="card-row__card">
                    <div class="card-row__card-img">
                      <img alt="icn_email" class=" lazyloaded" src="https://www.lalamove.com/hubfs/Lalamove%20Website%202020/icon/icn_email.svg">
                    </div>
                    <div class="card-row__card-title">
                      Gửi yêu cầu hỗ trợ
                    </div>
                    <div class="card-row__card-desc">
                      <p>Bạn có thể liên hệ với chúng tôi qua <strong><span style="text-decoration: underline;"><a rel="noopener">Phiếu yêu cầu hỗ trợ</a> </span></strong>tại trang <strong>Câu hỏi thường gặp</strong>, nếu có bất kỳ thắc mắc hoặc yêu cầu hỗ trợ.</p>
                    </div>
                    <div class="card-row__card-btn">
                      <a href="">
                        
                      </a>
                    </div>
                  </div>              
                
              </div>
      
            </div>
        
      
      </div></div>
      
      </div><!--end widget-span -->
      </div><!--end row-->
      </div><!--end row-wrapper -->
      
      </div><!--end widget-span -->
      </div><!--end row-->
      </div><!--end row-wrapper -->
      
      <div class="row-fluid-wrapper row-depth-1 row-number-4 dnd_area-row-2-padding dnd-section">
        <img src="/img/tile-split-getsupport.image.large_2x.png"/>
      </div><!--end widget-span -->
      </div><!--end row-->
      </div><!--end row-wrapper -->
      
      </div><!--end widget-span -->
      </div>
      </div>
      </div>
      </main>
</asp:Content>
