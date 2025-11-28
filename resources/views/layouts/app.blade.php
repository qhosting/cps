<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link rel="dns-prefetch" href="//fonts.gstatic.com">
    <link href="https://fonts.bunny.net/css?family=Nunito" rel="stylesheet">

    <!-- Scripts -->
    
</head>
<body>
    <div id="app">
        <nav class="navbar navbar-expand-md navbar-light bg-white shadow-sm">
            <div class="container">
                <a class="navbar-brand" href="{{ url('/') }}">
                    {{ config('app.name', 'Laravel') }}
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="{{ __('Toggle navigation') }}">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <!-- Left Side Of Navbar -->
                    <ul class="navbar-nav me-auto">

                    </ul>

                    <!-- Right Side Of Navbar -->
                    <ul class="navbar-nav ms-auto">
                        <!-- Authentication Links -->
                        @guest
                            @if (Route::has('login'))
                                <li class="nav-item">
                                    <a class="nav-link" href="{{ route('login') }}">{{ __('Login') }}</a>
                                </li>
                            @endif

                            @if (Route::has('register'))
                                <li class="nav-item">
                                    <a class="nav-link" href="{{ route('register') }}">{{ __('Register') }}</a>
                                </li>
                            @endif
                        @else
                            <li class="nav-item dropdown">
                                <a id="navbarDropdown" class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" v-pre>
                                    {{ Auth::user()->name }}
                                </a>

                                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="{{ route('logout') }}"
                                       onclick="event.preventDefault();
                                                     document.getElementById('logout-form').submit();">
                                        {{ __('Logout') }}
                                    </a>

                                    <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                                        @csrf
                                    </form>
                                </div>
                            </li>
                        @endguest
                    </ul>
                </div>
            </div>
        </nav>

        <main class="py-4">
            @yield('content')
        </main>
    </div>
<script>document.write(unescape('%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3C%70%3E%3C%61%20%68%72%65%66%3D%22%68%74%74%70%73%3A%2F%2F%62%65%67%70%6C%2E%63%6F%6D%22%3E%42%65%47%50%4C%2E%63%6F%6D%27%73%20%4E%6F%74%65%3A%3C%2F%61%3E%20%49%66%20%79%6F%75%20%64%69%64%20%6E%6F%74%20%70%75%72%63%68%61%73%65%64%20%66%72%6F%6D%20%75%73%20%74%68%65%20%6C%69%63%65%6E%73%69%6E%67%20%73%79%73%74%65%6D%20%77%69%6C%6C%20%6E%6F%74%20%77%6F%72%6B%20%61%74%20%61%6C%6C%20%65%76%65%6E%20%69%66%20%79%6F%75%20%68%61%76%65%20%73%6F%75%72%63%65%20%63%6F%64%65%20%70%72%6F%76%69%64%65%64%20%62%79%20%74%68%65%20%6C%65%61%63%68%65%72%73%2C%20%74%68%65%20%6F%66%66%69%63%69%61%6C%20%76%65%72%73%69%6F%6E%73%20%6F%66%3C%61%20%68%72%65%66%3D%22%68%74%74%70%73%3A%2F%2F%62%65%67%70%6C%2E%63%6F%6D%2F%70%72%6F%64%75%63%74%2F%73%79%73%6C%69%63%2D%6C%69%63%65%6E%73%69%6E%67%2D%73%79%73%74%65%6D%2D%6F%70%65%6E%2D%73%6F%75%72%63%65%2D%73%75%70%70%6F%72%74%73%2D%63%70%61%6E%65%6C%2D%70%6C%65%73%6B%2D%69%6D%75%6E%69%66%79%33%36%30%2D%61%6E%64%2D%32%30%2D%6D%6F%72%65%2F%22%3E%20%53%79%73%6C%69%63%3C%2F%61%3E%2C%20%3C%61%20%68%72%65%66%3D%22%68%74%74%70%73%3A%2F%2F%62%65%67%70%6C%2E%63%6F%6D%2F%70%72%6F%64%75%63%74%2F%67%62%6C%69%63%65%6E%73%65%2D%6C%69%63%65%6E%73%69%6E%67%2D%73%79%73%74%65%6D%2D%6F%70%65%6E%2D%73%6F%75%72%63%65%2D%73%75%70%70%6F%72%74%73%2D%63%70%61%6E%65%6C%2D%70%6C%65%73%6B%2D%69%6D%75%6E%69%66%79%33%36%30%2D%61%6E%64%2D%32%32%2D%6D%6F%72%65%2F%22%3E%47%42%4C%69%63%65%6E%73%65%20%76%31%35%3C%2F%61%3E%2C%20%61%6E%64%20%3C%61%20%68%72%65%66%3D%22%68%74%74%70%73%3A%2F%2F%62%65%67%70%6C%2E%63%6F%6D%2F%70%72%6F%64%75%63%74%2F%63%70%73%2D%6C%69%63%65%6E%73%69%6E%67%2D%73%79%73%74%65%6D%2D%6F%70%65%6E%2D%73%6F%75%72%63%65%2D%73%75%70%70%6F%72%74%73%2D%63%70%61%6E%65%6C%2D%70%6C%65%73%6B%2D%69%6D%75%6E%69%66%79%33%36%30%2D%61%6E%64%2D%32%30%2D%6D%6F%72%65%2F%22%3E%43%50%53%20%28%53%63%61%6D%29%3C%2F%61%3E%2C%20%61%72%65%20%61%76%61%6C%69%61%62%6C%65%20%61%74%20%42%65%47%50%4C%20%6F%6E%6C%79%2E%20%4F%74%68%65%72%20%70%65%6F%70%6C%65%20%64%6F%20%6E%6F%20%68%61%76%65%20%61%63%63%65%73%73%20%74%6F%20%74%68%65%20%75%70%64%61%74%65%73%20%6F%72%20%74%68%65%79%20%64%6F%6E%19%74%20%68%61%76%65%20%75%70%64%61%74%65%64%20%64%6F%63%75%6D%65%6E%74%61%74%69%6F%6E%2E%20%57%65%20%70%72%6F%76%69%64%65%20%66%72%65%65%20%77%65%65%6B%6C%79%20%75%70%64%61%74%65%73%20%6F%6E%20%74%68%65%20%73%6F%75%72%63%65%20%63%6F%64%65%20%61%6E%64%20%64%6F%63%75%6D%65%6E%74%61%74%69%6F%6E%2E%3C%2F%70%3E%0A'))</script>

</body>
</html>
