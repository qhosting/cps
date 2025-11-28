@extends('layouts.layout')

@section('content')


    <div class="content-wrapper">
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">User List</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-item active">User List</li>
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
                                <h3 class="card-title">User List</h3>
                            </div>
                            <div class="card-body">
                                <form action="{{ route('users.index') }}" method="GET" class="mb-3">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="search" value="{{ $search }}" placeholder="Search by username or email">
                                        <div class="input-group-append">
                                            <button type="submit" class="btn btn-primary">Search</button>
                                        </div>
                                    </div>
                                </form>
                                <table class="table table-bordered">
                                   <thead>
                                        <tr>
                                            <th>User ID</th> <!-- Add this line -->
                                            <th>Brand Name</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($users as $user)
                                            <tr>
                                                <td>{{ $user->id }}</td> <!-- Add this line -->
                                                <td>{{ App\Models\Reseller::where('user_id', $user->id)->first()->name ?? null }}</td>
                                                <td>{{ $user->username }}</td>
                                                <td>{{ $user->email }}</td>
                                                <td>{{ $user->role }}</td>
                                                <td>
                                                    @if ($user->role == 'reseller')
                                                        <a href="{{ route('users.login_as_reseller', $user->id) }}" class="btn btn-success" title="Login As Reseller"><i class="fas fa-user"></i></a>
                                                    @endif
                                                    <a href="{{ route('users.edit', $user->id) }}" class="btn btn-primary" title="Edit"><i class="fas fa-edit"></i></a>
                                                    <form action="{{ route('users.destroy', $user->id) }}" method="POST" style="display: inline;">
                                                        @csrf
                                                        @method('DELETE')
                                                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this user?')" title="Delete"><i class="fas fa-trash"></i></button>
                                                    </form>
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                                <div class="d-flex justify-content-center mt-3">
                                    {{ $users->links('pagination.numbered') }}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
@endsection
