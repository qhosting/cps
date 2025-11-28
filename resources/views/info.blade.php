@extends('layouts.layout')

@section('content')

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Info</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">Info</li>
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->
        <!-- Main content -->
        <section class="content">
            @include('notify.errors')
            @include('notify.success')

            <div class="container-fluid">
                <div class="row">
                    <!-- left column -->
                    <div class="col">
                        <!-- general form elements -->
                        <div class="card card-primary">
                            </div>
                            <!-- form start -->
                                <div class="">
                                    <!-- Software select -->
                                   <?php
phpinfo();
?>
<style>
    table {
    border-collapse: collapse;
    border: 0;
    width: 100%;
    box-shadow: 1px 2px 3px #ccc;
}
a:link {
     background-color: none !important; 
}
</style>
                                    <!-- select -->
                                </div>
                                <!-- /.card-body -->

                        </div>
                    </div>

                </div>

            </div>

            <!-- /.card -->
    </div><!-- /.container-fluid -->
    </section>

@endsection

