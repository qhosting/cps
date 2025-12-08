@extends('layouts.layout')

@section('content')
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Resellers</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">Resellers</li>
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
                                <h3 class="card-title">Add Reseller</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form role="form" method="post" action="{{ route('reseller.add') }}">
                                @csrf
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="name">Name</label>
                                        <input type="text" class="form-control" value="{{ old('username') }}"
                                            name="username" id="username" placeholder="Name">
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Email</label>
                                        <input type="email" class="form-control" value="{{ old('email') }}"
                                            name="email" id="email" placeholder="Email">
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Password</label>
                                        <input type="text" class="form-control" value="{{ Str::random(15) }}"
                                            name="password" id="password" placeholder="Password">
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Branding</label>
                                        <input type="text" class="form-control" value="{{ old('name') }}"
                                            name="name" id="name" placeholder="Brand">
                                    </div>
                                    <div class="form-group">
                                        <label for="main_domain">Brand Domain</label>
                                        <input type="text" class="form-control" value="{{ old('main_domain') }}"
                                            name="main_domain" id="main_domain" placeholder="Main Domain">
                                    </div>
                                    <div class="form-group">
                                        <label for="domain">API Domain</label>
                                        <input type="text" class="form-control" value="{{ old('domain') }}"
                                            name="domain" id="domain" placeholder="Domain">
                                    </div>
                                    <div class="form-group" id="balance">
                                        <label for="balance">Balance</label>
                                        <input type="number" step="0.5" data-decimals="1" class="form-control"
                                            value="{{ old('balance') }}" name="balance" id="balance"
                                            placeholder="Balance">
                                    </div>
                                    <!-- select -->
                                    <div class="form-group">
                                        <label>Level</label>
                                        @if (Auth::user()->role == 'admin')
                                            <select class="form-control" name="level">
                                                <option value="">None</option>
                                                @foreach ($levels as $level)
                                                    <option value="{{ $level->id }}">{{ $level->title }}</option>
                                                @endforeach
                                            </select>
                                        @else
                                            @php
                                                $id = Auth::id();
                                                $levels = \App\LevelReseller::where('user_id', $id)->get();
                                            @endphp

                                            <select class="form-control" name="level">
                                                @if ($levels->count() === 0)
                                                    <option value="">None</option>
                                                @else
                                                    <option value="">None</option>
                                                    @foreach ($levels as $level)
                                                        <option value="{{ $level->id }}">{{ $level->title }}</option>
                                                    @endforeach
                                                @endif
                                            </select>
                                        @endif
                                    </div>
                                    <!-- select -->
                                    @if (Auth::user()->role == 'admin')
                                        <div class="form-group">
                                            <label>Role</label>
                                            <select class="form-control" name="role" id="role">
                                                <option value="reseller">Reseller</option>
                                                <option value="master">Master Reseller</option>
                                            </select>
                                        </div>
                                        <select class="form-control" name="reseller_limit" id="reseller-limit"
                                            style="display: none;">
                                            <!-- this select element will be populated dynamically based on the selection made in the first select element -->
                                        </select>
                                    @endif
                                </div>

                                <!-- /.card-body -->

                                <div class="card-footer text-right">
                                    <button type="submit" class="btn btn-primary">Submit</button>
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

    <script>
        // JavaScript code to populate the second select element based on the first select element

        // get references to the select elements
        var roleSelect = document.getElementById('role');
        var resellerLimitSelect = document.getElementById('reseller-limit');

        // define the options for the second select element
        var masterResellerOptions = [{
                value: '10',
                label: '10 Accounts'
            },
            {
                value: '50',
                label: '50 Accounts'
            },
            {
                value: '999999',
                label: 'Unlimited Accounts'
            },
        ];

        // add an event listener to the first select element
        roleSelect.addEventListener('change', function() {
            // determine whether to show or hide the second select element based on the selected value in the first select element
            if (roleSelect.value === 'master') {
                var shouldShowResellerLimitSelect = true;
            } else {
                var shouldShowResellerLimitSelect = false;
            }

            // update the visibility of the second select element based on the above condition
            resellerLimitSelect.style.display = shouldShowResellerLimitSelect ? 'block' : 'none';

            // clear the options in the second select element
            resellerLimitSelect.innerHTML = '';

            // determine which options to show based on the selected value in the first select element
            if (roleSelect.value === 'master') {
                var options = masterResellerOptions;
            } else {
                var options = [];
            }

            // populate the second select element with the appropriate options
            for (var i = 0; i < options.length; i++) {
                var option = document.createElement('option');
                option.value = options[i].value;
                option.textContent = options[i].label;
                resellerLimitSelect.appendChild(option);
            }
        });
    </script>
@endsection
