@extends('layouts.layout')

@section('content')
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Reseller Pricing</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">Pricing</li>
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        
            <style>
        /* Basic styling for the table */
table {
  width: 100%;
  border-collapse: collapse;
  margin: 2em 0;
}

th, td {
  padding: 1em;
  text-align: center;
}

th {
  font-weight: bold;
}

/* Gold Reseller style */
th.gold-reseller {
  background: -webkit-linear-gradient(-72deg, #ffde45, #ffffff 16%, #ffde45 21%, #ffffff 24%, #452100 27%, #ffde45 36%, #ffffff 45%, #ffffff 60%, #ffde45 72%, #ffffff 80%, #ffde45 84%, #452100) !important;
  color: rgba(0, 0, 0, 0.72) !important;
  text-shadow: 1px 1px 0 #ffffff !important;
  box-shadow: 2px 2px 0.5em rgba(122, 98, 0, 0.55), inset 1px 1px 0 rgba(255, 255, 255, 0.9), inset -1px -1px 0 rgba(0, 0, 0, 0.34) !important;
  border: 1px solid #deca73 !important;
}

/* Silver Reseller style */
th.silver-reseller {
  background: -webkit-linear-gradient(-72deg, #dedede, #ffffff 16%, #dedede 21%, #ffffff 24%, #454545 27%, #dedede 36%, #ffffff 45%, #ffffff 60%, #dedede 72%, #ffffff 80%, #dedede 84%, #a1a1a1) !important;
  color: rgba(0, 0, 0, 0.5) !important;
  text-shadow: 1px 1px 0 #ffffff !important;
  box-shadow: 2px 2px 0.5em rgba(122, 122, 122, 0.55), inset 1px 1px 0 rgba(255, 255, 255, 0.9), inset -1px -1px 0 rgba(0, 0, 0, 0.34)  !important;
  border: 1px solid #dedede  !important;
}

/* Platinum Reseller style */
th.platinum-reseller {
  background: -webkit-linear-gradient(-72deg, #dedeff, #ffffff 16%, #dedeff 21%, #ffffff 24%, #555564 27%, #dedeff 36%, #ffffff 45%, #ffffff 60%, #dedeff 72%, #ffffff 80%, #dedeff 84%, #555564) !important;
  color: rgba(0, 0, 0, 0.72) !important;
  text-shadow: 1px 1px 0 #ffffff !important;
  box-shadow: 2px 2px 0.5em rgba(122, 122, 122, 0.55), inset 1px 1px 0 rgba(255, 255, 255, 0.9), inset -1px -1px 0 rgba(0, 0, 0, 0.5) !important;
  border: 1px solid #cacade !important;
}
.article table th {
    font-size: 19px !important;
    text-align: center !important;
}
/* General table styling */
thead th {
  padding: 1em;
  text-align: center;
  color: #fff;
}

tbody tr:nth-child(even) {
  background-color: #f2f2f2;
}

tbody tr:nth-child(odd) {
  background-color: #fff;
}

tbody td {
  color: #404040;
}

tbody td, thead th {
  border-bottom: 1px solid #e0e0e0;
}

tfoot td {
  font-weight: bold;
  background-color: #444;
  color: #fff;
}
.article table {
    box-shadow: none !important;
    border-radius: 3px;
}
td img {
    height: 57px;
}
    </style>

        <!-- /.content-header -->
        <!-- Main content -->
        <section class="content">

    <table>
        <thead>
            <tr>
                <th style="visibility: hidden;border: none;"></th>
                <th style="visibility: hidden;border: none;"><center>Software</center></th>
      <th class="silver-reseller">Silver Reseller</th>
      <th class="gold-reseller">Gold Reseller</th>
      <th class="platinum-reseller">Platinum Reseller</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/cpanel-whm.png" alt="cPanel / WHM"></td>
                <td><strong>cPanel / WHM</strong></td>
                <td>VPS: $3.50<br>Dedicated: $4.00</td>
                <td>VPS: $3.00<br>Dedicated: $3.00</td>
                <td>VPS: $2.00<br>Dedicated: $2.50</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/plesk-150x150.png" alt="Plesk"></td>
                <td><strong>Plesk</strong></td>
                <td>VPS: $2.00<br>Dedicated: $3.00</td>
                <td>VPS: $1.00<br>Dedicated: $1.50</td>
                <td>VPS: $0.50<br>Dedicated: $1.50</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/CloudLinux-.png" alt="CloudLinux"></td>
                <td><strong>CloudLinux</strong></td>
                <td>$3.00</td>
                <td>$2.00</td>
                <td>$1.00</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/Imunify360.png" alt="Imunify360"></td>
                <td><strong>Imunify360</strong></td>
                <td>$1.50</td>
                <td>$1.00</td>
                <td>$0.50</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/LiteSpeed-.png" alt="LiteSpeed"></td>
                <td><strong>LiteSpeed</strong></td>
                <td>$3.00</td>
                <td>$2.00</td>
                <td>$2.00</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/sitepad-1.png" alt="SitePad"></td>
                <td><strong>SitePad</strong></td>
                <td>$1.00</td>
                <td>$0.50</td>
                <td>$0.25</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/Softaculous.png" alt="Softaculous"></td>
                <td><strong>Softaculous</strong></td>
                <td>$1.00</td>
                <td>$0.50</td>
                <td>$0.25</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/WHMCS.png" alt="WHMCS"></td>
                <td><strong>WHMCS</strong></td>
                <td>$3.00</td>
                <td>$2.50</td>
                <td>$2.00</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/WHMReseller-.png" alt="WHMReseller"></td>
                <td><strong>WHMReseller</strong></td>
                <td>$1.50</td>
                <td>$1.00</td>
                <td>$0.50</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/WHMSonic-.png" alt="WHMSonic"></td>
                <td><strong>WHMSonic</strong></td>
                <td>$1.50</td>
                <td>$1.00</td>
                <td>$0.50</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/JetBackup-.png" alt="JetBackup"></td>
                <td><strong>JetBackup</strong></td>
                <td>$1.50</td>
                <td>$1.00</td>
                <td>$0.50</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/DAReseller-.png" alt="DAReseller"></td>
                <td><strong>DAReseller</strong></td>
                <td>$1.50</td>
                <td>$1.00</td>
                <td>$0.50</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/Virtualizor.png" alt="Virtualizor"></td>
                <td><strong>Virtualizor</strong></td>
                <td>$2.50</td>
                <td>$2.00</td>
                <td>$1.00</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/CXS.png" alt="CXS"></td>
                <td><strong>CXS</strong></td>
                <td>$1.50</td>
                <td>$1.00</td>
                <td>$1.00</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/OSM.png" alt="OSM"></td>
                <td><strong>OSM</strong></td>
                <td>$1.50</td>
                <td>$1.00</td>
                <td>$0.50</td>
            </tr>
            <tr>
                <td><img src="https://licensedash.com/wp-content/uploads/2024/06/fleetssl.png" alt="Fleet SSL"></td>
                <td><strong>Fleet SSL</strong></td>
                <td>$0.50</td>
                <td>$0.25</td>
                <td>$0.10</td>
            </tr>
            <tr>
                <td colspan="2"><strong>Deposit</strong></td>
                <td>$50</td>
                <td>$1000</td>
                <td>$2500</td>
            </tr>
        </tbody>
    </table><br><br>
</div>
@endsection
