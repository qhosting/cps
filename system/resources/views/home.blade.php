@extends('layouts.layout')
@section('content')
<div class="container-fluid">
<div class="row widget-grid">
<div class="col-xxl-4 col-sm-6 box-col-6">
   <div class="card profile-box">
      <div class="card-body">
         <div class="media">
            <div class="media-body">
               <div class="greeting-user">
                  <h4 class="f-w-600">Welcome to CPS Panel</h4>
                  <p>Here whats happing in your account today</p>
                  <div class="whatsnew-btn"><a class="btn btn-outline-white">Change reseller info</a></div>
               </div>
            </div>
            <div>
               <div class="clockbox">
                  <svg id="clock" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 600">
                     <g id="face">
                        <circle class="circle" cx="300" cy="300" r="253.9"></circle>
                        <path class="hour-marks" d="M300.5 94V61M506 300.5h32M300.5 506v33M94 300.5H60M411.3 107.8l7.9-13.8M493 190.2l13-7.4M492.1 411.4l16.5 9.5M411 492.3l8.9 15.3M189 492.3l-9.2 15.9M107.7 411L93 419.5M107.5 189.3l-17.1-9.9M188.1 108.2l-9-15.6"></path>
                        <circle class="mid-circle" cx="300" cy="300" r="16.2"></circle>
                     </g>
                     <g id="hour">
                        <path class="hour-hand" d="M300.5 298V142"></path>
                        <circle class="sizing-box" cx="300" cy="300" r="253.9"></circle>
                     </g>
                     <g id="minute">
                        <path class="minute-hand" d="M300.5 298V67"></path>
                        <circle class="sizing-box" cx="300" cy="300" r="253.9"></circle>
                     </g>
                     <g id="second">
                        <path class="second-hand" d="M300.5 350V55"></path>
                        <circle class="sizing-box" cx="300" cy="300" r="253.9">   </circle>
                     </g>
                  </svg>
               </div>
               <div class="badge f-10 p-0" id="txt"></div>
            </div>
         </div>
         <div class="cartoon"><img class="img-fluid" src="{{ asset('assets/images/dashboard/cartoon.svg') }}" alt="vector women with leptop"></div>
      </div>
   </div>
