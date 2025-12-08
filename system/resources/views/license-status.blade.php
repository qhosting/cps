@extends('layouts.layout')

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="m-0 text-dark">License Information</h1>
                </div>
                <div class="col-md-6">
                    <ol class="breadcrumb float-md-right">
                        <li class="breadcrumb-item"><a href="{{ route('home') }}" class="text-primary">Home</a></li>
                        <li class="breadcrumb-item active">License Status</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <section class="content">
        @include('notify.errors')
        @include('notify.success')

        <div class="container-fluid">
            <div class="row">
                <!-- License Details -->
                <div class="col-lg-6 mb-4">
                    <div class="card border-info shadow">
                        <div class="card-header bg-success text-white">
                            <h3 class="card-title"><i class="fas fa-info-circle"></i> License Details</h3>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                @if(!empty($brand))
                                    <li class="list-group-item"><strong>Brand:</strong> {{ $brand }}</li>
                                @endif
                                @if(!empty($domain))
                                    <li class="list-group-item"><strong>Domain:</strong> {{ $domain }}</li>
                                @endif
                                @if(!empty($keyCmd))
                                    <li class="list-group-item"><strong>Command:</strong> {{ $keyCmd }}</li>
                                @endif
                                @if(!empty($expiryDate))
                                    <li class="list-group-item">
                                        <strong>Expire Date:</strong> {{ \Carbon\Carbon::parse($expiryDate)->format('d-m-Y') }}
                                    </li>
                                @endif
                                <li class="list-group-item"><strong>Days until Expiry:</strong> {{ (int)$remainingDays }} days</li>
                            </ul>

                            @php
                                $normalizedStatus = strtolower(trim($apiStatus ?? ''));
                                $isActive = in_array($normalizedStatus, ['active', 'success']);
                            @endphp

                            <div class="alert {{ $isActive ? 'alert-success' : 'alert-danger' }} mt-3">
                                <strong>Status:</strong> {{ $isActive ? 'Active' : ucfirst($apiStatus ?? 'Unknown') }}
                            </div>

                            @if ($isActive && !empty($expiryDate))
                                <p class="text-success mt-2">
                                    Your license is active until <strong>{{ \Carbon\Carbon::parse($expiryDate)->format('d-m-Y') }}</strong>.
                                </p>
                            @elseif (!$isActive)
                                <p class="text-danger mt-2">
                                    Your license is not active. Please contact support for assistance with renewing your license.
                                </p>
                            @endif
                        </div>
                        <div class="card-footer">
                            <a href="https://whmseller.net/" class="btn btn-success"><i class="fas fa-sync"></i> Renew License</a>
                            <a href="{{ url('/panel/license-status') }}" class="btn btn-primary"><i class="fas fa-redo"></i> Refresh License</a>
                        </div>
                    </div>
                </div>

                <!-- Additional Info -->
                <div class="col-lg-6 mb-4">
                    <div class="card shadow">
                        <div class="card-header bg-dark text-white">
                            <h3 class="card-title"><i class="fas fa-lightbulb"></i> License Management Tips</h3>
                        </div>
                        <div class="card-body">
                            <h5 class="text-muted">Using API-based Licensing:</h5>
                            <ul class="list-unstyled">
                                <li><strong>1. Always Keep API Accessible:</strong> Ensure the domain <code>api.cpanelseller.xyz</code> is reachable so your license can be validated.</li>
                                <li><strong>2. Monitor Expiry:</strong> The system checks expiry automatically from the API (<code>expire_date</code> field). Renew your license before it expires.</li>
                                <li><strong>3. Domain Binding:</strong> Your license is tied to the registered domain. Updating or transferring requires contacting support.</li>
                                <li><strong>4. Secure API Usage:</strong> Do not share your API keys. They are unique to your account and licenses.</li>
                            </ul>
                        </div>
                    </div>
                    <div class="card shadow mt-4">
                        <div class="card-header bg-secondary text-white">
                            <h3 class="card-title"><i class="fas fa-exclamation-circle"></i> Important Instructions</h3>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">This page is visible only to admin users.</li>
                                <li class="list-group-item">Tampering with API calls or bypassing the validation process may result in immediate suspension.</li>
                                <li class="list-group-item">Licenses are validated directly via the API endpoint: <code>https://api.cpanelseller.xyz/api/getinfo</code>.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection

@section('endfooter')
<script>
    // Custom JS if needed
</script>
@endsection
