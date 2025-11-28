<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register License</title>
</head>
<body>
    <form action="{{ route('rc.registerLicense') }}" method="POST">
        @csrf
        <label for="ip_address">IP Address:</label>
        <input type="text" id="ip_address" name="ip_address" required>
        <br>
        <label for="software">Software:</label>
        <input type="text" id="software" name="software" required>
        <br>
        <button type="submit">Register License</button>
    </form>
</body>
</html>
