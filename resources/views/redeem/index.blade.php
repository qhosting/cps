@extends('layouts.layout')

@section('content')
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Redeem Code</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">Redeem</li>
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
                                <h3 class="card-title">Redeem Code</h3>
                            </div>


                            <form action="{{ route('redeem.submit') }}" method="POST" data-dashlane-rid="092ab22141c160a0"
                                data-form-type="other">
                                @csrf
                                <div class="card-body">
                                    @error('code')
                                        <div class="alert alert-danger">{{ $message }}</div>
                                    @enderror
                                    <div class="form-group">
                                        <label for="redeem-code">Redeem Code</label>
                                        <input type="text" class="form-control" name="code"
                                            placeholder="Enter Redeem Code Here" data-dashlane-rid="564298be310d5b11"
                                            data-form-type="other" value="{{ old('code') }}">
                                    </div>
                                </div>

                                <div class="card-footer">
                                    <button type="submit" class="btn btn-primary" data-dashlane-rid="26dd55dba4d96914"
                                        data-dashlane-label="true" data-form-type="action">Redeem</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <!-- /.content -->
@endsection
