<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ResellerCenter - Database Setup</title>
    <link rel="icon" href="/dist/img/logo.webp" sizes="32x32" />
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* Add the same styles from the previous page */
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

        .installer-container {
            width: 100%;
            max-width: 400px;
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
    </style>
</head>

<body>

    <div class="installer-container">
        <img src="/dist/img/logo.webp" class="logo" width="120px" alt="ResellerCenter Logo">
        <h1>Database Setup</h1>
        <p>Version: {{ env('APP_VERSION') }}</p>
        <p>Your database setup is now running.</p>
        <form action="{{ route('install.setup-database.post') }}" method="POST">
            @csrf
            <button type="submit" class="btn btn-primary">Finish Installation</button>
        </form>
    </div>

    <div class="footer">
        <p>Powered by <a href="https://resellercenter.org" target="_blank" style="color: #fff;">ResellerCenter.org</a></p>
    </div>

</body>
</html>
