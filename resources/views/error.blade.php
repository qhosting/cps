<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>License Error</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- FontAwesome for icons -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }

        .error-box {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 400px;
            text-align: center;
        }

        .error-box h1 {
            font-size: 36px;
            margin-bottom: 20px;
            color: #ff0000;
        }

        .error-box p {
            font-size: 16px;
            margin-bottom: 30px;
        }

        .error-box .error-icon {
            font-size: 50px;
            color: #ff0000;
            margin-bottom: 20px;
        }

        .btn {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="error-box">
            <div class="error-icon">
                <i class="fas fa-exclamation-circle"></i>
            </div>
            <h1>License Error</h1>
            <!-- Check if a session message exists -->
            @if (session('message'))
                <p>{{ $message }} </p>

            @else
            
                <p>Please contact License provider for assistance.</p>
                <h2 style="color: #FF9800;">License is not valid.</h2>
            @endif
            <a href="{{ url('/') }}" class="btn">Go to Home</a>
        </div>
    </div>
<?php 
                session()->flush(); // Clears all session data

?>
</body>
</html>
