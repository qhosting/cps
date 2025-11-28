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
                    <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Basic Info</h3>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                <div class="form-group">
                                        <label for="name">Hostname:</label>
                                        <span id="hostname"></span>
                                    </div>
                                </div>
                                <div id="server-status">
                                    Server Status: <span id="status-text"></span>
                                </div><br>
                            </div>
                        </div>
                        <!-- general form elements -->
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Edit License</h3>
                            </div>
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form role="form" method="post" action="{{ route('license.edit', $license->id) }}">
                                @csrf
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="name">IPv4:</label>
                                        <input type="text" class="form-control" value="{{ $license->ip }}"
                                            name="ip" id="ip" placeholder="Ip">
                                    </div>
                                    <div class="form-group">
                                        <label>Software:</label>
                                        @php
                                            $software = \App\Software::firstWhere('id', $license->software_id);
                                        @endphp
                                        <input type="text" disabled class="form-control" value="{{ $software->name }}"
                                            name="software_id" id="software" placeholder="Software">
                                    </div>
                                    <div class="form-group">
                                        <label for="name">License Key:</label>
                                        <input type="text" class="form-control"
                                            value="{{ $license->license_key }}" name="license_key" id="license_key"
                                            placeholder="" disabled>
                                    </div>
                                    <div class="form-group">
                                        <label for="end_at">Ordered On:</label>
                                        <input type="text" disabled class="form-control datetime"
                                            value="{{ \Carbon\Carbon::parse($license->created_at)->format('jS F Y') }}"
                                            name="end_at" id="end_at" placeholder="End At">
                                    </div>
                                    <div class="form-group">
                                        <label for="end_at">Expiry Date:</label>
                                        <input type="text"  class="form-control datetime"
                                            value="{{ \Carbon\Carbon::parse($license->end_at)->format('jS F Y') }}"
                                            name="end_at" id="end_at" placeholder="End At" disabled>
                                    </div>
                                    <!-- Software select -->


                                    <!-- select -->
                                    <div class="form-group">
                                        <label>Status</label>
                                        @if (time() < strtotime($license->end_at))
                                            <input type="text" disabled class="form-control"
                                                value="{{ $license->status == 1 ? 'Active' : 'Suspended' }}" name="status"
                                                id="status" placeholder="Status">
                                        @else
                                            <input type="text" disabled class="form-control" value="Expired"
                                                name="status" id="status" placeholder="Status">
                                        @endif



                                    </div>
                                    <div class="form-group">
                                        <label for="end_at">License Type:</label>
                                        <input type="text" disabled class="form-control datetime"
                                            value="{{ $license->type }}" name="end_at" id="end_at" placeholder="End At">
                                    </div>

                                    <div class="form-group">
                                        @php
                                            $cmd = \App\Software::firstWhere('id', $license->software_id);
                                            $reseller = \App\Reseller::firstWhere('id', $license->reseller_id);
                                        @endphp
                                        <label for="cmd">Installation Commands:</label>
                                        {{-- Textarea for displaying installation commands --}}
    <textarea type="text" disabled class="form-control datetime" style="overflow: hidden; resize: none; height: auto;" name="cmd" id="cmd" placeholder="Installation Commands">
        {{ str_replace('{domain}', $reseller->domain, $cmd->cmd) }}
    </textarea>
</div>

<script>
    // Function to resize textarea based on its content
    function resizeTextarea() {
        var textarea = document.getElementById('cmd');
        textarea.style.height = 'auto'; // Reset height to auto
        textarea.style.height = textarea.scrollHeight + 'px'; // Set height to content height
    }

    // Call resizeTextarea initially and whenever the content changes
    document.addEventListener('DOMContentLoaded', function () {
        var textareas = document.querySelectorAll('textarea');
        textareas.forEach(resizeTextarea);
    });

    // Call resizeTextarea when the textarea is resized manually
    document.getElementById('cmd').addEventListener('input', function () {
        resizeTextarea(this);
    });
</script>
                                    </div>

                                </div>

                                <!-- /.card-body -->
                                <div class="card-footer text-left">
                                    <button type="submit" class="btn btn-primary">Make changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Auto Renew</h3>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <form method="post" action="{{ route('license.toggleAutoRenew', $license->id) }}">
                                        @csrf
                                        <div class="form-group">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" name="auto_renew"
                                                    id="auto_renew" {{ $license->auto_renew ? 'checked' : '' }}>
                                                <label class="form-check-label" for="auto_renew">
                                                    {{ $license->auto_renew ? 'Auto Renew: On' : 'Auto Renew: Off' }}
                                                </label>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Save Auto Renew</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.card -->
    </div><!-- /.container-fluid -->
    </section>
    <script>
        function getHostname(ipAddress) {
            fetch('/get-hostname?ip=' + ipAddress)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('hostname').textContent = data.hostname;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }

        getHostname('{{ $license->ip }}');
    </script>
<script>
    function checkServerAndHostname() {
        const ipAddress = "{{ $license->ip }}"; // Get the IP address from Blade template

        // Check server status
        fetch('/ping-server/' + ipAddress)
            .then(response => {
                console.log('Ping response status:', response.status); // Log the response status
                if (response.ok) {
                    document.getElementById('status-text').textContent = 'Online';
                    document.getElementById('status-text').style.color = 'green';
                    return fetch('/get-hostname?ip=' + ipAddress);
                } else {
                    throw new Error('Server is offline');
                }
            })
            .then(response => {
                return response.json(); // Ensure we return the JSON response
            })
            .then(data => {
                document.getElementById('hostname').textContent = data.hostname;
            })
            .catch(error => {
                document.getElementById('status-text').textContent = `offline`;
                document.getElementById('status-text').style.color = 'red';
                console.error('Error:', error);
            });
    }

    checkServerAndHostname();
</script>
@endsection
