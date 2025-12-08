@extends('layouts.layout')

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-dark">Notices</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                        <li class="breadcrumb-item active">Notices</li>
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
                            <h3 class="card-title">Notice List</h3>
                        </div>
                        <div class="card-body">
                            @if (Auth::user()->role === 'admin')
                            <a href="{{ route('notices.create') }}" class="btn btn-primary mb-3">Create Notice</a><br>
                            @endif 
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Created At</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($notices as $notice)
                                    <tr>
                                        <td>{{ $notice->title }}</td>
                                        <td>{{ $notice->created_at }}</td>
                                        <td>
                                            <a href="{{ route('notices.show', $notice->id) }}" class="btn btn-info">View</a>
                                            @if (Auth::user()->role === 'admin')
                                                <a href="{{ route('notices.edit', $notice->id) }}" class="btn btn-warning">Edit</a>

                                                <form action="{{ route('notices.destroy', $notice->id) }}" method="POST" style="display: inline;">
                                                    @csrf
                                                    @method('DELETE')
                                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this notice?')">Delete</button>
                                                </form>
                                            @endif                                       
                                    </td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                            {{ $notices->links() }} 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
