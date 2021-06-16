@extends('tampilan.layouts.app')

@section('title')
    E-Voting Register
@endsection

@section('css')
    <link rel="stylesheet" href="{{ asset('admin_asset/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css') }}">
@endsection

@section('body')
    <div class="container" style="margin-bottom: 55px">
        <div class="row">
            <div class="col">
                <h1>Register</h1>
            </div>
        </div>
        @if ($db->nmor_wa == NULL)
        <form action="{{ url('/register_verif') }}" method="post">
        @endif
            @csrf
            <div class="card text-dark">
                <div class="card-header text-secondary">
                    Data Pemilih
                </div>
                <div class="card-body text-center">
                    <div class="row mx-2 my-2">
                        @if ($db->tipe == 'Mahasiswa')
                            <div class="col-6">Identitas (NIM)</div>
                        @else
                            <div class="col-6">Identitas (NIP/NIDN)</div>
                        @endif
                        <div class="col-6">{{$db->identitas}}</div>
                    </div>
                    <div class="row mx-2 my-2">
                        <div class="col-6">Nama</div>
                        <div class="col-6">{{$db->nama}}</div>
                    </div>
                    @php
                        $bagian = $allow->where('nama', $db->prodi)->first();
                    @endphp
                    <div class="row mx-2 my-2">
                        <div class="col-6">{{ $bagian['jenis_data'] }}</div>
                        <div class="col-6">{{$db->prodi}}</div>
                    </div>
                    @if ($db->verified == 1)
                    <div class="row mx-2 my-2">
                        <div class="col-6">Status</div>
                        @if ($db->has_vote == 1)
                            <div class="col-6">Active (Sudah Memilih)</div>
                        @else
                            <div class="col-6">Active (Belum Memilih)</div>
                        @endif
                    </div>
                    @else
                    <div class="row mx-2 my-2">
                        <div class="col-6">Status</div>
                        <div class="col-6">Belum Regis</div>
                    </div>
                    @endif
                    @if ($db->nmor_wa == NULL)
                        <div class="row mx-2 mt-2 mb-5">
                            <div class="col-6">No.Telp (Whatsapp)</div>
                            <div class="col-6">
                                <input type="text" class="form-control" name="telp" id="Telp" placeholder="Telp" aria-describedby="Telp_Help" required>
                                <small id="Telp_Help" class="form-text text-muted">Masukan Format seperti: 6287712380884</small>
                            </div>
                        </div>
                    @else
                        <div class="row mx-2 my-2">
                            <div class="col-6">No.Telp (Whatsapp)</div>
                            <div class="col-6">{{$db->nmor_wa}}</div>
                        </div>
                    @endif
                    <input type="hidden" name="inden" value="{{$db->identitas}}">
                    @if ($db->nmor_wa == NULL)
                        <button type="submit" class="btn btn-primary">Lanjut</button>
                    @else
                        @if ($db->has_vote == NULL)
                            <a href="{{url('/masuk')}}" class="btn btn-primary">Masuk</a>
                        @else
                            <a href="{{url('/register')}}" class="btn btn-primary">Kembali</a>
                        @endif
                    @endif
                </div>
            </div>
        @if ($db->nmor_wa == NULL)
        </form>
        @endif
        <div class="footer">
            <img class="img-footer" src="{{ asset('uts.png') }}" alt="Logo UTS"/>
            <br>
        </div>
    </div>
@endsection

@section('script')

@endsection