</div>
<div class="col-xxl-auto col-xl-3 col-sm-6 box-col-6">
   <div class="row">
      <div class="col-xl-12">
         <div class="card widget-1">
            <div class="card-body">
               <div class="widget-content">
                  <div class="widget-round success">
                     <div class="bg-round">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-dollar-sign">
                           <line x1="12" y1="1" x2="12" y2="23"></line>
                           <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                        </svg>
                     </div>
                  </div>
                  <div>
                     <h4>${{ \App\Reseller::sum('balance') }}</h4>
                     <span class="f-light">Balance</span>
                  </div>
               </div>
            </div>
         </div>
         <div class="col-xl-12">
            <div class="card widget-1">
               <div class="card-body">
                  <div class="widget-content">
                     <div class="widget-round success">
                        <div class="bg-round">
                           <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-users">
                              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                              <circle cx="9" cy="7" r="4"></circle>
                              <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                              <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                           </svg>
                        </div>
                     </div>
                     <div>
                        <h4> <?php $reseller = App\Models\Reseller::firstWhere('user_id', Auth::id()); $domain = strtolower($reseller->domain); echo $domain; ?>
                        </h4>
                        <span class="f-light">Your Business</span>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<div class="col-xxl-auto col-xl-3 col-sm-6 box-col-6">
   <div class="row">
      <div class="col-xl-12">
         <div class="card widget-1">
            <div class="card-body">
               <div class="widget-content">
                  <div class="widget-round success">
                     <div class="bg-round">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-shopping-bag">
                           <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                           <line x1="3" y1="6" x2="21" y2="6"></line>
                           <path d="M16 10a4 4 0 0 1-8 0"></path>
                        </svg>
                     </div>
                  </div>
                  <div>
                     <h4>
                        @php
                        $reseller_id = App\Models\Reseller::firstWhere('user_id', Auth::id())->id;
                        @endphp
                        {{ \App\License::where('reseller_id', $reseller_id)->where('status', '1')->where('end_at', '>=', now())->count() }}
                     </h4>
                     <span class="f-light">Your licenses</span>
                  </div>
               </div>
            </div>
         </div>
         <div class="col-xl-12">
            <div class="card widget-1">
               <div class="card-body">
                  <div class="widget-content">
                     <div class="widget-round success">
                        <div class="bg-round">
                           <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-award">
                              <circle cx="12" cy="8" r="7"></circle>
                              <polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline>
                           </svg>
                        </div>
                     </div>
                     <div>
                        <h4><?php 
                           // Get the current authenticated user
                           $user = Auth::user();
                           
                           // Retrieve the Reseller associated with the authenticated user
                           $reseller = \App\Reseller::where('user_id', $user->id)->first();
                           
                           // Default plan if no level is assigned
                           $plan = 'default';
                           
                           // Check if the Reseller has a valid level_id
                           if ($reseller && $reseller->level_id) {
                               // Retrieve the associated LevelReseller
                               $level = \App\LevelReseller::find($reseller->level_id);
                           
                               // If a LevelReseller is found, use its title as the plan
                               if ($level) {
                                   $plan = $level->title;
                               }
                           }
                           
                           // Print the plan (level) of the current user
                           echo ucfirst($plan); // Capitalize the first letter of the plan
                           
                           ?></h4>
                        <span class="f-light">Your level</span>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<div class="col-xxl-auto col-xl-12 col-sm-6 box-col-6">
   <div class="row">
      <div class="col-xxl-12 col-xl-6 box-col-12">
         <div class="card widget-1 widget-with-chart">
            <div class="card-body">
               <div class="widget-content">
                  <div class="widget-round success">
                     <div class="bg-round">
                        <svg viewBox="0 0 14 14" xmlns="http://www.w3.org/2000/svg" fill="#000000">
                           <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                           <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                           <g id="SVGRepo_iconCarrier">
                              <g fill-rule="evenodd">
                                 <path d="M0 7a7 7 0 1 1 14 0A7 7 0 0 1 0 7z"></path>
                                 <path d="M13 7A6 6 0 1 0 1 7a6 6 0 0 0 12 0z" fill="#FFF" style="fill: var(--svg-status-bg, #fff);"></path>
                                 <path d="M6.278 7.697L5.045 6.464a.296.296 0 0 0-.42-.002l-.613.614a.298.298 0 0 0 .002.42l1.91 1.909a.5.5 0 0 0 .703.005l.265-.265L9.997 6.04a.291.291 0 0 0-.009-.408l-.614-.614a.29.29 0 0 0-.408-.009L6.278 7.697z"></path>
                              </g>
                           </g>
                        </svg>
                     </div>
                  </div>
                  <div>
                     <h4 style="color:green">{{ \App\Http\Controllers\ApiController::getStatusFromLD() }} </h4>
                     <span class="f-light">reseller account status</span>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div class="col-xxl-12 col-xl-6 box-col-12">
         <div class="card widget-1 widget-with-chart">
            <div class="card-body">
               <div class="widget-content">
                  <div class="widget-round success">
                     <div class="bg-round">
                        <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                           <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                           <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                           <g id="SVGRepo_iconCarrier">
                              <path d="M3 19H1V18C1 16.1362 2.27477 14.5701 4 14.126M6 10.8293C4.83481 10.4175 4 9.30621 4 7.99999C4 6.69378 4.83481 5.58254 6 5.1707M21 19H23V18C23 16.1362 21.7252 14.5701 20 14.126M18 5.1707C19.1652 5.58254 20 6.69378 20 7.99999C20 9.30621 19.1652 10.4175 18 10.8293M10 14H14C16.2091 14 18 15.7909 18 18V19H6V18C6 15.7909 7.79086 14 10 14ZM15 8C15 9.65685 13.6569 11 12 11C10.3431 11 9 9.65685 9 8C9 6.34315 10.3431 5 12 5C13.6569 5 15 6.34315 15 8Z" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                           </g>
                        </svg>
                     </div>
                  </div>
                  <div>
                     <h4 style="color:green">{{ \App\Http\Controllers\ApiController::getStatusFromLD() }} </h4>
                     <span class="f-light">Sub reseller status</span>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<div class="col-lg-6">
   <div class="card">
      <div class="card-header cartts">
         <h3 class="card-title">License Purchase Graph @php echo date("Y") @endphp</h3>
      </div>
      @if (Auth::user()->role == 'admin')
      @php
      $licenseData = DB::table('licenses')
      ->select(DB::raw('COUNT(*) as total'), DB::raw("DATE_FORMAT(created_at, '%b') as month"))
      ->whereYear('created_at', date('Y'))
      ->groupBy('month')
      ->get();
      $groupedLicenseData = [];
      $months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      // Initialize each month count to 0
      foreach ($months as $month) {
      $groupedLicenseData[$month] = 0;
      }
      // Add the license counts to the corresponding months
      foreach ($licenseData as $data) {
      $groupedLicenseData[$data->month] = $data->total;
      }
      @endphp
      @else
      @php
      $reseller_id = App\Models\Reseller::firstWhere('user_id', Auth::id())->id;
      $licenseData = DB::table('licenses')
      ->select(DB::raw('COUNT(*) as total'), DB::raw("DATE_FORMAT(created_at, '%b') as month"))
      ->where('reseller_id', $reseller_id)
      ->whereYear('created_at', date('Y'))
      ->groupBy('month')
      ->get();
      $groupedLicenseData = [];
      $months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      // Initialize each month count to 0
      foreach ($months as $month) {
      $groupedLicenseData[$month] = 0;
      }
      // Add the license counts to the corresponding months
      foreach ($licenseData as $data) {
      $groupedLicenseData[$data->month] = $data->total;
      }
      @endphp
      @endif
      <div class="card-body">
         <canvas id="license-chart"
            style="min-height: 250px; height: 352px; max-height: 300px; max-width: 100%; display: block; width: 704px;"
            width="704" height="352" class="chartjs-render-monitor"></canvas>
      </div>
   </div>
