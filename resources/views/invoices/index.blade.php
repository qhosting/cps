@extends('layouts.layout')

@section('content')
    <div class="content-wrapper">
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">All Transactions</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">All Transactions</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Transaction List</h3>
                            </div>
                            <div class="card-body">

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
        // Fetch the current logged-in user's role and email
        $currentUser = Auth::user();
        $userRole = $currentUser->role;
        $userEmail = $currentUser->email;

        // Fetch orders based on user role
        if ($userRole === 'admin') {
            // If user is an admin, fetch all orders
            $addfunds = App\Models\Order::latest()->get();
        } else {
            // If user is not an admin, fetch only their orders
            $addfunds = App\Models\Order::where('email', $userEmail)
                ->latest()
                ->get();
        }
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
                <td colspan="5">No Transactions Yet</td>
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
    </div>
@endsection
