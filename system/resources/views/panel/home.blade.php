@extends('layouts.layout')

@section('content')
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Dashboard</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->

            <!-- /.content-header -->

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <!-- Small boxes (Stat box) -->
                    <div class="row">
                        @if (Auth::user()->role == 'admin')
                            <div class="col-lg-3 col-6">
                                <!-- small box -->
                                <div class="small-box bg-info">
                                    <div class="inner">
                                        <h3>{{ \App\License::where('status', '1')->where('end_at', '>=', now())->count() }}
                                        </h3>

                                        <p>Active Licenses</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-bag"></i>
                                    </div>
                                    <a href="{{ route('licenses') }}" class="small-box-footer">More info <i
                                            class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                            <div class="col-lg-3 col-6">
                                <!-- small box -->
                                <div class="small-box bg-success">
                                    <div class="inner">

                                        <h3>{{ \App\Reseller::sum('balance') }}$</h3>

                                        <p>Wallet Balance</p>
                                    </div>
                                    <div class="icon">
                                        <i class="fas fa-dollar-sign"></i>
                                    </div>
                                    <a href="{{ route('redeem.store') }}" class="small-box-footer">More info <i
                                            class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                            <div class="col-lg-3 col-6">
                                <!-- small box -->
                                <div class="small-box bg-warning">
                                    <div class="inner">
                                        <h3>{{ \App\License::where('end_at', '<=', now()->addDays(7))->where('end_at', '>', now())->count() }}
                                        </h3>

                                        <p>Expiring Licenses in 7 Days</p>
                                    </div>
                                    <div class="icon">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <a href="{{ route('licenses') }}" class="small-box-footer">More info <i
                                            class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>

                            <div class="col-lg-3 col-6">
                                <!-- small box -->
                                <div class="small-box bg-danger">
                                    <div class="inner">
                                        <h3>{{ \App\License::where('end_at', '<', now())->count() }}</h3>

                                        <p>Expired Licenses</p>
                                    </div>
                                    <div class="icon">
                                        <i class="fas fa-times-circle"></i>
                                    </div>
                                    <a href="{{ route('licenses') }}" class="small-box-footer">More info <i
                                            class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                    </div>
                @else
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-info">
                            <div class="inner">
                                @php
                                    $reseller_id = App\Models\Reseller::firstWhere('user_id', Auth::id())->id;
                                @endphp
                                <h3>{{ \App\License::where('reseller_id', $reseller_id)->where('status', '1')->where('end_at', '>=', now())->count() }}
                                </h3>

                                <p>Active Licenses</p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-bag"></i>
                            </div>
                            <a href="{{ route('licenses') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-success">
                            <div class="inner">

                                <h3>${{ App\Models\Reseller::firstWhere('user_id', Auth::id())->balance }}</h3>

                                <p>Wallet Balance</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <a href="{{ route('redeem.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-warning">
                            <div class="inner">
                                <h3>{{ \App\License::where('reseller_id', $reseller_id)->where('end_at', '<=', now()->addDays(7))->where('end_at', '>', now())->count() }}
                                </h3>

                                <p>Expiring Licenses in 7 Days</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            <a href="{{ route('licenses') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>

                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-danger">
                            <div class="inner">
                                <h3>{{ \App\License::where('reseller_id', $reseller_id)->where('end_at', '<', now())->count() }}
                                </h3>

                                <p>Expired Licenses</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-times-circle"></i>
                            </div>
                            <a href="{{ route('licenses') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                </div>
                @endif

                <div class="row">
                    <!-- left column -->

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

                </div>
                <div class="row">
                    <!-- left column -->
                    <section class="col">
        <div class="card">
            <div class="card-header cartts">
                <h3 class="card-title">Notice</h3>
            </div>
            <div class="card-body">
            @foreach($notices->take(2) as $notice)
                <div class="notice">
                    <h3>{{ $notice->title }}</h3>
                    <p>{{ $notice->content }}</p>
                    <p>Posted on: {{ $notice->created_at->format('F d, Y H:i A') }}</p>
                </div>
            @endforeach

            @if ($notices->count() > 2)
                <a href="{{ route('notices.index') }}">View all</a>
            @endif
            </div>
        </div>

                    </section>

                </div>
            </section>
            <!-- right col -->
        </div>

        <!-- /.row (main row) -->
    </div><!-- /.container-fluid -->
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
                    backgroundColor: 'rgba(60,141,188,0.9)',
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