</div>
<div class="col-lg-6">
   <div class="card papernote-wrap">
      <div class="card-header card-no-border">
         <div class="header-top">
            <h5>License Stats</h5>
            <a class="f-light d-flex align-items-center" href="https://whmseller.net/?">Go to CPS <i class="f-w-700 icon-arrow-top-right"></i></a>
         </div>
      </div>
      <div class="card-body pt-0">
         <div class="card-body pt-0">
            <ul class="user-list">
               <li>
                  <div class="user-icon success">
                     <div class="user-box"><i class="font-success" data-feather="user-plus"></i></div>
                  </div>
                  <div>
                     <h5 class="mb-1">{{ \App\License::where('reseller_id', $reseller_id)->where('end_at', '<=', now()->addDays(7))->where('end_at', '>', now())->count() }}</h5>
                     <span class="font-primary d-flex align-items-center"><i class="icon-arrow-up icon-rotate me-1"> </i><span class="f-w-500">Expiring</span></span>
                  </div>
               </li>
               <li>
                  <div class="user-icon danger">
                     <div class="user-box"><i class="font-danger" data-feather="user-minus"></i></div>
                  </div>
                  <div>
                     <h5 class="mb-1">{{ \App\License::where('reseller_id', $reseller_id)->where('end_at', '<', now())->count() }}</h5>
                     <span class="font-danger d-flex align-items-center"><i class="icon-arrow-down icon-rotate me-1"></i><span class="f-w-500">Expired</span></span>
                  </div>
               </li>
            </ul>
         </div>
<div class="note-content mt-sm-4 mt-2">
   <p>Unlock unlimited earning potential by becoming a reseller of our extensive range of software solutions. From Control Panels to Security tools, we've got everything you need to start and scale your business. Resell these in-demand solutions to your clients and watch your revenue grow! With over 35 solutions available and growing, you’ll always have new offerings to stay competitive in the market. As a reseller, you can set your pricing and build your brand using these trusted tools.</p>
   <div class="note-labels">
      <ul>
         <li> <span class="badge badge-light-primary">Your Access Token:</span></li>
         <li> <span class="badge badge-light-success">@php $reseller_id = App\Models\Reseller::where('user_id', Auth::id()); $token = $reseller_id->value('token'); echo $token; @endphp</span></li>
      </ul>
      <div class="last-label"> <span class="badge badge-light-secondary">Keep it secure</span></div>
   </div>
   <div class="mt-sm mt-4 user-details">
      <div class="customers">
         <ul>
            <li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/cpanel-whm.png') }}" alt="cPanel VPS"></li>
            <li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/Imunify360.png') }}" alt="Imunify360"></li>
            <li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/LiteSpeed-.png') }}" alt="LiteSpeed"></li>
            <li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/CloudLinux-.png') }}" alt="CloudLinux"></li>
