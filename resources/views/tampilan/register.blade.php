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
        <form action="{{ url('/register_post') }}" method="post">
            @csrf
            <div class="row">
                <div class="col col-12">
                    <label for="tipemasuk">NIM/NIP/NIDN</label>
                    <select name="changetypedata" onchange="changetype()" id="tipemasuk" class="form-control">
                        <option value="NIM">NIM</option>
                        <option value="NIDN">NIP/NIDN</option>
                        {{-- <option value="NIDN">NIDN</option> --}}
                    </select>
                </div>
                <div class="col col-12">
                    <div class="form-group" id="changetypediv">
                        <h5 id="changetypelabel" for="changetypeinput">NIM</h5>
                        <input type="text" class="form-control" name="typeinput" id="changetypeinput" placeholder="NIM" aria-describedby="NIM_Help" required>
                        <small id="NIM_Help" class="form-text text-light">Masukan NIM</small>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Check</button>
        </form>
        <div class="footer">
            <img class="img-footer" src="{{ asset('uts.png') }}" alt="Logo UTS"/>
            <br>
        </div>
    </div>
@endsection

@section('script')
    <script>
        function changetype() {
            datatype = document.getElementById("tipemasuk").value;
            // alert(d);
            $("#changetypelabel").html(datatype);
            document.getElementById("changetypeinput").placeholder = datatype;
            $("#changetypediv small").text('Masukan ' + datatype);
        }
    </script>

    <script src="{{ asset('admin_asset/plugins/sweetalert2/sweetalert2.min.js') }}"></script>
    @if (session('status') == 'sukses')
    <script type="text/javascript">
      $(function() {
        const Toast = Swal.mixin({
          toast: true,
          position: 'top-end',
          showConfirmButton: false,
          timer: 3000
        });
    
        Toast.fire({
          icon: 'success',
          title: '{{session('message')}}'
        })
            
        
      });
    
    </script>
    @endif
    @if (session('status') == 'error')
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
          title: '{{session('message')}}'
        })
            
        
      });
      
    
    </script>
    @endif
    @if ($errors->count() > 0)
        @foreach ($errors->all() as $error)
        <script type="text/javascript">
            var error = '{{ $error }}';
            $(function() {
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'error',
                title: error
            });
            });
        </script>
        @endforeach
    @endif
@endsection