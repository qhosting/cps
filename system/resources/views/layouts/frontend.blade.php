<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>@yield('title', 'CPS')</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="dist/css/front/animate.min.css" rel="stylesheet">
  <link href="dist/css/front/bootstrap.min.css" rel="stylesheet">
  <link href="dist/css/front/bootstrap-icons.css" rel="stylesheet">
  <link href="dist/css/front/boxicons.min.css" rel="stylesheet">
  <link href="dist/css/front/glightbox.min.css" rel="stylesheet">
  <link href="dist/css/front/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="dist/css/front/style.css" rel="stylesheet">
  <style>
    .pricing-section {
      background-color: #f8f9fa;
      padding: 50px 0;
    }
    .pricing-card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }
    .pricing-card-header {
      background-color: #5cb874;
      color: white;
      padding: 20px 0;
      text-align: center;
    }
    .pricing-card-title {
      font-size: 24px;
    }
    .pricing-card-price {
      font-size: 36px;
      margin-top: 15px;
    }
    .pricing-card-features {
      list-style: none;
      padding: 0;
    }
    .pricing-card-features li {
      padding: 6px 0;
    }
    .pricing-card-button {
      background-color: #5cb874;
      border: none;
      border-radius: 0;
      color: white;
      padding: 10px 0;
      width: 100%;
      transition: background-color 0.3s ease;
    }
    .pricing-card-button:hover {
      background-color: #4b9e68;
    }
	        /* Add your custom CSS styles here */
.product-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.product-box {
    flex: 1;
    min-width: 250px; /* Set a minimum width for each product box */
    max-width: 300px; /* Set a maximum width for each product box */
    border: 1px solid #ccc;
    padding: 20px;
    margin: 10px;
    text-align: center;
    display: flex;
    flex-direction: column;
}

.product-icon {
    font-size: 48px;
    color: #007bff;
    margin-bottom: 10px;
}

.product-title {
    font-weight: bold;
    font-size: 20px;
    margin-bottom: 10px;
}

.product-price {
    font-size: 18px;
    margin-bottom: 10px;
}

.product-description {
    font-size: 14px;
    margin-bottom: 10px;
}

.button-container {
    display: flex;
    justify-content: space-between;
}

.button {
    width: 100%; /* Make buttons fill the width of the product box */
    padding: 10px;
    background-color: #5cb874;
    color: #fff;
    border: none;
    text-align: center;
    text-decoration: none;
    font-size: 16px;
    margin-top: auto; /* Push buttons to the bottom of the product box */
}
.button2 {
    width: 100%; /* Make buttons fill the width of the product box */
    padding: 10px;
    background-color: #198754;
    color: #fff;
    border: none;
    text-align: center;
    text-decoration: none;
    font-size: 16px;
    margin-top: auto; /* Push buttons to the bottom of the product box */
}

.order-button:hover,
.trial-button:hover {
    background-color: #fff;
}

            .getstarted {
        margin-right: 2px; /* Adjust the margin for these links as needed */
    }
 .navbar-nav .nav-item:hover .dropdown-menu {
      display: block;
    }
        
  </style>
<script type="text/javascript" id="f0bf078cb95ab8d8dc81e7706e50badb" src="//chat.magicbyte.pw/script.php?id=f0bf078cb95ab8d8dc81e7706e50badb" defer></script>
	</head>
