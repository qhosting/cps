<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ResellerCenter - Database & License Configuration</title>
    <link rel="icon" href="/dist/img/logo.webp" sizes="32x32" />
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* Custom Styling */
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #323232, #5f5f60, #040404);
            background-size: 300% 300%;
            animation: gradientBG 6s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
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

        h1 {
            font-size: 28px;
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

        p {
            font-size: 16px;
            color: #555;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #ccc;
            padding: 12px 15px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: #00bcd4;
            box-shadow: 0 0 5px rgba(0, 188, 212, 0.5);
        }

        .form-control-icon {
            position: absolute;
            right: 15px;
            top: 43px;
            color: #bbb;
            pointer-events: none;
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

        .footer p {
            color: #fff;
        }
        .footer a {
            color: #fff;
        }
    </style>
</head>

<body>
    <div class="installer-container">
        <img src="/dist/img/logo.webp" class="logo" width="120px" alt="ResellerCenter Logo">
        <h1>Database & License Configuration</h1>
        <p>Version: {{ env('APP_VERSION') }}</p>
        <p>For manual import download database file.</p>
        <a href="/dist/db/database.sql"><button type="submit" class="btn btn-primary">Download Database.sql</button></a><br><br>
            
        <form action="{{ route('install.database-license.post') }}" method="POST">
            @csrf
            <div class="form-group position-relative">
                <label for="license_key">License Key</label>
                <input type="text" class="form-control" name="license_key" id="license_key" value="license_67677d7090252" required>
                <i class="fa fa-key form-control-icon"></i>
            </div>
            <div class="form-group position-relative">
                <label for="database_host">Database Host</label>
                <input type="text" class="form-control" name="database_host" id="database_host" value="localhost" required>
                <i class="fa fa-server form-control-icon"></i>
            </div>
            <div class="form-group position-relative">
                <label for="database_name">Database Name</label>
                <input type="text" class="form-control" name="database_name" id="database_name" value="resellercenter_db"  required>
                <i class="fa fa-database form-control-icon"></i>
            </div>
            <div class="form-group position-relative">
                <label for="database_user">Database User</label>
                <input type="text" class="form-control" name="database_user" id="database_user" value="resellercenter_user"  required>
                <i class="fa fa-user form-control-icon"></i>
            </div>
            <div class="form-group position-relative">
                <label for="database_password">Database Password</label>
                <input type="password" class="form-control" name="database_password" id="database_password" value="Ali@1.com"  required>
                <i class="fa fa-lock form-control-icon"></i>
            </div>
            <button type="submit" class="btn btn-primary">Next</button>
        </form>
    </div>


</body>
</html>
