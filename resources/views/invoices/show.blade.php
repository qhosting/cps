@extends('layouts.layout')
@section('content')
<style>
    body {
        background: #eee;
        margin-top: 20px;
    }
    .text-danger strong {
        color: #0069d9;
    }
    .receipt-main {
        background: #ffffff;
        border-bottom: 12px solid #333333;
        border-top: 12px solid #0069d9;
        margin-top: 50px;
        margin-bottom: 50px;
        padding: 40px 30px;
        position: relative;
        box-shadow: 0 1px 21px #acacac;
        color: #333333;
        font-family: 'Open Sans', sans-serif;
        text-align: center;
    }
    .receipt-main p {
        color: #333333;
        line-height: 1.42857;
    }
    .receipt-footer h1 {
        font-size: 15px;
        font-weight: 400 !important;
        margin: 0 !important;
    }
    .receipt-main::after {
        background: #414143;
        content: "";
        height: 5px;
        left: 0;
        position: absolute;
        right: 0;
        top: -13px;
    }
    .receipt-main thead {
        background: #414143;
    }
    .receipt-main thead th {
        color: #fff;
    }
    .receipt-right h5,
    .receipt-header-mid .receipt-left h1 {
        font-size: 16px;
        font-weight: bold;
        margin: 0 0 7px 0;
    }
    .receipt-right p,
    .receipt-right p i {
        font-size: 12px;
        margin: 0;
    }
    .receipt-main td,
    .receipt-main th {
        padding: 9px 20px;
        font-size: 13px;
        font-weight: initial;
    }
    .receipt-main td p:last-child {
        margin: 0;
        padding: 0;
    }
    .receipt-main td h2 {
        font-size: 20px;
        font-weight: 900;
        margin: 0;
        text-transform: uppercase;
    }
    .receipt-header-mid {
        margin: 24px 0;
        overflow: hidden;
    }
    #container {
        background-color: #dcdcdc;
    }
    .receipt-left {
        float: none;
        margin: 0 auto;
        text-align: left;
    }
    .receipt-right {
        float: none;
        margin: 0 auto;
        text-align: right;
    }
    .receipt-center {
        text-align: center;
    }
    .clearfix::after {
        content: "";
        display: table;
        clear: both;
    }
</style>
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-dark">Invoices</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                        <li class="breadcrumb-item active">Invoices</li>
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
                            <h3 class="card-title">Invoice Details</h3>
                        </div>
                        <div class="card-body mx-4">
                            <div class="col-md-12">
                                <div class="row receipt-main">
                                    <div class="col-md-12">
                                        <div class="row receipt-header">
                                            <div class="col-md-6 receipt-left">
                                                <h5><b>resellercenter.org</b></h5>
                                                <p class="mb-0">What's App: +1(267) 227-0548 </i></p>
                                                <p class="mb-0">Email: support@resellercenter.org</p>
                                                <p class="mb-0">Telegram: @resellercenter </p>
                                            </div>
                                            <div class="col-md-6 receipt-right">
                                                <h3 class="font-weight-bold">INVOICE # {{ $invoice->id }}</h3>
                                            </div>
                                        </div>
                                        <div class="row receipt-header">
                                            <div class="col-md-6 receipt-left">
</br>
                                                <p class="mb-0"><b>Reseller ID :</b> {{ $invoice->reseller_id }}</p>
                                                <p class="mb-0"><b>Next renew Date :</b> {{
                                                    $invoice->end_at ? Carbon\Carbon::parse($invoice->end_at)->format('F j, Y') : 'N/A' }}
                                                </p>
                                            </div>
                                            <div class="col-md-6 receipt-right">
                                                <p class="mb-0"><b>Paid Date :</b> {{
                                                    $invoice->paid_at ? Carbon\Carbon::parse($invoice->paid_at)->format('F j, Y') : 'N/A' }}
                                                </p>
                                            </div>
                                        </div>
                                        <div>
                                            <table class="table table-bordered receipt-main">
                                                <thead>
                                                    <tr>
                                                        <th>Product</th>
                                                        <th>IP</th>
                                                        <th>Expire</th>
                                                        <th>Amount</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>{{ $invoice->description }}</td>
                                                        <td>{{ $invoice->ip }}</td>
                                                        <td>{{ $invoice->end_at ? Carbon\Carbon::parse($invoice->end_at)->format('F j, Y') : 'N/A' }}
                                                        </td>
                                                        <td><i class="fa fa-usd"></i> ${{ $invoice->amount }}</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                </td>
                                                <td>
                                                </td>
                                                        <td class="text-right">
                                                            <p>
                                                                <strong>Total Amount:</strong>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <strong><i class="fa fa-usd"></i> ${{ $invoice->amount }}</strong>
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-right receipt-center" colspan="3"><h2><strong>Total:</strong></h2></td>
                                                        <td class="text-left text-danger"><h2><strong><i
                                                                        class="fa fa-usd"></i> ${{ $invoice->amount }}</strong></h2>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="row receipt-header receipt-header-mid receipt-footer">
                                            <div class="col-md-12 receipt-center">
                                                <p class="mb-0">Thank you for using our service!</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection