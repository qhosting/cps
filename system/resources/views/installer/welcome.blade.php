<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ResellerCenter - Installer</title>
    <link rel="icon" href="/dist/img/logo.webp" sizes="32x32" />

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* Custom CSS */
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #323232, #5f5f60, #040404);
            background-size: 300% 300%;
            animation: gradientBG 6s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        h1 {
            font-size: 37px;
            font-weight: 700;
            text-transform: uppercase;
            color: #373737;
            text-align: center;
            background: linear-gradient(45deg, #00bcd4, #007bff, #4caf50);
            background-clip: text;
            -webkit-background-clip: text;
            margin: 0;
            letter-spacing: 3px;
        }

        .installer-container {
            width: 100%;
            max-width: 600px;
            text-align: center;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .logo {
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #000000;
            border: none;
            padding: 15px 20px;
            width: 100%;
            border-radius: 8px;
            color: white;
            font-weight: 600;
        }

        .btn-primary:hover {
            background-color: #ffc107;
        }

        .footer {
            margin-top: 30px;
            color: #fff;
            font-size: 14px;
            position: absolute;
            bottom: 0px;
        }

        .requirements-list {
            text-align: left;
            margin-top: 30px;
        }

        .requirements-list li {
            font-size: 16px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .requirements-list li .status-icon {
            margin-right: 10px;
            font-size: 20px;
        }

        .requirements-list .met {
            color: #2a9d8f;
        }

        .requirements-list .missing {
            color: #e76f51;
        }

        .server-info {
            margin-top: 20px;
            font-size: 16px;
            padding-left: 20px;
        }
             ul {
            margin-left: 0px;
            padding-left: 0px;
        }
dl, o
    </style>
</head>

<body>

    <div class="installer-container">
        <img src="/dist/img/logo.webp" class="logo" width="120px" alt="ResellerCenter Logo">
        
        <h1>ResellerCenter Installation</h1>
        <p>Follow the steps to install ResellerCenter on your system.</p>
        <div class="server-info">
            <h4>Server Information:</h4>
            <p><strong>PHP Version:</strong> {{ phpversion() }}</p>
            <p><strong>Server Software:</strong> {{ $_SERVER['SERVER_SOFTWARE'] }}</p>
        </div>

        <a href="{{ route('install.database-license') }}">
            <button class="btn btn-primary">Start Installation</button>
        </a>

        <div class="requirements-list">
            <h3>Server Requirements</h3>
            <ul>
                <li>
                    <span class="status-icon {{ version_compare(PHP_VERSION, '7.4', '>=') ? 'met' : 'missing' }}">
                        <i class="fa {{ version_compare(PHP_VERSION, '7.4', '>=') ? 'fa-check-circle' : 'fa-times-circle' }}"></i>
                    </span>
                    <span>PHP Version: {{ phpversion() }}</span>
                </li>
                <li>
                    <span class="status-icon {{ extension_loaded('ionCube Loader') ? 'met' : 'missing' }}">
                        <i class="fa {{ extension_loaded('ionCube Loader') ? 'fa-check-circle' : 'fa-times-circle' }}"></i>
                    </span>
                    <span>IonCube Loader: 
                        @if(extension_loaded('ionCube Loader')) Installed @else Not Installed @endif
                    </span>
                </li>
                <li>
                    <span class="status-icon {{ extension_loaded('mysqli') ? 'met' : 'missing' }}">
                        <i class="fa {{ extension_loaded('mysqli') ? 'fa-check-circle' : 'fa-times-circle' }}"></i>
                    </span>
                    <span>MySQL: 
                        @if(extension_loaded('mysqli')) Installed @else Not Installed @endif
                    </span>
                </li>
                <li>
                    <span class="status-icon {{ extension_loaded('openssl') ? 'met' : 'missing' }}">
                        <i class="fa {{ extension_loaded('openssl') ? 'fa-check-circle' : 'fa-times-circle' }}"></i>
                    </span>
                    <span>OpenSSL: 
                        @if(extension_loaded('openssl')) Installed @else Not Installed @endif
                    </span>
                </li>
                <li>
                    <span class="status-icon {{ extension_loaded('mbstring') ? 'met' : 'missing' }}">
                        <i class="fa {{ extension_loaded('mbstring') ? 'fa-check-circle' : 'fa-times-circle' }}"></i>
                    </span>
                    <span>MBstring: 
                        @if(extension_loaded('mbstring')) Installed @else Not Installed @endif
                    </span>
                </li>
                <li>
                    <span class="status-icon {{ extension_loaded('gd') ? 'met' : 'missing' }}">
                        <i class="fa {{ extension_loaded('gd') ? 'fa-check-circle' : 'fa-times-circle' }}"></i>
                    </span>
                    <span>GD Library: 
                        @if(extension_loaded('gd')) Installed @else Not Installed @endif
                    </span>
                </li>
            </ul>
        </div>


    </div>

    <div class="footer">
        <p>Powered by <a href="https://resellercenter.org" target="_blank" style="color: #fff;">ResellerCenter.org</a></p>
    </div>

</body>
</html>
