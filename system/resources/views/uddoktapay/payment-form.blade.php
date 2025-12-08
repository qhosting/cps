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
        <!-- /.content-header -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-md-6">

                        <div class="info-box">
                            <span class="info-box-icon bg-success"><i class="fas fa-dollar-sign"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Current Balance</span>
                                <span
                                    class="info-box-number">{{ App\Models\Reseller::firstWhere('user_id', Auth::id())->balance }}$</span>
                            </div>
                        </div>
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Recharge</h3>
                            </div>


                            <form id="payment-form" action="{{route('check-payment-method')}}" method="POST">
                                @csrf
                                <div class="card-body">
                                    @error('code')
                                    <div class="alert alert-danger">{{ $message }}</div>
                                    @enderror
                                    <div class="alert alert-danger" id="error-div" style="display: none;"></div>
                                    <div class="form-group">
                                        <label for="name">Name:</label>
                                        <input type="text" class="form-control" name="full_name" id="name"
                                               value="{{ \Auth::user()->username }}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Email:</label>
                                        <input type="text" class="form-control" name="email" id="email"
                                               value="{{ \Auth::user()->email }}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Amount:</label>
                                        <input type="number" class="form-control" name="amount" id="amount"
                                               placeholder="Enter How Much Fund You Want To Add" value="" required>
                                    </div>
                                    <label for="name">Pay with:</label>
                                    <div class="d-flex justify-content-center">
                                        <input type="text" name="payment_method" id="payment-method" value="" hidden="">
                                        <div class="" id="stripe-select" style="margin: 5px; cursor: pointer; width: 220px; height: 60px; display: flex; justify-content: center; align-items: center; border:1px solid #8fbff8; border-radius: 5px;" onclick="setSMethod()">
                                            <img src="{{asset("imgs/stripe2.png")}}" width="100px" class="img-fluid mr-2" alt="">
                                        </div>
                                        
                                        <div class="" id="coinbase-select" style="margin: 5px; cursor: pointer; width: 220px; height: 60px; display: flex; justify-content: center; align-items: center; border:1px solid #8fbff8; border-radius: 5px;" onclick="setCMethod()">
                                            <img src="{{asset("imgs/coinbase.jpg")}}" width="110px" class="img-fluid mt-1" alt="">
                                        </div>
                                    </div>
                                </div>

                                <div class="card-footer">
                                    <button type="submit" class="btn btn-primary" id="submit-btn"
                                            data-dashlane-rid="26dd55dba4d96914" data-dashlane-label="true"
                                            data-form-type="action">Submit</button>
                                </div>
                            </form>
                        </div>

                    </div>
                    @php
                        $addfunds = App\Models\Order::where('email', Auth::id('email'))
                            ->latest()
                            ->GET();
                    @endphp
                    <div class="col-md-6">
                        <div class="card card-warning">
                            <div class="card-header">
                                <h3 class="card-title">Invoices</h3>
                            </div>
                            <div class="card-body bg-white p-4">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Amount</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Receipt</th>
                                        <th scope="col">Generated At</th>
                                        {{-- <th scope="col">Handle</th> --}}
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @forelse ($addfunds as $addfund)
                                        <tr>
                                            <th scope="row">{{ $loop->index + 1 }}</th>
                                            <td>{{ $addfund->amount }}$</td>
                                            <td>{{ $addfund->status }}</td>
                                            <td>
                                                @if(!$addfund->receipt_url == "")
                                                    <a href="{{$addfund->receipt_url}}" target="_blank">Receipt</a>
                                                @else
                                                    No Receipt
                                                @endif
                                            </td>
                                            <td>{{ $addfund->created_at->format('jS F Y') }}</td>

                                        </tr>
                                    @empty
                                        <h3>Nothing Transaction Yet</h3>
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
            function setSMethod(){
                $('#stripe-select').css('border', '1px solid blue');
                $('#uddokt-select').css('border', '1px solid #8fbff8');
                $('#payment-method').val(1);
                $('#submit-btn').removeAttr('onclick');
            }
            function setUMethod(){
                $('#uddokt-select').css('border', '1px solid blue');
                $('#stripe-select').css('border', '1px solid #8fbff8');
                $('#payment-method').val(2);
                $('#submit-btn').removeAttr('onclick');
            }
            function setCMethod(){
                $('#coinbase-select').css('border', '1px solid blue');
                $('#stripe-select').css('border', '1px solid #8fbff8');
                $('#uddokt-select').css('border', '1px solid #8fbff8');
                $('#payment-method').val(3);
                $('#submit-btn').attr('onclick', 'coinbasePay()');
            }

            function coinbasePay(){
                if ($('#amount').val() <= 0) {
                    $('#error-div').text("The amount must be greater than 1").css('display', 'block');
                } else {
                    $('#submit-btn').attr('disabled', '');
                    $.ajax({
                        dataType: 'JSON',
                        url: '{{route('coinbase.pay')}}',
                        type: 'POST',
                        data: {
                            amount: $('#amount').val(),
                            full_name: $('#name').val(),
                            email: $('#email').val(),
                            _token: $("input[name=_token]").val()
                        },
                        success: function (data) {
                            $.ajax({
                                dataType: 'JSON',
                                url: '{{route('coinbase.store')}}',
                                type: 'POST',
                                data: {
                                    transaction_id: data.data.id,
                                    amount: $('#amount').val(),
                                    full_name: $('#name').val(),
                                    email: $('#email').val(),
                                    _token: $("input[name=_token]").val()
                                },
                                success: function (a) {
                                    setTimeout(() => {
                                        window.location.replace(data.data.hosted_url);
                                    }, 1000)
                                },
                                error: function () {
                                    console.log(error);
                                }
                            });
                        },
                        error: function () {

                        }
                    });
                }
            }


            var $form = $("#payment-form");

            $('form#payment-form').bind('submit', function(e) {
                if($('#payment-method').val() === 3){
                    e.preventDefault();
                    coinbasePay();
                } else if($('#payment-method').val() === 1 || $('#payment-method').val() === 2){
                    $('#submit-btn').attr('disabled', '');
                    setTimeout(() => {
                        $form.get(0).submit();
                        }, 2000)
                } else if ($('#payment-method').val() === "") {
                    e.preventDefault();
                    $('#error-div').text("Select payment method").css('display', 'block');
                }
            });
        </script>
    </div>
    <!-- /.content -->
@endsection
@push('script')
@endpush
