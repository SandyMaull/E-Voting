@extends('admin.layouts.app')

@section('title')
    Data Kandidat
@endsection

@section('breadcrumb')
<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">Data Allowed Section</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item">Voting</li>
                    <li class="breadcrumb-item active">Data Allowed Section</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
</div>
@endsection

@section('css')
    <link rel="stylesheet" href="{{ asset('admin_asset/plugins/select2/css/select2.min.css') }}">
    <link rel="stylesheet" href="{{ asset('admin_asset/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css') }}">    
@endsection

@section('content')

{{-- Data Allowed  --}}
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-10">
                            <h3 class="card-title">Data yang diizinkan untuk memvote</h3>
                        </div>
                        <div class="col-2">
                            <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modal_tambah">
                                Tambah Data
                            </button>
                        </div>
                    </div>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <table id="unverifiedtables" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nama</th>
                                <th>Jenis</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($data as $db)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>{{ $db->nama }}</td>
                                    <td>{{ $db->jenis_data }}</td>
                                    <td>
                                        <button type="button" data-id="{{ $db->id }}" class="btn btn-danger" data-toggle="modal" data-target="#modal_hapus_data">
                                            Delete Data
                                        </button>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                        <tfoot>
                            <tr>
                                <th>ID</th>
                                <th>Nama</th>
                                <th>Jenis</th>
                                <th>Action</th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <!-- /.card-body -->
            </div>
        </div>
    </div>

{{-- Modal Tambah Data --}}
    <div class="modal fade" id="modal_tambah">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Tambah Data</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="{{ url('administrator/voting_allowed_post') }}" method="post">
                    @csrf
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="allowed_section">Nama</label>
                            <input type="text" class="form-control" name="allowed" id="allowed_section" placeholder="Masukan Nama Allowed Section">
                        </div>
                        <div class="form-group">
                            <label for="allowed_section_jenisdata">Jenis</label>
                            <input type="text" class="form-control" name="allowed_jenis" id="allowed_section_jenisdata" placeholder="Masukan Jenis dari Allowed">
                        </div>
                    </div>
                    <input type="hidden" name="allowed_action" value="ADD">
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Tambah Data</button>
                    </div>
                </form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

{{-- Modal Delete Data --}}
    <div class="modal fade" id="modal_hapus_data">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Hapus Data</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Apakah anda serius ingin menghapus Data ini??</p>
                </div>
                <form action="{{ url('administrator/voting_allowed_post') }}" method="post">
                    @csrf
                    <input type="hidden" id="allowed_id" name="allowed">
                    <input type="hidden" name="allowed_action" value="DELETE">
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-danger">Hapus Data</button>
                    </div>
                </form>
            </div>
        </div>
    </div>



@endsection

@section('script')
<script src="{{ asset('admin_asset/plugins/select2/js/select2.full.min.js') }}"></script>
<script>
    document.getElementById("datavoting").classList.add("menu-open");
    document.getElementById("datavoting_allowed").classList.add("active");

    $('.select2bs4').select2({
      theme: 'bootstrap4',
    });

    // Modal Tambah Kandidat
        $('#modal_tambah').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget)
            var id = button.data('id')
            var modal = $(this)
        });

    // Modal Hapus Kandidat
        $('#modal_hapus_data').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget)
            var id = button.data('id')
            var modal = $(this)
            document.getElementById("allowed_id").value = id;
        });
</script>

@endsection