<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/JetBackup-.png') }}" alt="JetBackup"></li>
<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/WHMReseller-.png') }}" alt="WHMReseller"></li>
<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/DAReseller-.png') }}" alt="DAReseller"></li>
<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/WHMSonic-.png') }}" alt="WHMSonic"></li>
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/OSM.png') }}" alt="OSM - Outgoing Spam Monitor"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/Softaculous.png') }}" alt="Softaculous"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/Virtualizor.png') }}" alt="Virtualizor"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/sitepad.png') }}" alt="SitePad"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/SYSCare-.png') }}" alt="SYSCare"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/Webuzo.png') }}" alt="Webuzo V3 Business"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/kernelcare.png') }}" alt="kernelcare"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/fleetssl.png') }}" alt="FleetSSL"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/plesk.png') }}" alt="Plesk"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/virtualizor-pro.png') }}" alt="Virtualizor Pro"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/plesk-dedicated.png') }}" alt="Plesk Dedicated"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/WHMCS.png') }}" alt="WHMCS + Auto Updator"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/Linux-Malware-Detect-lmd.png') }}" alt="Linux Malware Detect Manager (LMD)"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/DDoS-Mitigator-cPanel.png') }}" alt="(D)DoS Mitigator (cPanel)"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/cpShield.png') }}" alt="cPSheild v5"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/cpremote.png') }}" alt="cPRemote"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/cpnginx-.png') }}" alt="cPNginx"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/WatchMySQL-icon.png') }}" alt="WatchMySQL"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/WHMXtra.png') }}" alt="WHMXtra"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/CleanBackups.png') }}" alt="CleanBackups - cPanel / WHM plugin"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/Redis-cPanel-Plugin.png') }}" alt="Redis Plugin for cPanel"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/Account-DNS-Check.png') }}" alt="Account DNS Check - cPanel"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/lets-encrypt-logo.png') }}" alt="LetsEncrypt SSL"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/rkh_logo_50_cpanel-1.png') }}" alt="RKHunter Interface"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/APF-Firewall-LicenseDash-Plesk.png') }}" alt="APF Firewall Interface"></li>-->
<!--<li class="d-inline-block"><img class="img-40 rounded-circle" src="{{ asset('dist/img/softwares/ServerWatch-LicenseDash-Plesk.png') }}" alt="ServerWatch"></li>-->
            <li class="d-inline-block">
               <div class="light-card"><span class="f-w-500">35+</span></div>
            </li>
         </ul>
      </div>
   </div>
</div>
      </div>
   </div>
