@extends('layouts.layout')

@section('content')
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Licenses</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">Licenses</li>
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
                                <h3 class="card-title">Renew License</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form role="form" method="post" action="{{ route('license.renew', $license->id) }}">
                                @csrf
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="name">Ip</label>
                                        <input type="text" class="form-control" disabled value="{{ $license->ip }}"
                                            name="ip" id="ip" placeholder="Ip">
                                    </div>
                                    <!-- Software select -->
                                    @php
                                        $software = \App\Software::findorfail($license->software_id);
                                    @endphp
                                    <div class="form-group">
                                        <label>Software</label>
                                        <input type="text" class="form-control" disabled value="{{ $software->name }}"
                                            name="ip" id="ip" placeholder="Ip">
                                    </div>
                                    @php
                                        $reseller_id = App\Models\Reseller::firstWhere('user_id', Auth::id());
                                    @endphp
                                    <div class="form-group" style="display:none">
                                        <label>Reseller</label>
                                        <select class="form-control" name="reseller">
                                            <option value="{{ $reseller_id->id }}"
                                                {{ $reseller_id->reseller_id == $reseller_id->id ? 'selected' : '' }}>
                                                {{ $reseller_id->name }}</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="end_at">Expiry Date:</label>
                                        <input type="text" disabled class="form-control datetime"
                                            value="{{ \Carbon\Carbon::parse($license->end_at)->format('jS F Y') }}"
                                            name="end_at" id="end_at" placeholder="End At">
                                    </div>
                                    <div class="form-group">
                                        <label for="end_at">Renew For</label>
                                        <select class="form-control" name="end_at" id="show_month">
                                        </select>
                                    </div>

                                    <!-- select -->

                                </div>

                                <!-- /.card-body -->
                                <div class="card-footer text-left">
                                    <button type="submit" class="btn btn-primary">Renew</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>

            </div>

            <!-- /.card -->
    </div><!-- /.container-fluid -->
    </section>
@endsection
@push('script')
    <script>
        // A $( document ).ready() block.
        $(document).ready(function() {
            var softwareId = {{ $software->id }};
            $.ajax({
                url: "/panel/product/price/" + softwareId,
                success: function(data) {
                    $('#show_month').html(data);
                }
            });
        });
    </script>

    <script>
        const makeLicenseKey = key => {
            console.dir(key.attributes);
            $('#div-content').removeClass('d-none');
        }
    </script>
@endpush
