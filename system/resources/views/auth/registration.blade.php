<!DOCTYPE html>
<html lang="en">
 
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>{{ $site_name->value ?? 'CPS' }} - Sign Up</title>
      <link rel="shortcut icon" type="image/x-icon" href="{{ asset('dist/img/rc.png') }}">
      <!-- Bootstrap CSS -->
      <!-- Google Fonts -->
      <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
      @vite(['public/assets/scss/apps.scss'])
      <!-- Custom CSS -->
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
                     <h4>Reseller Panel Registration</h4>
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
                     <form method="POST" action="{{ route('register.custom') }}" class="theme-form">
                        @csrf
                        <div class="form-group">
                           <label for="username" class="col-form-label">Full Name</label>
                           <input type="text" class="form-control" name="username" id="username" placeholder="Enter your full name" required>
                        </div>
                        <div class="form-group">
                           <label for="brand_name" class="col-form-label">Brand Name</label>
                           <input type="text" class="form-control" name="brand_name" id="brand_name" placeholder="Enter your brand name" required>
                        </div>
                        <div class="form-group">
                           <label for="email" class="col-form-label">Email Address</label>
                           <input type="email" class="form-control" name="email" id="email" placeholder="Enter a valid email address" required>
                        </div>
                        <div class="form-group">
                           <label for="password" class="col-form-label">Password</label>
                           <input type="password" class="form-control" name="password" id="password" placeholder="Enter your password" required>
                        </div>
                        <div class="form-group">
                           <label for="password_confirmation" class="col-form-label">Confirm Password</label>
                           <input type="password" class="form-control" name="password_confirmation" id="password_confirmation" placeholder="Confirm your password" required>
                        </div>
                        <div class="text-center" bis_skin_checked="1">
                           <button type="submit" class="btn btn-primary btn-block enter-btn">Sign Up</button>
                           <p class="small fw-bold mt-2 pt-1 mb-0">
                              Already have an account? 
                              <a href="{{ url('/login') }}" class="link-danger"><b>Sign In</b></a>
                           </p>
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