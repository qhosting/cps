@extends('layouts.layout')

@section('content')

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Checkout</h1>
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
                                <h3 class="card-title">Order License</h3>
                            </div>
                            </div>
                            <h3 class="card-title">With this option, you can offer your clients 7 days of free trial of any license to your clients. completely free. Trial can only be applied once per IP address for each license type.</h3>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form role="form" method="post" action="{{ route('license.trial') }}">
                                @csrf
                                <div class="card-body">
                                    <!-- Software select -->
                                    <div class="form-group">
                                        <label>Select Software:</label>
                                        <select onchange="makeLicenseKey(this)" class="form-control" name="software_id">
                                            @if ($softwares)
                                                @foreach ($softwares as $software)
                                                    <option key-name="{{ $software->name }}" value="{{ $software->id }}"
                                                        {{ old('status') == $software->id ? 'selected' : '' }}>
                                                        {{ $software->name }}</option>
                                                @endforeach
                                            @endif
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Enter IPv4:</label>
                                        <input type="text" class="form-control" value="{{ old('ip') }}"
                                            name="ip" id="ip" placeholder="">
                                    </div>
                                    <!-- End at select -->
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
                                    <!-- select -->
                                </div>
                                <!-- /.card-body -->

                                <div class="card-footer">
                                    <button type="submit" class="btn btn-primary">Order</button>
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
        const makeLicenseKey = key => {
            console.dir(key.attributes);
        }
    </script>
@endpush