<body>
    @include('components.frontend-header')
    
    @yield('content')
    
    @include('components.frontend-footer')
    <script>document.write(unescape('%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3C%70%3E%3C%61%20%68%72%65%66%3D%22%68%74%74%70%73%3A%2F%2F%62%65%67%70%6C%2E%63%6F%6D%22%3E%42%65%47%50%4C%2E%63%6F%6D%27%73%20%4E%6F%74%65%3A%3C%2F%61%3E%20%49%66%20%79%6F%75%20%64%69%64%20%6E%6F%74%20%70%75%72%63%68%61%73%65%64%20%66%72%6F%6D%20%75%73%20%74%68%65%20%6C%69%63%65%6E%73%69%6E%67%20%73%79%73%74%65%6D%20%77%69%6C%6C%20%6E%6F%74%20%77%6F%72%6B%20%61%74%20%61%6C%6C%20%65%76%65%6E%20%69%66%20%79%6F%75%20%68%61%76%65%20%73%6F%75%72%63%65%20%63%6F%64%65%20%70%72%6F%76%69%64%65%64%20%62%79%20%74%68%65%20%6C%65%61%63%68%65%72%73%2C%20%74%68%65%20%6F%66%66%69%63%69%61%6C%20%76%65%72%73%69%6F%6E%73%20%6F%66%3C%61%20%68%72%65%66%3D%22%68%74%74%70%73%3A%2F%2F%62%65%67%70%6C%2E%63%6F%6D%2F%70%72%6F%64%75%63%74%2F%73%79%73%6C%69%63%2D%6C%69%63%65%6E%73%69%6E%67%2D%73%79%73%74%65%6D%2D%6F%70%65%6E%2D%73%6F%75%72%63%65%2D%73%75%70%70%6F%72%74%73%2D%63%70%61%6E%65%6C%2D%70%6C%65%73%6B%2D%69%6D%75%6E%69%66%79%33%36%30%2D%61%6E%64%2D%32%30%2D%6D%6F%72%65%2F%22%3E%20%53%79%73%6C%69%63%3C%2F%61%3E%2C%20%3C%61%20%68%72%65%66%3D%22%68%74%74%70%73%3A%2F%2F%62%65%67%70%6C%2E%63%6F%6D%2F%70%72%6F%64%75%63%74%2F%67%62%6C%69%63%65%6E%73%65%2D%6C%69%63%65%6E%73%69%6E%67%2D%73%79%73%74%65%6D%2D%6F%70%65%6E%2D%73%6F%75%72%63%65%2D%73%75%70%70%6F%72%74%73%2D%63%70%61%6E%65%6C%2D%70%6C%65%73%6B%2D%69%6D%75%6E%69%66%79%33%36%30%2D%61%6E%64%2D%32%32%2D%6D%6F%72%65%2F%22%3E%47%42%4C%69%63%65%6E%73%65%20%76%31%35%3C%2F%61%3E%2C%20%61%6E%64%20%3C%61%20%68%72%65%66%3D%22%68%74%74%70%73%3A%2F%2F%62%65%67%70%6C%2E%63%6F%6D%2F%70%72%6F%64%75%63%74%2F%63%70%73%2D%6C%69%63%65%6E%73%69%6E%67%2D%73%79%73%74%65%6D%2D%6F%70%65%6E%2D%73%6F%75%72%63%65%2D%73%75%70%70%6F%72%74%73%2D%63%70%61%6E%65%6C%2D%70%6C%65%73%6B%2D%69%6D%75%6E%69%66%79%33%36%30%2D%61%6E%64%2D%32%30%2D%6D%6F%72%65%2F%22%3E%43%50%53%20%28%53%63%61%6D%29%3C%2F%61%3E%2C%20%61%72%65%20%61%76%61%6C%69%61%62%6C%65%20%61%74%20%42%65%47%50%4C%20%6F%6E%6C%79%2E%20%4F%74%68%65%72%20%70%65%6F%70%6C%65%20%64%6F%20%6E%6F%20%68%61%76%65%20%61%63%63%65%73%73%20%74%6F%20%74%68%65%20%75%70%64%61%74%65%73%20%6F%72%20%74%68%65%79%20%64%6F%6E%19%74%20%68%61%76%65%20%75%70%64%61%74%65%64%20%64%6F%63%75%6D%65%6E%74%61%74%69%6F%6E%2E%20%57%65%20%70%72%6F%76%69%64%65%20%66%72%65%65%20%77%65%65%6B%6C%79%20%75%70%64%61%74%65%73%20%6F%6E%20%74%68%65%20%73%6F%75%72%63%65%20%63%6F%64%65%20%61%6E%64%20%64%6F%63%75%6D%65%6E%74%61%74%69%6F%6E%2E%3C%2F%70%3E%0A'))</script>

</body>
</html>
