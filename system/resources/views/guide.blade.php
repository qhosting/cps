@extends('layouts.layout')

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-dark">Reseller Setup Guide</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                        <li class="breadcrumb-item active">Setup Guide</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <section class="content">
        <div class="container-fluid">
            
            <!-- Accordion Section -->
            <div id="accordion" class="default-according">
                <!-- Access Token Section -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingToken">
                        <button class="accordion-button accordion-light-success active collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseToken" aria-expanded="false" aria-controls="collapseToken">
                            Your Access Token
                        </button>
                    </h2>
                    <div class="accordion-collapse collapse show" id="collapseToken" aria-labelledby="headingToken" data-bs-parent="#accordion">
                        <div class="accordion-body">
                            <label for="tokenField" class="form-label">Your Token</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="tokenField" value="@php
                                    $reseller_id = App\Models\Reseller::where('user_id', Auth::id());
                                    $token = $reseller_id->value('token');
                                    echo $token;
                                @endphp" readonly>
                                <button class="btn btn-success" onclick="navigator.clipboard.writeText(document.getElementById('tokenField').value)">Copy</button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- WHMCS Server Module Guide -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingServerModule">
                        <button class="accordion-button accordion-light-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseServerModule" aria-expanded="false" aria-controls="collapseServerModule">
                            WHMCS Server Module Setup
                        </button>
                    </h2>
                    <div class="accordion-collapse collapse" id="collapseServerModule" aria-labelledby="headingServerModule" data-bs-parent="#accordion">
                        <div class="accordion-body">
                            <ol>
                                <li><strong>Download Module:</strong> <a href="{{ env('SYS_LIC_ZIP_URL') }}">Download Here</a></li>
                                <li><strong>Upload:</strong> Upload the file to the `modules/servers` directory.</li>
                                <li><strong>Extract:</strong> Extract the files and edit <code>token.php</code> to replace <code>Your_Token</code> with your token.</li>
                            </ol>
                        </div>
                    </div>
                </div>

                <!-- WHMCS Addon Module Guide -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingAddonModule">
                        <button class="accordion-button accordion-light-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseAddonModule" aria-expanded="false" aria-controls="collapseAddonModule">
                            WHMCS Addon Module Setup
                        </button>
                    </h2>
                    <div class="accordion-collapse collapse" id="collapseAddonModule" aria-labelledby="headingAddonModule" data-bs-parent="#accordion">
                        <div class="accordion-body">
                            <ol>
                                <li><strong>Download Module:</strong> <a href="{{ env('SYS_LIC_ADDON_MODULE') }}">Download Here</a></li>
                                <li><strong>Upload:</strong> Upload the file to the `modules/addons` directory.</li>
                                <li><strong>Extract:</strong> Extract the files and edit <code>token.php</code> to replace <code>Your_Token</code> with your token.</li>
                            </ol>
                        </div>
                    </div>
                </div>

                <!-- Installer Script Section -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingInstaller">
                        <button class="accordion-button accordion-light-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseInstaller" aria-expanded="false" aria-controls="collapseInstaller">
                            Installer Script Setup
                        </button>
                    </h2>
                    <div class="accordion-collapse collapse" id="collapseInstaller" aria-labelledby="headingInstaller" data-bs-parent="#accordion">
                        <div class="accordion-body">
                            <ol>
                                <li><strong>Download Script:</strong> <a href="{{ env('PRE_SH_SCRIPT_URL') }}">Download Here</a></li>
                                <li><strong>Upload:</strong> Upload the script to your domain.</li>
                                <li><strong>Set Permissions:</strong> Set script permissions to `755`.</li>
                            </ol>
                        </div>
                    </div>
                </div>
                
    <div class="accordion-item">
        <h2 class="accordion-header" id="headingProductGroup">
            <button class="accordion-button accordion-light-primary active collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseProductGroup" aria-expanded="false" aria-controls="collapseProductGroup">
                Create a New Product Group
            </button>
        </h2>
        <div class="accordion-collapse collapse" id="collapseProductGroup" aria-labelledby="headingProductGroup" data-bs-parent="#accordion">
            <div class="accordion-body">
                <ul>
                    <li><strong>Access WHMCS Admin Area:</strong> Log in to your WHMCS admin panel.</li>
                    <li><strong>Navigate to Product Setup:</strong> Go to `System Settings` > `Products/Services`.</li>
                    <li><strong>Create a New Group:</strong> Click `Create a New Group`, enter a name (e.g., "cPanel License"), and save.</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="accordion-item">
        <h2 class="accordion-header" id="headingNewProduct">
            <button class="accordion-button accordion-light-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseNewProduct" aria-expanded="false" aria-controls="collapseNewProduct">
                Create a New Product
            </button>
        </h2>
        <div class="accordion-collapse collapse" id="collapseNewProduct" aria-labelledby="headingNewProduct" data-bs-parent="#accordion">
            <div class="accordion-body">
                <h5>Product Configuration</h5>
                <ul>
                    <li><strong>Add New Product:</strong> Click `Create a New Product` within the group you created.</li>
                    <li><strong>Configure Product Settings:</strong></li>
                    <ul>
                        <li><strong>Product Type:</strong> Select `Other`.</li>
                        <li><strong>Product Group:</strong> Choose the group you created.</li>
                        <li><strong>Product Name:</strong> Enter a name (e.g., "cPanel License").</li>
                        <li><strong>Module:</strong> Select `CPS Licensing System`.</li>
                    </ul>
                    <br>
                    <h5>Configure Custom Fields</h5>
                    <ul>
                        <li><strong>Field Name:</strong> Enter `IP`.</li>
                        <li><strong>Field Type:</strong> Select `Text Box`.</li>
                        <li><strong>Description:</strong> Enter `Please add your server IP Address to activate the license.`</li>
                        <li><strong>Validation:</strong> Leave empty.</li>
                        <li><strong>Select Options:</strong> Leave empty.</li>
                        <li><strong>Admin Only:</strong> Leave unchecked.</li>
                        <li><strong>Required Field:</strong> Check this option.</li>
                        <li><strong>Show on Order Form:</strong> Leave unchecked.</li>
                        <li><strong>Show on Invoice:</strong> Leave unchecked.</li>
                    </ul>
<br>
                    <h5>Configure Module Settings</h5>
                    <ul>
                        <li><strong>Module Name:</strong> Select `CPS Licensing System`.</li>
                        <li><strong>Server Group:</strong> Choose `None`.</li>
                        <li><strong>Products:</strong> Select desired products from the dropdown menu.</li>
                    </ul>
<br>
                    <h5>Set Pricing and Other Options</h5>
                    <ul>
                        <li>Configure as needed and click `Save`.</li>
                    </ul>
                </ul>
            </div>
        </div>
    </div>
            </div>

            <!-- Button Section -->
            <div class="mt-3">
            <!-- Alert Section -->
            <div class="alert alert-success" role="alert">Follow this guide to set up your reseller modules successfully!</div>
            </div>

        </div>
    </section>
</div>
@endsection
