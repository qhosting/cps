@extends('layouts.layout')

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-dark">View Notice</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                        <li class="breadcrumb-item"><a href="{{ route('notices.index') }}">Notices</a></li>
                        <li class="breadcrumb-item active">View Notice</li>
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
                            <h3 class="card-title">Notice Details</h3>
                        </div>
                        <div class="card-body">
                            <h2>{{ $notice->title }}</h2>
                            <p>{{ $notice->content }}</p>
                            <p><strong>Created At:</strong> {{ $notice->created_at }}</p>
                            <div class="mt-3">
                                <a href="{{ route('notices.index') }}" class="btn btn-secondary">Back</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
