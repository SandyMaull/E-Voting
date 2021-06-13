@extends('tampilan.layouts.app')

@section('title')
    E-Voting Masuk
@endsection

@section('css')
    <link rel="stylesheet" href="{{ asset('admin_asset/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css') }}">
@endsection

@section('body')
    <div class="container">
        @if ($afterReg = Session::get('afterregis'))
            <div class="row">
                <div class="col">
                    <h2>Silahkan tunggu pesan konfirmasi dari Whatsapp untuk mendapatkan token sebagai password login.
                    </h2>
                    <h5>NIM/NIP/NIDN: {{ $afterReg }}</h5>
                </div>
            </div>
        @else
        <div class="row">
            <div class="col">
                <h1>Masuk Untuk Melanjutkan</h1>
            </div>
        </div>
        <div class="row">
            <div class="col">
                    @if (Session::get('verif_middleware') == 'has_vote')
                        <form action="{{ url('/masuk2') }}" method="post">
                            @csrf
                            <div class="form-group">
                                <h5 for="Identitas">Identitas</h5>
                                <input type="Identitas" class="form-control" id="Identitas" autocomplete="identitas" name="identitas" aria-describedby="IdentitasHelp" placeholder="Enter Identitas">
                                <small id="IdentitasHelp" class="form-text text-muted">Masukan Identitas (NIM/NIP/NIDN)</small>
                            </div>
                            <div class="form-group">
                                <h5 for="Password_NIM">Token</h5>
                                <input type="password" class="form-control" id="Password_NIM" autocomplete="current-password" name="password" placeholder="Token" aria-describedby="Pass_Help">
                                <small id="Pass_Help" class="form-text text-muted">Masukan Token yang anda dapatkan dari Whatsapp</small>
                            </div>
                            <button type="submit" class="btn btn-primary">Masuk</button>
                            <a href="{{ url('/register') }}" class="btn btn-warning">Register</a>
                        </form>
                    @elseif (Session::get('verif_middleware') == 'not_verified')
                        <form action="{{ url('/masuk2') }}" method="post">
                            @csrf
                            <div class="form-group">
                                <h5 for="Identitas">Identitas</h5>
                                <input type="Identitas" class="form-control" id="Identitas" autocomplete="identitas" name="identitas" aria-describedby="IdentitasHelp" placeholder="Enter Identitas">
                                <small id="IdentitasHelp" class="form-text text-muted">Masukan Identitas (NIM/NIP/NIDN)</small>
                            </div>
                            <div class="form-group">
                                <h5 for="Password_NIM">Token</h5>
                                <input type="password" class="form-control" id="Password_NIM" autocomplete="current-password" name="password" placeholder="Token" aria-describedby="Pass_Help">
                                <small id="Pass_Help" class="form-text text-muted">Masukan Token yang anda dapatkan dari Whatsapp</small>
                            </div>
                            <button type="submit" class="btn btn-primary">Masuk</button>
                            <a href="{{ url('/register') }}" class="btn btn-warning">Register</a>
                        </form>
                    @else
                        <form action="{{ url('/masuk2') }}" method="post">
                            @csrf
                            <div class="form-group">
                                <h5 for="Identitas">Identitas</h5>
                                <input type="Identitas" class="form-control @error('identitas') is-invalid @enderror" id="Identitas" value="{{ old('identitas') }}" autocomplete="identitas" name="identitas" aria-describedby="IdentitasHelp" placeholder="Enter Identitas">
                                <small id="IdentitasHelp" class="form-text text-muted">Masukan Identitas (NIM/NIP/NIDN)</small>
                            </div>
                            <div class="form-group">
                                <h5 for="Password_NIM">Token</h5>
                                <input type="password" class="form-control @error('identitas') is-invalid @enderror" id="Password_NIM" value="{{ old('password') }}" autocomplete="current-password" name="password" placeholder="Token" aria-describedby="Pass_Help">
                                <small id="Pass_Help" class="form-text text-muted">Masukan Token yang anda dapatkan dari Whatsapp</small>
                                @error('identitas')
                                    <span class="invalid-feedback" role="alert">
                                        {{-- <strong>{{ $message }}</strong> --}}
                                        <strong>Identitas/Password Salah.</strong>
                                    </span>
                                @enderror
                            </div>
                            <button type="submit" class="btn btn-primary">Masuk</button>
                            <a href="{{ url('/register') }}" class="btn btn-warning">Register</a>
                        </form>
                        
                    @endif
                </div>
            </div>
        @endif
        <div class="footer">
            <img class="img-footer" src="{{ asset('uts.png') }}" alt="Logo UTS"/>
            <br>
        </div>
    </div>
@endsection
@section('script')
    <script src="{{ asset('admin_asset/plugins/sweetalert2/sweetalert2.min.js') }}"></script>
    @if (session('verif_middleware') == 'has_vote')
        <script type="text/javascript">
        $(function() {
            const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
            });
        
            Toast.fire({
            icon: 'error',
            title: '{{session('errors')}}'
            })
                
            
        });
        
        
        </script>
    @endif

    @if (session('verif_middleware') == 'not_verified')
    <script type="text/javascript">
    $(function() {
        const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
        });
    
        Toast.fire({
        icon: 'error',
        title: '{{session('errors')}}'
        })
            
        
    });
    
    
    </script>
@endif
@endsection