@extends('layouts.layout')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">Security Pin</div>
                <div class="card-body">
                    @if ($pin)
                    <p>Your security pin: <span id="pin">{{ $pin }}</span></p>
                    <button id="togglePin" class="btn btn-secondary">Toggle Pin</button>
                    <form action="{{ route('security.pin.reset') }}" method="post">
                        @csrf
                        <button type="submit" class="btn btn-danger">Reset Pin</button>
                    </form>
                    @else
                    <p>No security pin generated.</p>
                    <form action="{{ route('security.pin.store') }}" method="post">
                        @csrf
                        <button type="submit" class="btn btn-primary">Generate Pin</button>
                    </form>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
