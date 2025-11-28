@extends('layouts.layout')

@section('content')
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-dark">Settings Page</h1>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="{{route('home')}}">Home</a></li>
                        <li class="breadcrumb-item active">Settings</li>
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
                <div class="col-md-6">
                    <!-- general form elements -->
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Edit Settings</h3>
                        </div>
                        <!-- /.card-header -->
                        <!-- form start -->
                        <form role="form" method="post" action="{{route('setting.updateEnvSettings')}}">
                            @csrf
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="site_name">Site name</label>
                                    <input type="text" class="form-control" name="site_name" value="{{$site_name->value}}" id="site_name" placeholder="Site Name">
                                </div>
                                <div class="form-group">
                                    <label for="whmcs_domain">Whmcs domain</label>
                                    <input type="text" class="form-control" name="whmcs_domain" value="{{$whmcs_domain->value}}" id="whmcs_domain" placeholder="Whmcs Domain">
                                </div>
                                <div class="form-group">
                                    <label for="whmcs_username">Whmcs username</label>
                                    <input type="text" class="form-control" name="whmcs_username" value="{{$whmcs_username->value}}" id="whmcs_username" placeholder="Whmcs Username">
                                </div>
                                <div class="form-group">
                                    <label for="whmcs_password">Whmcs password</label>
                                    <input type="password" class="form-control" name="whmcs_password" value="{{$whmcs_password->value}}" id="whmcs_password" placeholder="Whmcs Password">
                                </div>
                                
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer text-right">
                                <button type="submit" class="btn btn-primary">Update Settings</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- right column -->
                <div class="col-md-6">
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Edit Environment Settings</h3>
                        </div>
                        <!-- form start -->
                        <form role="form" method="post"  action="{{route('setting.updateEnvSettings')}}">
                            @csrf
                            <div class="form-group px-4 pt-4">
                                <label for="STRIPE_KEY">License Key</label>
                                <input type="text" class="form-control" name="APP_LICENSE" value="{{ env('APP_LICENSE') }}" placeholder="License Key">
                            </div>
                            <div class="form-group px-4">
                                <label for="STRIPE_KEY">Application URL</label>
                                <input type="text" class="form-control" name="APP_URL" value="{{ env('APP_URL') }}" placeholder="Application URL">
                            </div>
                            <div class="form-group px-4">
                                <label for="STRIPE_KEY">Stripe Key</label>
                                <input type="text" class="form-control" name="STRIPE_KEY" value="{{ env('STRIPE_KEY') }}" placeholder="Stripe Key">
                            </div>
                            <div class="form-group px-4">
                                <label for="STRIPE_SECRET">Stripe Secret Key</label>
                                <input type="text" class="form-control" name="STRIPE_SECRET" value="{{ env('STRIPE_SECRET') }}" placeholder="Stripe Secret Key">
                            </div>
                            <div class="form-group px-4">
                                <label for="STRIPE_WEBHOOK_SECRET">Stripe Webhook Secret</label>
                                <input type="text" class="form-control" name="STRIPE_WEBHOOK_SECRET" value="{{ env('STRIPE_WEBHOOK_SECRET') }}" placeholder="Stripe Webhook Secret">
                            </div>
                            <div class="form-group px-4 pb-4">
                                <label for="API_TOKEN">API Token</label>
                                <input type="text" class="form-control" name="API_TOKEN" value="{{ env('API_TOKEN') }}" placeholder="API Token">
                            </div>
                            <div class="card-footer text-right">
                                <button type="submit" class="btn btn-primary">Update Environment</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
</div>
@endsection
