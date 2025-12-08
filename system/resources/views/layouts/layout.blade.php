<!DOCTYPE html>
<html>

   <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>{{ $site_name->value ?? 'CPS' }} Dashboard</title>
      <!-- Tell the browser to be responsive to screen width -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="shortcut icon" type="image/x-icon" href="{{ asset('dist/img/rcsdd.png') }}">
      <!-- Font Awesome -->
      <link rel="stylesheet" href="{{ asset('plugins/fontawesome-free/css/all.min.css') }}">
      <!-- Ionicons -->
      <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
      <!-- Tempusdominus Bbootstrap 4 -->
      <link rel="stylesheet" href="{{ asset('plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css') }}">
      <!-- iCheck -->
      <link rel="stylesheet" href="{{ asset('plugins/icheck-bootstrap/icheck-bootstrap.min.css') }}">
      <!-- JQVMap -->
      <link rel="stylesheet" href="{{ asset('plugins/jqvmap/jqvmap.min.css') }}">
      <link rel="icon" href="{{asset('dist/img/rcsd.png')}}" type="image/x-icon">
      <link rel="shortcut icon" href="{{asset('dist/img/rsad.png')}}" type="image/x-icon">
      @vite(['public/assets/scss/apps.scss'])
      <!-- Google font-->
      <link href="https://fonts.googleapis.com/css?family=Rubik:400,400i,500,500i,700,700i&amp;display=swap" rel="stylesheet">
      <link href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i,700,700i,900&amp;display=swap" rel="stylesheet">
      <style>
         .page-wrapper.material-icon::before {
         position: absolute;
         content: "";
         left: 0;
         width: 100%;
         height: 238px;
         background: linear-gradient(103.75deg, #2c323f -13.9%, #1D1E26 79.68%);
         }
         .page-body {
         margin-top: -10px !important;
         }
         .widget-1 {
         background-image: none!important;
         background-size: cover;
         margin-bottom: 25px;
         }
         .user-icon.danger {
         border: 1px solid #f44336;
         }
         .user-list .user-icon.danger .user-box {
         background: #ffdad7;
         padding: 10px;
         }
         img.img-40.rounded-circle {
         background: aliceblue;
         border: 1px solid #e1e1e1;
         padding: 5px;
         }
         .card.profile-box {
         background: linear-gradient(103.75deg, #2c323f -13.9%, #1d1e26 79.68%)!important; /* Gradient background */
         }
         .fl-main-container .fl-container.fl-flasher.fl-success:not(.fl-rtl) {
         border-left: .8em solid #8BC34A !important;
         }
         .fl-main-container .fl-container.fl-flasher:not(.fl-rtl) {
         border-radius: 2.375em 0 0 .375em !important;
         }
         .fl-main-container .fl-container.fl-success .fl-icon {
         background-color: #8BC34A !important;
         }
         .fl-main-container .fl-container.fl-flasher.fl-success .fl-title {
         color: #8BC34A !important;
         }
         .fl-main-container .fl-container.fl-success .fl-progress-bar {
         background-color: #8BC34A !important;
         }
         .fl-main-container .fl-container.fl-success .fl-progress-bar .fl-progress {
         background-color: #6a9933 !important;
         }
         @media (prefers-color-scheme: dark) {
         .fl-main-container .fl-container.fl-flasher {
         background-color: rgb(37 39 50) !important;
         color: rgb(255, 255, 255) !important;
         }
         }
         label {
         margin-top: 10px;
         }
         div#DataTables_Table_0_filter input {
         width: 100% !important;
         /* background: currentColor; */
         min-width: 100%;
         max-width: 100%;
         position: absolute;
         margin: 0;
         padding: 0;
         }
         div#DataTables_Table_0_filter {
         margin: 0;
         padding: 0;
         margin-bottom: 49px;
         position: relative;
         }
         h1.m-0.text-dark {
         color: #ffff !important;
         }
         .breadcrumb {
         align-content: stretch !important;
         justify-content: flex-end !important;
         }
         .user-details .customers {
         width: 257px;
         }
         * a {
         color: #4CAF50;
         }
         .font-primary {
         color: #4CAF50 !important;
         }
      </style>
   </head>
   <body @if(Route::current()->getName() == 'home') onload="startTime()" @elseif (Route::current()->getName() == 'button-builder') class="button-builder" @endif>
   <div class="loader-wrapper">
      <div class="loader-index"><span></span></div>
      <svg>
         <defs></defs>
         <filter id="goo">
            <fegaussianblur in="SourceGraphic" stddeviation="11" result="blur"></fegaussianblur>
            <fecolormatrix in="blur" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 19 -9" result="goo"> </fecolormatrix>
         </filter>
      </svg>
   </div>
   <!-- tap on top starts-->
   <div class="tap-top"><i data-feather="chevrons-up"></i></div>
   <!-- tap on tap ends-->
   <!-- page-wrapper Start-->
   <div class="page-wrapper compact-wrapper" id="pageWrapper">
      <!-- Page Header Start-->
      <div class="page-header">
         <div class="header-wrapper row m-0">
            <form class="form-inline search-full col" action="#" method="get">
               <div class="form-group w-100">
                  <div class="Typeahead Typeahead--twitterUsers">
                     <div class="u-posRelative">
                        <input class="demo-input Typeahead-input form-control-plaintext w-100" type="text" placeholder="Search Cuba .." name="q" title="" autofocus>
                        <div class="spinner-border Typeahead-spinner" role="status"><span class="sr-only">Loading...</span></div>
                        <i class="close-search" data-feather="x"></i>
                     </div>
                     <div class="Typeahead-menu"></div>
                  </div>
               </div>
            </form>
            
            <div class="left-header col-xxl-5 col-xl-6 col-lg-5 col-md-4 col-sm-3 p-0">
               <div class="notification-slider">
                  <div class="d-flex h-100">
                     <img src="{{ asset('assets/images/giftools.gif') }}" alt="gif">
                     <h6 class="mb-0 f-w-400"><span class="font-primary">Don't Miss Out! </span><span class="f-light">Save upto 90% on our licenses.</span></h6>
                     <i class="icon-arrow-top-right f-light"></i>
                  </div>
                  <div class="d-flex h-100">
                     <img src="{{ asset('assets/images/giftools.gif') }}" alt="gif">
                     <h6 class="mb-0 f-w-400"><span class="f-light">Buy cheap licenses from <?php $reseller = App\Models\Reseller::firstWhere('user_id', Auth::id()); $domain = strtolower($reseller->domain); echo $domain; ?>! </span></h6>
                     <a class="ms-1" href="<?php $reseller = App\Models\Reseller::firstWhere('user_id', Auth::id()); $domain = strtolower($reseller->domain); echo $domain; ?>" target="_blank">Buy now !</a>
                  </div>
               </div>
            </div>
            <div class="nav-right col-xxl-7 col-xl-6 col-md-7 col-8 pull-right right-header p-0 ms-auto">
               <ul class="nav-menus">
                  @if (Auth::user()->role == 'admin' || Auth::user()->role == 'master')
                  <li class="onhover-dropdown">
                     <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#ffffff">
                        <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                        <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                        <g id="SVGRepo_iconCarrier">
                           <path d="M2 14C2 10.2288 2 8.34315 3.17157 7.17157C4.34315 6 6.22876 6 10 6H14C17.7712 6 19.6569 6 20.8284 7.17157C22 8.34315 22 10.2288 22 14C22 17.7712 22 19.6569 20.8284 20.8284C19.6569 22 17.7712 22 14 22H10C6.22876 22 4.34315 22 3.17157 20.8284C2 19.6569 2 17.7712 2 14Z" stroke="#ffffff" stroke-width="1.5"></path>
                           <path d="M16 6C16 4.11438 16 3.17157 15.4142 2.58579C14.8284 2 13.8856 2 12 2C10.1144 2 9.17157 2 8.58579 2.58579C8 3.17157 8 4.11438 8 6" stroke="#ffffff" stroke-width="1.5"></path>
                           <path d="M12 17.3333C13.1046 17.3333 14 16.5871 14 15.6667C14 14.7462 13.1046 14 12 14C10.8954 14 10 13.2538 10 12.3333C10 11.4129 10.8954 10.6667 12 10.6667M12 17.3333C10.8954 17.3333 10 16.5871 10 15.6667M12 17.3333V18M12 10V10.6667M12 10.6667C13.1046 10.6667 14 11.4129 14 12.3333" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round"></path>
                        </g>
                     </svg>
                     <div class="onhover-show-div bookmark-flip">
                        <div class="flip-card">
                           <div class="flip-card-inner">
                              <div class="front">
                                 <h6 class="f-18 mb-0 dropdown-title">CPS Balance</h6>
                                 <ul class="bookmark-dropdown">
                                    <li>
                                       <div class="">
                                          <div class="text-center">
                                             <div class="bookmark-content text-center">
                                                <div style=" font-size: 47px; color: #2f8d33; ">
                                                   {{ \App\Http\Controllers\ApiController::getBalanceFromLD() }}
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </li>
                                    
                                 </ul>
                              </div>
                              <div class="back">
                                 <ul>
                                    <li>
                                       <div class="bookmark-dropdown flip-back-content">
                                          <input type="text" placeholder="search...">
                                       </div>
                                    </li>
                                    <li><a class="f-w-700 d-block flip-back" id="flip-back" href="javascript:void(0)">Back</a></li>
                                 </ul>
                              </div>
                           </div>
                        </div>
                     </div>
                  </li>
                  @endif
                  <li>
                     <div class="mode">
                        <svg>
                           <use href="{{ asset('assets/svg/icon-sprite.svg#moon') }}"></use>
                        </svg>
                     </div>
                  </li>
                  <li class="profile-nav onhover-dropdown pe-0 py-0">
                     <div class="media profile-media">
                        <img class="b-r-10" src="{{ asset('dist/img/rsdc.png') }}" style=" width: 37px; " alt="">
                        <div class="media-body">
                           <span>{{ \Auth::user()->username }}</span>
                           <p class="mb-0 font-roboto">Reseller <i class="middle fa fa-angle-down"></i></p>
                        </div>
                     </div>
                     <ul class="profile-dropdown onhover-show-div">
                        <li><a href="{{ route('logout') }}"><i data-feather="log-in"> </i><span>LOGOUT</span></a></li>
                     </ul>
                  </li>
               </ul>
            </div>
         </div>
      </div>
      <!-- Page Header Ends  -->
      <!-- Page Body Start-->
      <div class="page-body-wrapper">
         <!-- Page Sidebar Start-->
         <div class="sidebar-wrapper" sidebar-layout="stroke-svg">
            <div>
               <div class="logo-wrapper">
                  <a href="{{ route('home') }}"><img  class="img-fluid for-light" src="{{ asset('dist/img/rssdc.png') }}" style=" width: 50px; " alt=""><img class="img-fluid for-dark" src="{{ asset('dist/img/rasdc.png') }}" alt=""></a>
                  <div class="back-btn"><i class="fa fa-angle-left"></i></div>
                  <div class="toggle-sidebar"><i class="status_toggle middle sidebar-toggle" data-feather="grid"> </i></div>
               </div>
               <div class="logo-icon-wrapper">
                  <a href="{{ route('home') }}"><img class="img-fluid" style=" width: 50px; " src="{{ asset('dist/img/rxcc.png') }}" alt=""></a>
               </div>
               <nav class="sidebar-main">
                  <div class="left-arrow" id="left-arrow"><i data-feather="arrow-left"></i></div>
                  <div id="sidebar-menu">
                     <ul class="sidebar-links" id="simple-bar">
                        <li class="back-btn">
                           <a href="{{ route('home') }}"><img class="img-fluid" style=" width: 50px; " src="{{ asset('dist/img/dsadc.png') }}" alt=""></a>
                           <div class="mobile-back text-end"><span>Back</span><i class="fa fa-angle-right ps-2" aria-hidden="true"></i></div>
                        </li>
                        <li class="pin-title sidebar-main-title">
                           <div>
                              <h6>Pinned</h6>
                           </div>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('home') }}">
                              <svg class="stroke-icon">
                                 <svg fill="#000000" viewBox="0 0 1920 1920" xmlns="http://www.w3.org/2000/svg">
                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                    <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                    <g id="SVGRepo_iconCarrier">
                                       <path d="M833.935 1063.327c28.913 170.315 64.038 348.198 83.464 384.79 27.557 51.84 92.047 71.944 144 44.387 51.84-27.558 71.717-92.273 44.16-144.113-19.426-36.593-146.937-165.46-271.624-285.064Zm-43.821-196.405c61.553 56.923 370.899 344.81 415.285 428.612 56.696 106.842 15.811 239.887-91.144 296.697-32.64 17.28-67.765 25.411-102.325 25.411-78.72 0-154.955-42.353-194.371-116.555-44.386-83.802-109.102-501.346-121.638-584.245-3.501-23.717 8.245-47.21 29.365-58.277 21.346-11.294 47.096-8.02 64.828 8.357ZM960.045 281.99c529.355 0 960 430.757 960 960 0 77.139-8.922 153.148-26.654 225.882l-10.39 43.144h-524.386v-112.942h434.258c9.487-50.71 14.231-103.115 14.231-156.084 0-467.125-380.047-847.06-847.059-847.06-467.125 0-847.059 379.935-847.059 847.06 0 52.97 4.744 105.374 14.118 156.084h487.454v112.942H36.977l-10.39-43.144C8.966 1395.137.044 1319.128.044 1241.99c0-529.243 430.645-960 960-960Zm542.547 390.686 79.85 79.85-112.716 112.715-79.85-79.85 112.716-112.715Zm-1085.184 0L530.123 785.39l-79.85 79.85L337.56 752.524l79.849-79.85Zm599.063-201.363v159.473H903.529V471.312h112.942Z" fill-rule="evenodd"></path>
                                    </g>
                                 </svg>
                              </svg>
                              <svg class="fill-icon">
                                 <use href="{{ route('home') }}"></use>
                              </svg>
                              <span>Dashboard</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('licenses') }}/add">
                              <svg class="stroke-icon">
                              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <circle cx="12" cy="12" r="10" stroke="#1C274C" stroke-width="1.5"></circle>
                                    <path d="M15 12L12 12M12 12L9 12M12 12L12 9M12 12L12 15" stroke="#1C274C" stroke-width="1.5" stroke-linecap="round"></path>
                                 </g>
                              </svg>
                              <svg class="fill-icon">
                                 <use href="{{ route('licenses') }}/add"></use>
                              </svg>
                              <span>Register License</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('licenses') }}">
                              <svg class="stroke-icon">
                                 <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                    <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                    <g id="SVGRepo_iconCarrier">
                                       <path d="M18 7H18.01M15 7H15.01M18 17H18.01M15 17H15.01M6 10H18C18.9319 10 19.3978 10 19.7654 9.84776C20.2554 9.64477 20.6448 9.25542 20.8478 8.76537C21 8.39782 21 7.93188 21 7C21 6.06812 21 5.60218 20.8478 5.23463C20.6448 4.74458 20.2554 4.35523 19.7654 4.15224C19.3978 4 18.9319 4 18 4H6C5.06812 4 4.60218 4 4.23463 4.15224C3.74458 4.35523 3.35523 4.74458 3.15224 5.23463C3 5.60218 3 6.06812 3 7C3 7.93188 3 8.39782 3.15224 8.76537C3.35523 9.25542 3.74458 9.64477 4.23463 9.84776C4.60218 10 5.06812 10 6 10ZM6 20H18C18.9319 20 19.3978 20 19.7654 19.8478C20.2554 19.6448 20.6448 19.2554 20.8478 18.7654C21 18.3978 21 17.9319 21 17C21 16.0681 21 15.6022 20.8478 15.2346C20.6448 14.7446 20.2554 14.3552 19.7654 14.1522C19.3978 14 18.9319 14 18 14H6C5.06812 14 4.60218 14 4.23463 14.1522C3.74458 14.3552 3.35523 14.7446 3.15224 15.2346C3 15.6022 3 16.0681 3 17C3 17.9319 3 18.3978 3.15224 18.7654C3.35523 19.2554 3.74458 19.6448 4.23463 19.8478C4.60218 20 5.06812 20 6 20Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                                    </g>
                                 </svg>
                              </svg>
                              <svg class="fill-icon">
                                 <use href="{{ route('licenses') }}"></use>
                              </svg>
                              <span>My Licenses</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('stripe.payment-form') }}">
                              <svg class="stroke-icon">
                              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-dollar-sign">
                                 <line x1="12" y1="1" x2="12" y2="23"></line>
                                 <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                              </svg>
                              <svg class="fill-icon">
                                 <use href="{{ route('stripe.payment-form') }}"></use>
                              </svg>
                              <span>Add Balance</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('invoices.index') }}">
                              <svg class="stroke-icon">
                                 <svg viewBox="0 0 1024 1024" class="icon" version="1.1" xmlns="http://www.w3.org/2000/svg" fill="#000000">
                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                    <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                    <g id="SVGRepo_iconCarrier">
                                       <path d="M829.06 73.14h-6.48c-30.41 0-58.57 17.11-75.34 45.75-6.16 10.41-22.29 11.73-29.96 2.43-25.52-31.07-59.41-48.18-95.64-48.18-35.98 0-69.86 17.11-95.41 48.18-6.98 8.48-21.25 8.54-28.27-0.02-25.55-31.05-59.43-48.16-95.41-48.16s-69.86 17.11-95.41 48.18c-7.66 9.38-23.79 8.09-29.95-2.43-16.8-28.64-44.96-45.75-75.36-45.75h-7.23c-46.89 0-85.05 38.16-85.05 85.05V865.8c0 46.89 38.16 85.05 85.05 85.05h7.23c30.39 0 58.55-17.11 75.38-45.79 6.07-10.43 22.23-11.79 29.93-2.38 25.55 31.05 59.43 48.16 95.41 48.16s69.86-17.11 95.41-48.18c7.02-8.52 21.29-8.5 28.27 0.02 25.55 31.05 59.43 48.16 95.66 48.16 35.98 0 69.88-17.11 95.38-48.14 7.73-9.34 23.89-8 29.96 2.36 16.79 28.68 44.95 45.79 75.36 45.79h6.48c46.89 0 85.05-38.16 85.05-85.05V158.2c0-46.9-38.17-85.06-85.06-85.06z m11.91 792.66c0 6.57-5.34 11.91-11.91 11.91h-6.48c-6.14 0-10.91-7.34-12.23-9.61-16.36-27.91-46.61-45.25-78.93-45.25-27.43 0-53.16 12.16-70.64 33.39-6.59 8.02-20.41 21.46-39.14 21.46-18.48 0-32.32-13.46-38.91-21.46-34.84-42.45-106.39-42.46-141.27-0.02-6.59 8.02-20.43 21.48-38.91 21.48s-32.32-13.46-38.91-21.46c-17.43-21.23-43.18-33.39-70.62-33.39-32.36 0-62.61 17.36-78.93 45.25-1.32 2.25-6.11 9.61-12.25 9.61h-7.23c-6.57 0-11.91-5.34-11.91-11.91V158.2c0-6.57 5.34-11.91 11.91-11.91h7.23c6.14 0 10.93 7.36 12.23 9.57 16.34 27.93 46.59 45.29 78.95 45.29 27.45 0 53.2-12.16 70.62-33.38 6.59-8.02 20.43-21.48 38.91-21.48s32.32 13.46 38.91 21.46c34.88 42.48 106.43 42.43 141.27 0.02 6.59-8.02 20.43-21.48 39.16-21.48 18.48 0 32.3 13.45 38.91 21.5 17.46 21.2 43.2 33.36 70.62 33.36 32.32 0 62.57-17.34 78.95-45.29 1.3-2.23 6.07-9.57 12.21-9.57h6.48c6.57 0 11.91 5.34 11.91 11.91v707.6z" fill="#0F1F3C"></path>
                                       <path d="M255.83 365.46h512v73.14h-512zM255.74 548.2h365.71v73.38H255.74z" fill="#0F1F3C"></path>
                                    </g>
                                 </svg>
                              </svg>
                              <span>Invoices</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('redeem.index') }}">
                              <svg class="stroke-icon">
                              <svg viewBox="0 0 32 32" enable-background="new 0 0 32 32" version="1.1" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <g id="Layer_1"></g>
                                    <g id="Layer_2">
                                       <g>
                                          <polyline fill="none" points=" 2,7 2,6 30,6 30,26 2,26 2,17 " stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"></polyline>
                                          <line fill="none" stroke="#000000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" x1="7" x2="7" y1="6" y2="10"></line>
                                          <line fill="none" stroke="#000000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" x1="7" x2="7" y1="14" y2="26"></line>
                                          <circle cx="7" cy="12" fill="none" r="2" stroke="#000000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"></circle>
                                          <polyline fill="none" points="9,13 12,14 12,10 9,11 " stroke="#000000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"></polyline>
                                          <polyline fill="none" points="5,13 2,14 2,10 5,11 " stroke="#000000" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"></polyline>
                                          <line fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" x1="21" x2="21" y1="10" y2="12"></line>
                                          <line fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" x1="21" x2="21" y1="20" y2="22"></line>
                                          <path d=" M19,20h3c1.1,0,2-0.9,2-2s-0.9-2-2-2h-2c-1.1,0-2-0.9-2-2s0.9-2,2-2h3" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"></path>
                                       </g>
                                    </g>
                                 </g>
                              </svg>
                              <span>Redeem</span>
                           </a>
                        </li>
                        @if (Auth::user()->role == 'admin' || Auth::user()->role == 'master')
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('redeem.store') }}">
                              <svg class="stroke-icon">
                              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <path d="M12 7V20M12 7H8.46429C7.94332 7 7.4437 6.78929 7.07533 6.41421C6.70695 6.03914 6.5 5.53043 6.5 5C6.5 4.46957 6.70695 3.96086 7.07533 3.58579C7.4437 3.21071 7.94332 3 8.46429 3C11.2143 3 12 7 12 7ZM12 7H15.5357C16.0567 7 16.5563 6.78929 16.9247 6.41421C17.293 6.03914 17.5 5.53043 17.5 5C17.5 4.46957 17.293 3.96086 16.9247 3.58579C16.5563 3.21071 16.0567 3 15.5357 3C12.7857 3 12 7 12 7ZM5 12H19V17.8C19 18.9201 19 19.4802 18.782 19.908C18.5903 20.2843 18.2843 20.5903 17.908 20.782C17.4802 21 16.9201 21 15.8 21H8.2C7.07989 21 6.51984 21 6.09202 20.782C5.71569 20.5903 5.40973 20.2843 5.21799 19.908C5 19.4802 5 18.9201 5 17.8V12ZM4.6 12H19.4C19.9601 12 20.2401 12 20.454 11.891C20.6422 11.7951 20.7951 11.6422 20.891 11.454C21 11.2401 21 10.9601 21 10.4V8.6C21 8.03995 21 7.75992 20.891 7.54601C20.7951 7.35785 20.6422 7.20487 20.454 7.10899C20.2401 7 19.9601 7 19.4 7H4.6C4.03995 7 3.75992 7 3.54601 7.10899C3.35785 7.20487 3.20487 7.35785 3.10899 7.54601C3 7.75992 3 8.03995 3 8.6V10.4C3 10.9601 3 11.2401 3.10899 11.454C3.20487 11.6422 3.35785 11.7951 3.54601 11.891C3.75992 12 4.03995 12 4.6 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                                 </g>
                              </svg>
                              <span>Generate Code</span>
                           </a>
                        </li>
                        @endif
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('guide') }}">
                              <svg class="stroke-icon">
                              <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill="#000000">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <title></title>
                                    <g id="Complete">
                                       <g id="download">
                                          <g>
                                             <path d="M3,12.3v7a2,2,0,0,0,2,2H19a2,2,0,0,0,2-2v-7" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                                             <g>
                                                <polyline data-name="Right" fill="none" id="Right-2" points="7.9 12.3 12 16.3 16.1 12.3" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></polyline>
                                                <line fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" x1="12" x2="12" y1="2.7" y2="14.2"></line>
                                             </g>
                                          </g>
                                       </g>
                                    </g>
                                 </g>
                              </svg>
                              <span>WHMCS Module</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('notices.index') }}">
                              <svg class="stroke-icon">
                              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <path d="M22 7.99992V11.9999M10.25 5.49991H6.8C5.11984 5.49991 4.27976 5.49991 3.63803 5.82689C3.07354 6.11451 2.6146 6.57345 2.32698 7.13794C2 7.77968 2 8.61976 2 10.2999L2 11.4999C2 12.4318 2 12.8977 2.15224 13.2653C2.35523 13.7553 2.74458 14.1447 3.23463 14.3477C3.60218 14.4999 4.06812 14.4999 5 14.4999V18.7499C5 18.9821 5 19.0982 5.00963 19.1959C5.10316 20.1455 5.85441 20.8968 6.80397 20.9903C6.90175 20.9999 7.01783 20.9999 7.25 20.9999C7.48217 20.9999 7.59826 20.9999 7.69604 20.9903C8.64559 20.8968 9.39685 20.1455 9.49037 19.1959C9.5 19.0982 9.5 18.9821 9.5 18.7499V14.4999H10.25C12.0164 14.4999 14.1772 15.4468 15.8443 16.3556C16.8168 16.8857 17.3031 17.1508 17.6216 17.1118C17.9169 17.0756 18.1402 16.943 18.3133 16.701C18.5 16.4401 18.5 15.9179 18.5 14.8736V5.1262C18.5 4.08191 18.5 3.55976 18.3133 3.2988C18.1402 3.05681 17.9169 2.92421 17.6216 2.88804C17.3031 2.84903 16.8168 3.11411 15.8443 3.64427C14.1772 4.55302 12.0164 5.49991 10.25 5.49991Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                                 </g>
                              </svg>
                              <span>Notice</span>
                           </a>
                        </li>
                        @if (Auth::user()->role == 'admin' || Auth::user()->role == 'master')
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('resellers') }}">
                              <svg class="stroke-icon">
                              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <path d="M3 19H1V18C1 16.1362 2.27477 14.5701 4 14.126M6 10.8293C4.83481 10.4175 4 9.30621 4 7.99999C4 6.69378 4.83481 5.58254 6 5.1707M21 19H23V18C23 16.1362 21.7252 14.5701 20 14.126M18 5.1707C19.1652 5.58254 20 6.69378 20 7.99999C20 9.30621 19.1652 10.4175 18 10.8293M10 14H14C16.2091 14 18 15.7909 18 18V19H6V18C6 15.7909 7.79086 14 10 14ZM15 8C15 9.65685 13.6569 11 12 11C10.3431 11 9 9.65685 9 8C9 6.34315 10.3431 5 12 5C13.6569 5 15 6.34315 15 8Z" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                                 </g>
                              </svg>
                              <span>Manage Resellers</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('resellers') }}/add">
                              <svg class="stroke-icon">
                              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-users">
                                 <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                 <circle cx="9" cy="7" r="4"></circle>
                                 <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                 <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                              </svg>
                              <span>Add Reseller</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('levels') }}">
                              <svg class="stroke-icon">
                              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-award">
                                 <circle cx="12" cy="8" r="7"></circle>
                                 <polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline>
                              </svg>
                              <span>Reseller Levels</span>
                           </a>
                        </li>
                        @endif
                        @if (Auth::user()->role == 'admin')
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('users.index') }}">
                              <svg class="stroke-icon">
                              <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill="#000000">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <defs>
                                       <style>.a,.b{fill:none;stroke:#000000;stroke-linecap:round;stroke-width:1.5px;}.a{stroke-linejoin:round;}.b{stroke-linejoin:bevel;}</style>
                                    </defs>
                                    <path class="a" d="M3,21.016l.78984-2.87249C5.0964,13.3918,8.5482,10.984,12,10.984"></path>
                                    <circle class="b" cx="12" cy="5.98404" r="5"></circle>
                                    <circle class="a" cx="17" cy="18" r="5"></circle>
                                    <circle class="a" cx="17" cy="18" r="0.20745"></circle>
                                    <circle class="a" cx="14.35106" cy="18" r="0.20745"></circle>
                                    <circle class="a" cx="19.47832" cy="18" r="0.20745"></circle>
                                 </g>
                              </svg>
                              <span>All Users</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('license-status') }}">
                              <svg fill="#000000" viewBox="0 0 32 32" id="icon" xmlns="http://www.w3.org/2000/svg">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <defs>
                                       <style> .cls-1 { fill: none; } </style>
                                    </defs>
                                    <rect x="8" y="14" width="6" height="2"></rect>
                                    <rect x="8" y="6" width="12" height="2"></rect>
                                    <rect x="8" y="10" width="12" height="2"></rect>
                                    <rect x="8" y="24" width="6" height="2"></rect>
                                    <path d="M30,24V22H27.8989a4.9678,4.9678,0,0,0-.7319-1.7529l1.49-1.49-1.414-1.414-1.49,1.49A4.9678,4.9678,0,0,0,24,18.1011V16H22v2.1011a4.9678,4.9678,0,0,0-1.7529.7319l-1.49-1.49-1.414,1.414,1.49,1.49A4.9678,4.9678,0,0,0,18.1011,22H16v2h2.1011a4.9678,4.9678,0,0,0,.7319,1.7529l-1.49,1.49,1.414,1.414,1.49-1.49A4.9678,4.9678,0,0,0,22,27.8989V30h2V27.8989a4.9678,4.9678,0,0,0,1.7529-.7319l1.49,1.49,1.414-1.414-1.49-1.49A4.9678,4.9678,0,0,0,27.8989,24Zm-7,2a3,3,0,1,1,3-3A3.0033,3.0033,0,0,1,23,26Z"></path>
                                    <path d="M14,30H6a2.0021,2.0021,0,0,1-2-2V4A2.0021,2.0021,0,0,1,6,2H22a2.0021,2.0021,0,0,1,2,2V14H22V4H6V28h8Z"></path>
                                    <rect id="_Transparent_Rectangle_" data-name="<Transparent Rectangle>" class="cls-1" width="32" height="32"></rect>
                                 </g>
                              </svg>
                              <span>License Status</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('setting.view') }}">
                              <svg version="1.1" id="svg2" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cc="http://creativecommons.org/ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:svg="http://www.w3.org/2000/svg" xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd" xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape" sodipodi:docname="cogs.svg" inkscape:version="0.48.4 r9939" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 1200 1200" enable-background="new 0 0 1200 1200" xml:space="preserve" fill="#000000">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <sodipodi:namedview inkscape:cy="236.02069" inkscape:cx="601.80919" inkscape:zoom="0.37249375" showgrid="false" id="namedview30" guidetolerance="10" gridtolerance="10" objecttolerance="10" borderopacity="1" bordercolor="#666666" pagecolor="#ffffff" inkscape:current-layer="svg2" inkscape:window-maximized="1" inkscape:window-y="24" inkscape:window-height="876" inkscape:window-width="1535" inkscape:pageshadow="2" inkscape:pageopacity="0" inkscape:window-x="65"> </sodipodi:namedview>
                                    <path id="path4627" inkscape:connector-curvature="0" d="M910.143,91.119l-16.916,81.053c-17.338,2.724-34.037,7.74-49.691,14.743 l-58.229-58.825l-66.309,53.661l45.354,69.303c-10.104,13.862-18.357,29.104-24.623,45.503l-82.85-0.374l-8.906,84.87l81.055,16.914 c2.723,17.329,7.746,33.897,14.742,49.545l-58.824,58.376l53.66,66.31l69.303-45.43c13.852,10.098,29.119,18.435,45.504,24.698 l-0.375,82.774l84.871,8.904l16.838-81.053c17.346-2.722,34.035-7.666,49.695-14.669l58.301,58.825l66.309-53.735l-45.428-69.229 c10.104-13.857,18.43-29.108,24.697-45.503l82.773,0.3l8.906-84.87l-81.053-16.765c-2.725-17.354-7.66-34.103-14.67-49.77 l58.824-58.227l-53.734-66.309l-69.229,45.354c-13.869-10.111-29.17-18.428-45.578-24.697l0.373-82.774L910.143,91.119 L910.143,91.119z M924.211,288.25c2.668,0.009,5.373,0.09,8.084,0.374c43.355,4.555,74.756,43.384,70.201,86.741 c-4.555,43.355-43.385,74.83-86.742,70.274c-43.355-4.555-74.83-43.384-70.275-86.739 C849.748,318.253,884.203,288.111,924.211,288.25L924.211,288.25z M315.23,295.21l-11.375,112.711 c-23.205,6.187-45.185,15.324-65.486,27.092l-87.714-71.696l-82.55,82.55l71.698,87.788c-11.768,20.308-20.91,42.272-27.092,65.484 L0,610.44v116.751l112.71,11.376c6.182,23.191,15.334,45.118,27.092,65.41l-71.698,87.789l82.55,82.55l87.789-71.697 c20.292,11.758,42.219,20.91,65.411,27.093l11.375,112.71h116.752l11.301-112.71c23.212-6.183,45.178-15.325,65.484-27.093 l87.788,71.697l82.55-82.55l-71.697-87.714c11.768-20.302,20.906-42.281,27.092-65.485l112.711-11.376V610.44L634.5,599.138 c-6.186-23.225-15.314-45.243-27.092-65.561l71.697-87.714l-82.55-82.549l-87.713,71.696 c-20.316-11.775-42.336-20.905-65.562-27.093l-11.301-112.71H315.23V295.21z M373.606,560.82 c59.649,0,107.996,48.348,107.996,107.996c0,59.647-48.347,107.994-107.996,107.994c-59.648,0-107.996-48.347-107.996-107.994 C265.61,609.168,313.958,560.82,373.606,560.82L373.606,560.82z M869.279,705.039l-11.9,59.273 c-12.188,1.993-23.873,5.653-34.877,10.776l-41.012-43.033l-46.553,39.292l31.883,50.667c-7.102,10.143-12.959,21.308-17.363,33.306 l-58.15-0.301l-6.287,62.118l56.955,12.35c1.912,12.678,5.41,24.851,10.328,36.298l-41.312,42.659l37.721,48.497l48.721-33.229 c9.736,7.386,20.441,13.454,31.957,18.037l-0.225,60.621l59.648,6.511l11.824-59.349c12.189-1.991,23.869-5.579,34.875-10.702 l41.014,43.033l46.625-39.291l-31.957-50.668c7.104-10.139,12.959-21.312,17.363-33.306l58.229,0.226l6.211-62.043l-56.953-12.35 c-1.914-12.695-5.402-24.911-10.328-36.372l41.311-42.585l-37.719-48.572l-48.646,33.229c-9.746-7.396-20.498-13.449-32.031-18.036 l0.299-60.546L869.279,705.039L869.279,705.039z M879.158,849.183c1.873,0.009,3.783,0.092,5.688,0.301 c30.473,3.331,52.521,31.745,49.32,63.465c-3.201,31.719-30.449,54.748-60.922,51.416s-52.596-31.746-49.395-63.466 C826.85,871.161,851.039,849.081,879.158,849.183L879.158,849.183z"></path>
                                 </g>
                              </svg>
                              <span>Panel Settings</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('softwares') }}">
                              <svg fill="#000000" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <path d="M0 0h4v4H0V0zm0 6h4v4H0V6zm0 6h4v4H0v-4zM6 0h4v4H6V0zm0 6h4v4H6V6zm0 6h4v4H6v-4zm6-12h4v4h-4V0zm0 6h4v4h-4V6zm0 6h4v4h-4v-4z" fill-rule="evenodd"></path>
                                 </g>
                              </svg>
                              <span>All Products</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('message.index') }}">
                              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <path d="M7 9H17M7 13H17M21 20L17.6757 18.3378C17.4237 18.2118 17.2977 18.1488 17.1656 18.1044C17.0484 18.065 16.9277 18.0365 16.8052 18.0193C16.6672 18 16.5263 18 16.2446 18H6.2C5.07989 18 4.51984 18 4.09202 17.782C3.71569 17.5903 3.40973 17.2843 3.21799 16.908C3 16.4802 3 15.9201 3 14.8V7.2C3 6.07989 3 5.51984 3.21799 5.09202C3.40973 4.71569 3.71569 4.40973 4.09202 4.21799C4.51984 4 5.0799 4 6.2 4H17.8C18.9201 4 19.4802 4 19.908 4.21799C20.2843 4.40973 20.5903 4.71569 20.782 5.09202C21 5.51984 21 6.0799 21 7.2V20Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                                 </g>
                              </svg>
                              <span>API Message</span>
                           </a>
                        </li>
                        @endif
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('branding') }}">
                              <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <path d="M10.5 6H9.5C9.22386 6 9 6.22386 9 6.5V7.5C9 7.77614 9.22386 8 9.5 8H10.5C10.7761 8 11 7.77614 11 7.5V6.5C11 6.22386 10.7761 6 10.5 6Z" fill="#000000"></path>
                                    <path d="M14.5 6H13.5C13.2239 6 13 6.22386 13 6.5V7.5C13 7.77614 13.2239 8 13.5 8H14.5C14.7761 8 15 7.77614 15 7.5V6.5C15 6.22386 14.7761 6 14.5 6Z" fill="#000000"></path>
                                    <path d="M10.5 9.5H9.5C9.22386 9.5 9 9.72386 9 10V11C9 11.2761 9.22386 11.5 9.5 11.5H10.5C10.7761 11.5 11 11.2761 11 11V10C11 9.72386 10.7761 9.5 10.5 9.5Z" fill="#000000"></path>
                                    <path d="M14.5 9.5H13.5C13.2239 9.5 13 9.72386 13 10V11C13 11.2761 13.2239 11.5 13.5 11.5H14.5C14.7761 11.5 15 11.2761 15 11V10C15 9.72386 14.7761 9.5 14.5 9.5Z" fill="#000000"></path>
                                    <path d="M10.5 13H9.5C9.22386 13 9 13.2239 9 13.5V14.5C9 14.7761 9.22386 15 9.5 15H10.5C10.7761 15 11 14.7761 11 14.5V13.5C11 13.2239 10.7761 13 10.5 13Z" fill="#000000"></path>
                                    <path d="M14.5 13H13.5C13.2239 13 13 13.2239 13 13.5V14.5C13 14.7761 13.2239 15 13.5 15H14.5C14.7761 15 15 14.7761 15 14.5V13.5C15 13.2239 14.7761 13 14.5 13Z" fill="#000000"></path>
                                    <path d="M18.25 19.25H17.75V4C17.7474 3.80189 17.6676 3.61263 17.5275 3.47253C17.3874 3.33244 17.1981 3.25259 17 3.25H7C6.80189 3.25259 6.61263 3.33244 6.47253 3.47253C6.33244 3.61263 6.25259 3.80189 6.25 4V19.25H5.75C5.55109 19.25 5.36032 19.329 5.21967 19.4697C5.07902 19.6103 5 19.8011 5 20C5 20.1989 5.07902 20.3897 5.21967 20.5303C5.36032 20.671 5.55109 20.75 5.75 20.75H18.25C18.4489 20.75 18.6397 20.671 18.7803 20.5303C18.921 20.3897 19 20.1989 19 20C19 19.8011 18.921 19.6103 18.7803 19.4697C18.6397 19.329 18.4489 19.25 18.25 19.25ZM16.25 19.25H11V17C11 16.8674 10.9473 16.7402 10.8536 16.6464C10.7598 16.5527 10.6326 16.5 10.5 16.5H9.5C9.36739 16.5 9.24021 16.5527 9.14645 16.6464C9.05268 16.7402 9 16.8674 9 17V19.25H7.75V4.75H16.25V19.25Z" fill="#000000"></path>
                                 </g>
                              </svg>
                              <span>Branding</span>
                           </a>
                        </li>
                        <li class="sidebar-list">
                           <i class="fa fa-thumb-tack"></i>
                           <a class="sidebar-link sidebar-title link-nav" href="{{ route('profile') }}">
                              <svg viewBox="0 0 192 192" xmlns="http://www.w3.org/2000/svg" fill="#000000">
                                 <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                 <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                 <g id="SVGRepo_iconCarrier">
                                    <path d="M0 0h192v192H0z" style="fill:none"></path>
                                    <circle cx="96" cy="96" r="67" style="stroke:#000000;stroke-width:12px;stroke-miterlimit:10;fill:none"></circle>
                                    <path d="M106.84 103.05C112.93 99.37 117 92.69 117 85.06c0-11.6-9.4-21-21-21s-21 9.4-21 21c0 7.63 4.07 14.31 10.16 17.99L75 127.93h42l-10.16-24.88Z" style="stroke-linejoin:round;stroke:#000000;stroke-width:12px;fill:none"></path>
                                    <path d="m22 22 26 26m96 96 26 26m-148 0 26-26m96-96 26-26" style="fill:none;stroke-linecap:round;stroke-miterlimit:10;stroke:#000000;stroke-width:12px"></path>
                                 </g>
                              </svg>
                              <span>Change Password</span>
                           </a>
                        </li>
                     </ul>
                  </div>
                  <div class="right-arrow" id="right-arrow"><i data-feather="arrow-right"></i></div>
               </nav>
            </div>
         </div>
         <!-- Page Sidebar Ends-->
         <div class="page-body">
            <div class="container-fluid">
               <div class="page-title">
                  <div class="row">
                     <div class="col-6">
                        @yield('breadcrumb-title')
                     </div>
                     <div class="col-6">
                        <ol class="breadcrumb">
                           <li class="breadcrumb-item">
                              <a href="{{ route('home')}}">
                                 <svg class="stroke-icon">
                                    <use href="{{ asset('assets/svg/icon-sprite.svg#stroke-home') }}"></use>
                                 </svg>
                              </a>
                           </li>
                           </li>
                           @yield('breadcrumb-items')
                        </ol>
                     </div>
                  </div>
               </div>
            </div>
            <!-- Container-fluid starts-->
            @yield('content')
            <!-- Container-fluid Ends-->
         </div>
         <!-- footer start-->
         <!-- footer start-->
         <footer class="footer">
            <div class="container-fluid">
               <div class="row">
                  <div class="col-md-12 footer-copyright text-center">
                     <p class="mb-0">Copyright 2016-2025 © CPS </p>
                  </div>
               </div>
            </div>
         </footer>
      </div>
   </div>
   <!-- latest jquery-->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
   <!-- Bootstrap js-->
   <script src="{{asset('assets/js/bootstrap/bootstrap.bundle.min.js')}}"></script>
   <!-- feather icon js-->
   <script src="{{asset('assets/js/icons/feather-icon/feather.min.js')}}"></script>
   <script src="{{asset('assets/js/icons/feather-icon/feather-icon.js')}}"></script>
   <!-- scrollbar js-->
   <script src="{{asset('assets/js/scrollbar/simplebar.js')}}"></script>
   <script src="{{asset('assets/js/scrollbar/custom.js')}}"></script>
   <!-- Sidebar jquery-->
   <script src="{{asset('assets/js/config.js')}}"></script>
   <!-- Plugins JS start-->
   <script src="{{ asset('assets/js/chart/apex-chart/apex-chart.js') }}"></script>
   <script src="{{ asset('assets/js/chart/apex-chart/stock-prices.js') }}"></script>
   <script id="menu" src="{{asset('assets/js/sidebar-menu.js?5d6de8d')}}"></script>
   <script src="{{ asset('assets/js/slick/slick.min.js') }}"></script>
   <script src="{{ asset('assets/js/slick/slick.js') }}"></script>
   <script src="{{ asset('assets/js/header-slick.js') }}"></script>
   @yield('script') @if(Route::current()->getName() != 'popover')
   <script src="{{asset('assets/js/tooltip-init.js')}}"></script>
   @endif
   <!-- Plugins JS Ends-->
   <!-- Theme js-->
   <script src="{{asset('assets/js/script.js')}}"></script>
   <!-- ChartJS -->
   <script src="{{ asset('plugins/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
   <!-- Select2 -->
   <!-- ChartJS -->
   <script src="{{ asset('plugins/chart.js/Chart.min.js') }}"></script>
   <!-- Sparkline -->
   <script src="{{ asset('plugins/sparklines/sparkline.js') }}"></script>
   <!-- JQVMap -->
   <script src="{{ asset('plugins/jqvmap/jquery.vmap.min.js') }}"></script>
   <script src="{{ asset('plugins/jqvmap/maps/jquery.vmap.usa.js') }}"></script>
   <!-- jQuery Knob Chart -->
   <script src="{{ asset('plugins/jquery-knob/jquery.knob.min.js') }}"></script>
   <!-- daterangepicker -->
   <script src="{{ asset('plugins/moment/moment.min.js') }}"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
   <!-- Tempusdominus Bootstrap 4 -->
   <script src="{{ asset('plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js') }}"></script>
   <!-- Summernote -->
   <script src="{{ asset('plugins/summernote/summernote-bs4.min.js') }}"></script>
   <!-- overlayScrollbars -->
   <script src="{{ asset('plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js') }}"></script>
   <!-- Editor -->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/5.2.0/tinymce.min.js"></script>
   <!-- AdminLTE App -->
   <script src="{{ asset('dist/js/adminlte.js') }}"></script>
   <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
   <script src="{{ asset('plugins/datatables/jquery.dataTables.js') }}"></script>
   <script src="{{ asset('plugins/datatables-bs4/js/dataTables.bootstrap4.js') }}"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap-input-spinner@1.13.3/src/bootstrap-input-spinner.min.js"></script>
   <script src="{{ asset('js/dataTables.checkboxes.min.js') }}"></script>
   <script src="{{ asset('js/dataTables.buttons.min.js') }}"></script>
   <script src="{{ asset('js/select2.full.min.js') }}"></script>
   @stack('script')
   <!-- AdminLTE for demo purposes -->
   <script src="{{ asset('dist/js/demo.js') }}"></script>
   <script src="https://js.stripe.com/v3/"></script>
   @yield('endfooter')
   {{-- @if(Route::current()->getName() == 'home')
   <script src="{{asset('assets/js/layout-change.js')}}"></script>
   @endif --}} @if(Route::currentRouteName() == 'home')
   <script>
      new WOW().init();
   </script>
   @endif
   <!-- Plugin used-->
   </body>
</html>