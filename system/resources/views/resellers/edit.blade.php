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
                                <h3 class="card-title">Edit Reseller</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form role="form" method="post" action="{{ route('reseller.edit', $reseller->id) }}">
                                @csrf
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="token">Token</label>
                                        <input type="text" class="form-control" readonly value="{{ $reseller->token }}"
                                            name="token" id="token" placeholder="Token">
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Brand Name</label>
                                        <input type="text" class="form-control" value="{{ $reseller->name }}"
                                            name="name" id="name" placeholder="Brand">
                                    </div>
                                    <div class="form-group">
                                        <label for="main_domain">Branding Domain</label>
                                        <input type="text" class="form-control" value="{{ $reseller->main_domain }}"
                                            name="main_domain" id="main_domain" placeholder="Main Domain">
                                    </div>
                                    <div class="form-group">
                                        <label for="domain">Api Domain</label>
                                        <input type="text" class="form-control" value="{{ $reseller->domain }}"
                                            name="domain" id="domain" placeholder="Domain">
                                    </div>
                                    <div class="form-group" id="balance">
                                        <label for="balance">Balance</label>
                                        <input type="number" step="0.5" data-decimals="2" class="form-control"
                                            value="{{ $reseller->balance }}" name="balance" id="balance"
                                            placeholder="Balance">
                                    </div>
                                    <!-- select -->
                                    <div class="form-group">
                                        <label>Level</label>
                                        @if (Auth::user()->role == 'admin')
                                            @php
                                                $levelId = $reseller->level_id;
                                                $levelL = \App\LevelReseller::firstWhere('id', $levelId);
                                            @endphp
                                            <select class="form-control" name="level">
                                                <option value="{{ $levelL->id }}">{{ $levelL->title }}</option>
                                                @foreach ($levels as $level)
                                                    <option value="{{ $level->id }}">{{ $level->title }}</option>
                                                @endforeach
                                            </select>
                                        @endif
                                        @if (Auth::user()->role == 'master')
                                            @php
                                                $levelId = $reseller->level_id;
                                                $Id = Auth::id();
                                                $levelL = \App\LevelReseller::where('id', $levelId)->first();
                                                $levels = \App\LevelReseller::where('user_id', $Id)->get();
                                            @endphp
                                            <select class="form-control" name="level">
                                                @if ($levels->count() === 0)
                                                    <option value="">None</option>
                                                @else
                                                    @if (!$levelL)
                                                        <option value="">None</option>
                                                        @foreach ($levels as $level)
                                                            <option value="{{ $level->id }}">{{ $level->title }}
                                                            </option>
                                                        @endforeach
                                                    @else
                                                        <option value="{{ $levelL->id }}">{{ $levelL->title }}</option>
                                                        @foreach ($levels as $level)
                                                            <option value="{{ $level->id }}">{{ $level->title }}
                                                            </option>
                                                        @endforeach
                                                    @endif
                                                @endif
                                            </select>
                                        @endif
                                    </div>

                                    <!-- select -->
                                    <div class="form-group">
                                        <label>Status</label>
                                        <select class="form-control" name="status">
                                            <option value="1" {{ $reseller->status == 1 ? 'selected' : '' }}>Active
                                            </option>
                                            <option value="0" {{ $reseller->status != 1 ? 'selected' : '' }}>Disable
                                            </option>
                                        </select>
                                    </div>

                                    @if (Auth::user()->role == 'admin')
                                        <div class="form-group">
                                            <label>Trial Permission</label>
                                            <select class="form-control" name="trial_perm" id="trial_perm">
                                                <option value="1" {{ $reseller->trial_perm == 1 ? 'selected' : '' }}>
                                                    Active</option>
                                                <option value="0" {{ $reseller->trial_perm != 1 ? 'selected' : '' }}>
                                                    Disable</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Role</label>
                                            @php
                                                $Id = $reseller->user_id;
                                                $Role = \App\User::firstwhere('id', $Id);
                                            @endphp
                                            <select class="form-control" name="role" id="role">
                                                <option value="reseller" {{ $Role->role == 'reseller' ? 'selected' : '' }}>
                                                    Reseller</option>
                                                <option value="master" {{ $Role->role == 'master' ? 'selected' : '' }}>
                                                    Master Reseller
                                                </option>
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
                                    <button type="submit" class="btn btn-primary">Update</button>
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

        // Check if user is on the edit page and the role of the user is 'master'
        var isMasterReseller = (window.location.href.indexOf("edit") > -1 && roleSelect.value === 'master');

        // Set the initial value of the first select element to 'master' if the user is a master reseller on the edit page
        if (isMasterReseller) {
            roleSelect.value = 'master';
        }

        // update the visibility of the second select element based on the selected value in the first select element
        var shouldShowResellerLimitSelect = roleSelect.value === 'master';
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

        // add an event listener to the first select element
        roleSelect.addEventListener('change', function() {
            // update the visibility of the second select element based on the selected value in the first select element
            var shouldShowResellerLimitSelect = roleSelect.value === 'master';
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
