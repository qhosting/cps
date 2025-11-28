<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $site_name->value ?? 'CPS' }} - Login</title>
    <link rel="shortcut icon" type="image/x-icon" href="{{ asset('dist/img/rc.png') }}">

    <!-- Bootstrap CSS -->

    <!-- Font Awesome -->

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet"> @vite(['public/assets/scss/apps.scss'])
    <!-- Custom CSS -->

    <!-- reCAPTCHA -->
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <style>
        body {
            font-family: 'Space Grotesk', sans-serif;
        }
            
               .btn-primary {
            background-color: #2f2f3b !important;
            border-color: var(--theme-deafult) !important;
        }
    </style>
</head>

<body>

    <div class="container-fluid p-0">
        <div class="row m-0">
            <div class="col-12 p-0">
                <div class="login-card">
                    <div>
                        
                        <p style="display:none;">Powered by CPS</p>
                        <div class="login-main">
                            <h4>Reseller panel login</h4>
                            <!-- Display success message if exists -->
                            @if(session('success'))
                            <div class="alert alert-success">
                                {{ session('success') }}
                            </div>
                            @endif

                            <!-- Display error message if exists -->
                            @if(session('error'))
                            <div class="alert alert-danger">
                                {{ session('error') }}
                            </div>
                            @endif

                            <form method="POST" action="{{ route('login.token') }}" class="theme-form">
                                @csrf
                                <div class="form-group">
                                    <label for="token" class="col-form-label mb-4">Your Reseller Token :</label>
                                    <input type="text" class="form-control" name="token" id="token" required>
                                </div>
                        </div>
                        <br>
                        <br>

                        <div class="text-center" bis_skin_checked="1">
                            <button type="submit" class="btn btn-primary btn-block enter-btn">Login</button>

                            <a href="{{ url('/panel/register') }}" style="margin-left: 20px;" class="btn btn-primary btn-block enter-btn" bis_skin_checked="1">Become a Reseller</a>

                            <br>
                            <br>

                            <a class="btn btn-primary btn-block enter-btn" href="{{ url('/panel/login') }}" style="margin-left: 20px; font-weight:bold" bis_skin_checked="1">Login Using Password</a>

                        </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script src="{{asset('assets/js/jquery-3.5.1.min.js')}}"></script>
    <!-- Bootstrap js-->
    <script src="{{asset('assets/js/bootstrap/bootstrap.bundle.min.js')}}"></script>
    <!-- feather icon js-->
    <script src="{{asset('assets/js/icons/feather-icon/feather.min.js')}}"></script>
    <script src="{{asset('assets/js/icons/feather-icon/feather-icon.js')}}"></script>
    <!-- scrollbar js-->
    <!-- Sidebar jquery-->
    <script src="{{asset('assets/js/config.js')}}"></script>
    <!-- Plugins JS start-->
    @yield('script')
    <!-- Plugins JS Ends-->
    <!-- Theme js-->
    <script src="{{asset('assets/js/script.js')}}"></script>
    <!-- Plugin used-->
</body>

</html>