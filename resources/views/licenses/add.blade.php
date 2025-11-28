@extends('layouts.layout')

@section('content')

<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-dark">Checkout</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                        <li class="breadcrumb-item active">Licenses</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
<style>
    /* Container for the software grid */
#software-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
}

/* Individual selectable box */
.software-box {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 108px;
    height: 120px;
    padding: 10px;
    border: 2px solid #ccc;
    border-radius: 8px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
}

/* Hidden radio input */
.software-box input {
    display: none;
}

/* Box content (image + name) */
.software-box .box-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
}

/* Image styling */
.software-box img {
    max-width: 50px;
    height: auto;
    border-radius: 5px;
}

/* Hover effect */
.software-box:hover {
    border-color: #007bff;
    background-color: #f8f9fa;
}

/* Selected box styling */
.software-box input:checked + .box-content {
    border-color: #007bff;
    font-weight: bold;
    color: #007bff;
}
span {
    height: 26px;
    overflow: hidden;
}
</style>
    <section class="content">
        @include('notify.errors')
        @include('notify.success')

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Order License</h3>
                        </div>
                        <form role="form" method="post" action="{{ route('license.add') }}">
                            @csrf
                            <div class="card-body">
                                <div class="form-group">
                                    <label>Select Software:</label>
                                    <div class="d-flex flex-wrap gap-3" id="software-grid">
                                        @if ($softwares)
                                            @foreach ($softwares as $software)
                                                <label class="software-box">
                                                    <input type="radio" name="software_id" value="{{ $software->id }}"
                                                        key-name="{{ $software->name }}">
                                                    <div class="box-content">
                                                        <img src="/path/to/logo.png" alt="{{ $software->name }}">
                                                        <span>{{ $software->name }}</span>
                                                    </div>
                                                </label>
                                            @endforeach
                                        @endif
                                    </div>
                                </div>
                                <!-- Modal for Buy For -->
                                <div class="modal fade" id="buyForModal" tabindex="-1" role="dialog" aria-labelledby="buyForModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="buyForModalLabel">Add a new license</h5>
                                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form id="buyForForm" method="post" action="{{ route('license.add') }}">
                                                    @csrf
                                                    <input type="hidden" name="software_id" id="selectedSoftwareId">
                                                    <div class="form-group">
                                                        <label for="show_month">Select Plan:</label>
                                                        <select class="form-control" name="end_at" id="show_month"></select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="ip">IPv4</label>
                                                        <input type="text" class="form-control" name="ip" id="ip" placeholder="Enter IP address">
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">Close</button>
                                                                <button type="submit" class="btn btn-primary">Submit</button>
                                            </div>
                                        </div>
                                    </div>
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
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

@endsection

@push('script')
<script>
    $(function () {
        $('#software-grid input[name="software_id"]').change(function () {
            let softwareId = $(this).val();
            $('#selectedSoftwareId').val(softwareId);

            // Fetch the plan details for the selected software
$.ajax({
    url: "/panel/product/price/" + softwareId,
    success: function (data) {
        // Ensure the select element is empty before adding new options
        $('#show_month').html(data);
    },
    error: function (xhr) {
        alert('An error occurred. Please try again.');
    }
});

            // Show the modal
            $('#buyForModal').modal('show');
        });

        // Handle form submission
        $('#buyForForm').on('submit', function (e) {
            e.preventDefault(); // Prevent default form submission
            let formData = $(this).serialize(); // Collect form data

            // Submit the form via AJAX
            $.ajax({
                url: $(this).attr('action'),
                method: "POST",
                data: formData,
                success: function (response) {
                    alert('Form submitted successfully!');
                    $('#buyForModal').modal('hide'); // Close the modal
                },
                error: function (xhr) {
                    alert('An error occurred. Please try again.');
                }
            });
        });
    });

document.addEventListener("DOMContentLoaded", function () {
    // Get the base URL from Laravel's configuration
    const baseUrl = "<?php echo env('APP_URL'); ?>";

    // Mapping of software names to their respective image paths
    const softwareImages = {
        "cPanel VPS": "/dist/img/softwares/CPVPS.png",
        "cPanel Dedicated": "/dist/img/softwares/CPDS.png",
        "cPanel WP Squared": "/dist/img/softwares/wpsquared.svg",
        "Softaculous": "/dist/img/softwares/Softaculous.png",
        "Plesk VPS": "/dist/img/softwares/plesk.png",
        "CloudLinux": "/dist/img/softwares/CloudLinux-.png",
        "Imunify360": "/dist/img/softwares/Imunify360.png",
        "Virtualizor Premium": "/dist/img/softwares/Virtualizor.png",
        "SitePad": "/dist/img/softwares/sitepad.png",
        "JetBackup": "/dist/img/softwares/JetBackup-.png",
        "WHMReseller": "/dist/img/softwares/WHMReseller-.png",
        "Litespeed 2 Worker": "/dist/img/softwares/LiteSpeed-.png",
        "Litespeed X Worker": "/dist/img/softwares/LiteSpeed-.png",
        "Litespeed 4 Worker": "/dist/img/softwares/LiteSpeed-.png",
        "Litespeed 8 Worker": "/dist/img/softwares/LiteSpeed-.png",
        "Virtualizor Professional": "/dist/img/softwares/Virtualizor.png",
        "Plesk Dedicated": "/dist/img/softwares/plesk.png",
        "Kernelcare+": "/dist/img/softwares/kernelcare.png",
        "OSM": "/dist/img/softwares/OSM.png",
        "CXS": "/dist/img/softwares/CXS.png",
        "Dareseller": "/dist/img/softwares/DAReseller-.png",
        "Litespeed 1 Worker": "/dist/img/softwares/LiteSpeed-.png",
        "Directadmin": "/dist/img/softwares/da_logo.png",
        "Webuzo": "/dist/img/softwares/Webuzo.png",
        "AaPanel": "/dist/img/softwares/aaPanel.png",
        "MediaCP": "/dist/img/softwares/MediaCP_Logo_Alternative.webp",
        "cPnginx": "/dist/img/softwares/cpnginx-.png",
        "WHMCS": "/dist/img/softwares/WHMCS.png",
        "WhmXtra": "/dist/img/softwares/WHMXtra.png",
        "FleetSSL": "/dist/img/softwares/fleetssl.png",
    };

    // Iterate through each software box and set the image source dynamically
    document.querySelectorAll("#software-grid .software-box").forEach(function (box) {
        const span = box.querySelector("span");
        if (span) {
            const softwareName = span.textContent.trim();
            const img = box.querySelector("img");
            if (img) {
                // Prepend the base URL to the image path or fallback to the default image
                const imagePath = softwareImages[softwareName] ? baseUrl + softwareImages[softwareName] : baseUrl + "/dist/img/logo.webp";
                img.src = imagePath;
                img.alt = softwareName;
            }
        }
    });
});

</script>
@endpush