</div>
<section class="col-lg-6">
   <div class="card card-primary">
      <div class="card-header">
         <h3 class="card-title">Active Licenses by Softwares</h3>
         <div class="card-tools">
         </div>
      </div>
      @if (Auth::user()->role == 'admin')
      @php
      $licenseData = DB::table('licenses')
      ->select(
      DB::raw('CASE
      WHEN software_id = 1 THEN "cPanel VPS"
      WHEN software_id = 2 THEN "Softaculous"
      WHEN software_id = 3 THEN "Plesk VPS"
      WHEN software_id = 4 THEN "CloudLinux"
      WHEN software_id = 6 THEN "Imunify 360"
      WHEN software_id = 13 THEN "cPanel DEDICATED"
      WHEN software_id = 17 THEN "Virtualizor Premium"
      WHEN software_id = 18 THEN "Sitepad"
      WHEN software_id = 19 THEN "Jetbackup"
      WHEN software_id = 20 THEN "WhmReseller"
      WHEN software_id = 23 THEN "LiteSpeed 2c"
      WHEN software_id = 46 THEN "LiteSpeed xc"
      WHEN software_id = 53 THEN "Webuzo"
      WHEN software_id = 56 THEN "LiteSpeed 8c"
      WHEN software_id = 58 THEN "Virtualizor Professional"
      WHEN software_id = 59 THEN "Plesk DEDICATED"
      WHEN software_id = 60 THEN "KernelCare"
      WHEN software_id = 61 THEN "cPnginx"
      WHEN software_id = 62 THEN "JetbackupMC"
      WHEN software_id = 70 THEN "OSM"
      WHEN software_id = 72 THEN "CXS"
      WHEN software_id = 74 THEN "Dareseller"
      WHEN software_id = 75 THEN "LiteSpeed 1c"
      WHEN software_id = 76 THEN "Directadmin"
      WHEN software_id = 102 THEN "AaPanel"
      WHEN software_id = 103 THEN "MediaCP" 
      ELSE "Others"
      END AS category'),
      DB::raw('COUNT(*) as total'),
      )
      ->where('end_at', '>', now()) // Add this line to filter licenses by end_at timestamp
      ->groupBy('category')
      ->get();
      // Initialize the counts for each category
      $categoryCounts = ['cPanel VPS' => 0, 'Softaculous' => 0, 'Plesk VPS' => 0, 'CloudLinux' => 0, 'Imunify 360' => 0, 'cPanel DEDICATED' => 0, 'Virtualizor Premium' => 0, 'Sitepad' => 0, 'Jetbackup' => 0, 'WhmReseller' => 0, 'LiteSpeed 2c' => 0, 'LiteSpeed xc' => 0, 'Webuzo' => 0, 'LiteSpeed 8c' => 0, 'Virtualizor Professional' => 0, 'Plesk DEDICATED' => 0,'Webuzo' => 0, 'KernelCare' => 0, 'cPnginx' => 0, 'JetbackupMC' => 0, 'OSM' => 0, 'CXS' => 0, 'Dareseller' => 0, 'LiteSpeed 1c' => 0,'Directadmin' => 0,'AaPanel' => 0,'MediaCP' => 0,'Others' => 0];                     
      // Calculate the sum for each category
      foreach ($licenseData as $data) {
      if (in_array($data->category, array_keys($categoryCounts))) {
      $categoryCounts[$data->category] += $data->total;
      } else {
      $categoryCounts['Others'] += $data->total;
      }
      }
      // Remove any categories that have a count of 0
      $categoryCounts = array_filter($categoryCounts);
      // Check if $categoryCounts is empty
      if (empty($categoryCounts)) {
      // Set default values for the chart
      $values = [1];
      $titles = ['No data available'];
      } else {
      // Prepare data for the chart
      $values = array_values($categoryCounts);
      $titles = array_keys($categoryCounts);
      }
      // Encode data as JSON
      $valuesJSON = json_encode($values);
      $titlesJSON = json_encode($titles);
      @endphp
      @else
      @php
      $reseller_id = App\Models\Reseller::firstWhere('user_id', Auth::id())->id;
      $licenseData = DB::table('licenses')
      ->select(
      DB::raw('CASE
      WHEN software_id = 1 THEN "cPanel"
      WHEN software_id = 23 THEN "LiteSpeed"
      WHEN software_id = 4 THEN "CloudLinux"
      ELSE "Others"
      END AS category'),
      DB::raw('COUNT(*) as total'),
      )
      ->where('reseller_id', $reseller_id)
      ->where('end_at', '>', now()) // Add this line to filter licenses by end_at timestamp
      ->groupBy('category')
      ->get();
      // Initialize the counts for each category
      $categoryCounts = ['cPanel' => 0, 'LiteSpeed' => 0, 'CloudLinux' => 0, 'Others' => 0];
      // Calculate the sum for each category
      foreach ($licenseData as $data) {
      if (in_array($data->category, array_keys($categoryCounts))) {
      $categoryCounts[$data->category] += $data->total;
      } else {
      $categoryCounts['Others'] += $data->total;
      }
      }
      // Remove any categories that have a count of 0
      $categoryCounts = array_filter($categoryCounts);
      // Check if $categoryCounts is empty
      if (empty($categoryCounts)) {
      // Set default values for the chart
      $values = [1];
      $titles = ['No data available'];
      } else {
      // Prepare data for the chart
      $values = array_values($categoryCounts);
      $titles = array_keys($categoryCounts);
      }
      // Encode data as JSON
      $valuesJSON = json_encode($values);
      $titlesJSON = json_encode($titles);
      @endphp
      @endif
      <div class="card-body">
         <div class="chartjs-size-monitor">
            <div class="chartjs-size-monitor-expand">
               <div class=""></div>
            </div>
            <div class="chartjs-size-monitor-shrink">
               <div class=""></div>
            </div>
         </div>
         <canvas id="pieChart"
            style="min-height: 250px; height: 382px; max-height: 300px; max-width: 100%; display: block; width: 764px;"
            width="764" height="382" class="chartjs-render-monitor"></canvas>
      </div>
   </div>
</section>

<div class="col-lg-6">
   <div class="card">
      <div class="card-header cartts">
         <h3 class="card-title">Notices</h3>
      </div>
      <div class="card-body">
         @foreach($notices->take(2) as $notice)
         <div class="notice">
            <h3>{{ $notice->title }}</h3>
            <p>{{ $notice->content }}</p>
            <p>Posted on: {{ $notice->created_at->format('F d, Y H:i A') }}</p>
         </div>
         @endforeach
      </div>
      @if ($notices->count() > 2)
      <a href="{{ route('notices.index') }}">View all</a>
      @endif
   </div>
</div>
<!-- Content Wrapper. Contains page content -->
<!-- Content Header (Page header) -->
                        @if (Auth::user()->role == 'admin' || Auth::user()->role == 'master')
         <div class="row">
            <!-- left column -->
            <section class="col">
               <div class="card">
                  <div class="card-header cartts">
                     <h3 class="card-title">Notice from CPS</h3>
                  </div>
                    <div class="card-body">
                        {!! \App\Http\Controllers\ApiController::getMessageFromLD() !!}
                    </div>
            </section>
         </div>@endif
   </div>
   <!-- /.row (main row) -->
</div>
<!-- /.container-fluid -->
</section>
<!-- /.content -->
@endsection
@section('endfooter')
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<script>
   var licenseData = <?php echo json_encode(array_values($groupedLicenseData)); ?>;
   var months = <?php echo json_encode(array_keys($groupedLicenseData)); ?>;
   
   var ctx = document.getElementById('license-chart').getContext('2d');
   var chart = new Chart(ctx, {
       type: 'bar',
       data: {
           labels: months,
           datasets: [{
               label: 'Purchase',
               data: licenseData,
               backgroundColor: 'rgb(112 178 0)',
               borderColor: 'rgba(60,141,188,0.8)',
               pointRadius: false,
               pointColor: '#3b8bba',
               pointStrokeColor: 'rgba(60,141,188,1)',
               pointHighlightFill: '#fff',
               pointHighlightStroke: 'rgba(60,141,188,1)',
           }]
       },
       options: {
           scales: {
               yAxes: [{
                   ticks: {
                       beginAtZero: true
                   }
               }]
           },
           layout: {
               padding: {
                   top: 10,
                   bottom: 10
               }
           },
           barPercentage: 0.8,
           categoryPercentage: 1.0
       }
   });
   
   var values = <?php echo $valuesJSON; ?>;
   var tittle = <?php echo $titlesJSON; ?>;
   var ctx = document.getElementById("pieChart").getContext("2d");
   
   var data = {
       datasets: [{
           data: values,
           backgroundColor: [
               "rgba(255, 99, 132, 0.8)",
               "rgba(54, 162, 235, 0.8)",
               "rgba(255, 206, 86, 0.8)",
               "rgba(75, 192, 192, 0.8)"
           ]
       }],
       labels: tittle
   };
   
   var options = {
       layout: {
           padding: {
               top: 10,
               bottom: 10
           }
       }
   };
   
   var myPieChart = new Chart(ctx, {
       type: "doughnut",
       data: data,
       options: options
   });
</script>
@endsection