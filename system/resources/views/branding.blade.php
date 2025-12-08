@extends('layouts.layout')

@section('content')

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Branding</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">Branding</li>
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
                                <h3 class="card-title">Branding</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            @php
                                $reseller = App\Models\Reseller::firstWhere('user_id', Auth::id());
                            @endphp
                            <form role="form" method="post" action="{{ route('reseller.branding', $reseller->id) }}">
                                @csrf
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="name">Brand Name(Ex: CPS)</label>
                                        <input type="text" class="form-control" value="{{ $reseller->name }}"
                                            name="name" id="name" placeholder="Brand">
                                    </div>
                                    <div class="form-group">
                                        <label for="main_domain">Brand Domain(Ex: cpanelseller.xyz)</label>
                                        <input type="text" class="form-control" value="{{ $reseller->main_domain }}"
                                            name="main_domain" id="main_domain" placeholder="Main Domain">
                                    </div>
                                    <div class="form-group">
                                        <label for="domain">Repo Domain(Ex: mirror.cpanelseller.xyz)</label>
                                        <input type="text" class="form-control" value="{{ $reseller->domain }}"
                                            name="domain" id="domain" placeholder="Domain">
                                    </div>
                                </div>

                                <!-- /.card-body -->
                                <div class="card-footer text-left">
                                    <button type="submit" class="btn btn-primary">Change</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <!-- general form elements -->
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Instructions</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <ul class="list-group p-3">
                                <li class="list-group-item">Your provided Brand name will show on activatior screen.</li>
                                <li class="list-group-item">Use your brand domain as which domain you want to use as selling licenses.</li>
                                <li class="list-group-item">Repo sub-domain where you will need to host the pre.sh file.</li>
                            </ul>

                        </div>
                    </div>

                </div>

            </div>

            <!-- /.card -->
    </div><!-- /.container-fluid -->
    </section>


@endsection

@section('endfooter')
    <script>
        $(document).ready(function() {
            $('#type').change(function(e) {
                if ($(e.target).val() == 'whmcs') {
                    $('.client_view').show();
                    $('#balance').hide();

                } else {
                    $('.client_view').hide();
                    $('#balance').show();

                }
            });
            $("#getClients").select2({
                minimumInputLength: 3,
                ajax: {
                    url: "{{ route('getClients') }}",
                    dataType: 'json',
                    type: 'GET',
                    data: function(params) {

                        return {
                            term: params.term, // search term
                        };
                    },
                    processResults: function(data) {
                        var arr = []
                        $.each(data, function(index, value) {
                            arr.push({
                                id: value.id,
                                text: value.email
                            })
                        })
                        return {
                            results: arr
                        };
                    },

                }
            });

        });
    </script>
@endsection
