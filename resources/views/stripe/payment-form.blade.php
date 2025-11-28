@extends('layouts.layout')

@section('content')
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Recharge</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">Recharge</li>
                        </ol>
                        
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
            <style>
#card-element {
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 10px;
}
.error {
    color: red;
}
.amount-buttons {
    margin-top: 10px;
}
.amount-buttons button {
    margin-right: 5px;
}

    </style>

        <!-- /.content-header -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-md-6">

         <div class="card widget-1">
            <div class="card-body">
               <div class="widget-content">
                  <div class="widget-round success">
                     <div class="bg-round">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-dollar-sign">
                           <line x1="12" y1="1" x2="12" y2="23"></line>
                           <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                        </svg>
                     </div>
                  </div>
                  <div>
                     <h4>{{ App\Models\Reseller::firstWhere('user_id', Auth::id())->balance }}$</h4>
                     <span class="f-light">Current Balance</span>
                  </div>
               </div>
            </div>
         </div>
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Recharge</h3>
                            </div>
    <div class="container p-3">
        <form id="payment-form" action="{{ route('stripe.pay') }}" method="POST">
            @csrf
            <div class="form-group">
                <label for="full_name">Full Name:</label>
                <input type="text" class="form-control" name="full_name" id="name" value="{{ \Auth::user()->username }}" readonly>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" class="form-control" name="email" id="email" value="{{ \Auth::user()->email }}" readonly>
            </div>
        <div class="form-group">
            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" class="form-control"  required>
        </div>
        <div class="amount-buttons" style="margin-bottom:25px;">
            <button type="button" class="btn btn-success" onclick="setAmount(50)">50$</button>
            <button type="button" class="btn btn-success" onclick="setAmount(100)">100$</button>
            <button type="button" class="btn btn-success" onclick="setAmount(500)">500$</button>
            <button type="button" class="btn btn-success" onclick="setAmount(1000)">1000$</button>
            <button type="button" class="btn btn-success" onclick="setAmount(2500)">2500$</button>
            <button type="button" class="btn btn-success" onclick="setAmount(5000)">5000$</button>
        </div>
            <div class="form-group">
                <label for="card-element">Credit or debit card:</label>
                <div id="card-element">
                    <!-- A Stripe Element will be inserted here. -->
                </div>
                <div id="card-errors" role="alert" class="text-danger mt-2"></div>
            </div>
            <button type="submit" class="btn btn-primary">Submit Payment</button>
        </form>
    </div>
                        </div>

                    </div>
                    @php
                        $addfunds = App\Models\Order::where('email', Auth::id('email'))
                            ->latest()
                            ->GET();
                    @endphp
                    <div class="col-md-6">
                        
                        
                        
                                 <div class="card widget-1">
            <div class="card-body">
               <div class="widget-content">
                  <div class="widget-round success">
                     <div class="bg-round">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-dollar-sign">
                           <line x1="12" y1="1" x2="12" y2="23"></line>
                           <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                        </svg>
                     </div>
                  </div>
                  <div>
                     <h4><?php 
// Get the current authenticated user
$user = Auth::user();

// Retrieve the Reseller associated with the authenticated user
$reseller = \App\Reseller::where('user_id', $user->id)->first();

// Default plan if no level is assigned
$plan = 'default';

// Check if the Reseller has a valid level_id
if ($reseller && $reseller->level_id) {
    // Retrieve the associated LevelReseller
    $level = \App\LevelReseller::find($reseller->level_id);

    // If a LevelReseller is found, use its title as the plan
    if ($level) {
        $plan = $level->title;
    }
}

// Print the plan (level) of the current user
echo ucfirst($plan); // Capitalize the first letter of the plan

?></h4>
                     <span class="f-light">Current Level</span>
                  </div>
               </div>
            </div>
         </div>


                        <div class="card card-warning">
                            <div class="card-header">
                                <h3 class="card-title">Transactions</h3>
                            </div>
                            <div class="card-body bg-white p-4">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Amount</th>
                                        <th scope="col">Paid On</th>
                                        <th scope="col">Status</th>
                                        {{-- <th scope="col">Handle</th> --}}
                                    </tr>
                                    </thead>
                                    @php
    $userEmail = Auth::user()->email;
    $addfunds = App\Models\Order::where('email', $userEmail)
        ->latest()
        ->get();
@endphp

<tbody>
@forelse ($addfunds as $addfund)
    <tr>
        <th scope="row">{{ $loop->index + 1 }}</th>
        <td>{{ $addfund->amount }}$</td>
        <td>{{ $addfund->created_at->format('jS F Y') }}</td>
        <td>{{ $addfund->status }}</td>
    </tr>
@empty
    <tr>
        <td colspan="5">No Transaction Yet</td>
    </tr>
@endforelse
</tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>
<script>
    function setAmount(amount) {
    document.getElementById('amount').value = amount;
}

</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize Stripe.js
        var stripe = Stripe('{{ $stripePublicKey }}'); // Use the public key passed from the controller

        // Create an instance of Elements
        var elements = stripe.elements();

        // Create an instance of the card Element
        var card = elements.create('card');

        // Add an instance of the card Element into the `card-element` div
        card.mount('#card-element');

        // Handle real-time validation errors from the card Element
        card.addEventListener('change', function(event) {
            var displayError = document.getElementById('card-errors');
            if (event.error) {
                displayError.textContent = event.error.message;
            } else {
                displayError.textContent = '';
            }
        });

        // Handle form submission
        var form = document.getElementById('payment-form');
        form.addEventListener('submit', function(event) {
            event.preventDefault();

            // Create a token or display an error
            stripe.createToken(card).then(function(result) {
                if (result.error) {
                    // Inform the user if there was an error
                    var errorElement = document.getElementById('card-errors');
                    errorElement.textContent = result.error.message;
                } else {
                    // Send the token to your server
                    stripeTokenHandler(result.token);
                }
            });
        });

        // Submit the form with the token ID
        function stripeTokenHandler(token) {
            var form = document.getElementById('payment-form');
            // Insert the token ID into the form so it gets submitted to the server
            var hiddenInput = document.createElement('input');
            hiddenInput.setAttribute('type', 'hidden');
            hiddenInput.setAttribute('name', 'stripeToken');
            hiddenInput.setAttribute('value', token.id);
            form.appendChild(hiddenInput);

            // Submit the form
            form.submit();
        }
    });
</script>
    <script src="https://js.stripe.com/v3/"></script>

</div>
    <!-- /.content -->
@endsection
@push('script')
@endpush
