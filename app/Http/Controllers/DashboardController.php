<?php

namespace App\Http\Controllers;

use App\Allowed;
use App\Helpers\CustomHelper;
use App\Kandidat;
use App\Tervote;
use App\Tim;
use App\Voters;
use App\Voting;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\ConnectException;
use GuzzleHttp\Exception\RequestException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class DashboardController extends Controller
{
    public function __construct()
    {
        $this->middleware('votingcheck')->except('home', 'resultakhir');
        $this->middleware('guestvoters', ['only' => [
            'register_index', 'register_post', 'redirectLoginAfterRegis'
        ]]);
        $this->middleware('verifvoters', ['only' => [
            'beranda', 'pilihbem', 'pilihdpm'
        ]]);
    }

    public function home()
    {
        return view('tampilan.layouts.app')->with('pageawal',TRUE);
    }

    // OLD RESULTAKHIR 
        // public function resultakhir()
        // {
        //     // $tim_bem = Tim::where('pemilihan', 'BEM')->get();
        //     $dpmvotesdb = Kandidat::where('tim_id', 11)->get();
        //     $looping = 1;
        //     foreach ($dpmvotesdb as $dpm) {
        //         $dpmtervote = Tervote::where('voting_dpm', $dpm->id)->count();
        //         $colors = '#' . str_pad(dechex(mt_rand(0, 0xFFFFFF)), 6, '0', STR_PAD_LEFT);
        //         if ($dpmtervote) {
        //             $dpmvotesdata[$dpm->id] = [
        //                 'nama' => $dpm->nama . ' - ' . $dpm->jurusan,
        //                 'vote' => $dpmtervote,
        //                 'jurusan' => $dpm->jurusan,
        //                 'colors' => $colors,
        //             ];
        //         } else {
        //             // $colors = '#' . str_pad(dechex(mt_rand(0, 0xFFFFFF)), 6, '0', STR_PAD_LEFT);
        //             $dpmvotesdata[$dpm->id] = [
        //                 'nama' => $dpm->nama . ' - ' . $dpm->jurusan,
        //                 'vote' => 0,
        //                 // 'jurusan' => $dpm->jurusan,
        //                 'colors' => $colors,
        //             ];
        //         }
        //         $looping += 1;
        //     }
        //     // dd($dpmvotesdata);
        //     return view('tampilan.result', ['dpmdata' => json_encode($dpmvotesdata)]);
        // }

    public function register_index()
    {
        return view('tampilan.register');
    }

    function register_post(Request $request)
    {
        $request->validate([
            'changetypedata' => 'required|in:NIM,NIP/NIDN',
            'typeinput' => 'required'
        ],[
            'changetypedata.required' => 'Data Tipe dibutuhkan!',
            'typeinput.required' => 'Data Input dibutuhkan!',
        ]);
        $tipe = $request->changetypedata;
        if ($tipe == 'NIM') {
            $request->validate([
                'typeinput' => 'max:13|min:13'
            ],[
                'typeinput.max' => 'Isi kolom NIM dgn Benar! Contoh format NIM yang sesuai: 17.01.071.106',
                'typeinput.min' => 'Isi kolom NIM dgn Benar! Contoh format NIM yang sesuai: 17.01.071.106',
            ]);
            $iden = $request->typeinput;
            $db = Voters::where('identitas', $iden)->first();
            $allow = Allowed::all();
            if ($db) {
                $db->tipe = 'Mahasiswa';
                $db->save();
                return view('tampilan.nmor_telp', ['db' => $db, 'allow' => $allow]);
            } else {
                return redirect()->route('register')->with(['status' => 'error','message' => 'Data tidak ditemukan, Check kembali NIM/NIP/NIDN.']);
            }
        } else {
            $request->validate([
                'typeinput' => 'max:18|min:10'
            ],[
                'typeinput.max' => 'Isi kolom NIP/NIDN dgn Benar! Contoh format NIP/NIDN yang sesuai: NIP: 198701132014101028 / NIDN: 9908430596',
                'typeinput.min' => 'Isi kolom NIP/NIDN dgn Benar! Contoh format NIP/NIDN yang sesuai: NIP: 198701132014101028 / NIDN: 9908430596',
            ]);
            $iden = $request->typeinput;
            $db = Voters::where('identitas', $iden)->first();
            $allow = Allowed::all();
            if ($db) {
                $db->tipe = 'Dosen';
                $db->save();
                return view('tampilan.nmor_telp', ['db' => $db, 'allow' => $allow]);
            } else {
                return redirect()->route('register')->with(['status' => 'error','message' => 'Data tidak ditemukan, Check kembali NIM/NIP/NIDN.']);
            }
        }
    }

    public function register_verif(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'telp' => 'required|regex:/^(62)[0-9]/|min:10|max:13',
            'inden' => 'required',
        ],[
            'telp.required' => 'Data telp dibutuhkan.',
            'telp.regex' => 'Format nomor telp salah, silahkan isi dengan contoh: 6287712380884.',
            'inden.required' => 'Data identitas dibutuhkan.',
        ]);

        if ($validator->fails()) {
            return redirect(route('register'))
                        ->withErrors($validator)
                        ->withInput();
        }
        $db = Voters::where('identitas', $request->inden)->first();
        $token = mt_rand(100000, 999999);
        $checknumber = CustomHelper::UniqueVoters($request->telp, 'nmor_wa');
        if (!$checknumber) {
            return redirect()->route('register')->with(['status' => 'error','message' => 'Nomor telpon (Whatsapp) telah digunakan.']);
        }

        $namapil = Voting::where('id', 1)->first();
        $client = new Client();
        $url = config('app.wa_api_url') . "/send-message";
        $method = 'POST';
        $data['tokenapi'] = '$2y$10$DW9iRCyU1Urj5nOI6Dp4he8lISFk2cItJgCIrnkbzCxmZeo8Ca4ya';
        $data['number'] = $request->telp;
        $data['namapil'] = $namapil->judul;
        $data['nama'] = $db->nama;
        $data['token'] = $token;
        $data['url'] = config('app.url') . '/masuk';
        try {
            $client->request($method, $url, [
                'headers' => [
                    'Content-Type' => 'application/x-www-form-urlencoded',
                ],
                'form_params' => $data
            ]);
        } catch (ConnectException $ec) {
            return redirect()->route('register')->with(['status' => 'error','message' => 'Koneksi ke Whatsapp API Error.']);
        } catch (RequestException $eq) {
            return redirect()->route('register')->with(['status' => 'error','message' => 'Request ke Whatsapp API Error']);
        }

        $db->nmor_wa = $request->telp;
        $db->verified = 1;
        $db->password = Hash::make($token);
        $db->save();
        return redirect('/masuk')->with('afterregis', $request->inden);
    }

    // OLD REGISTER 
        // public function register_post(Request $request)
        // {
        //     $request->validate([
        //         'nama' => 'required',
        //         'nim' => 'required|max:13|min:13',
        //         'prodi' => 'required',
        //         'password' => 'required|min:8',
        //         'telp' => 'required',
        //         'siakadfoto' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        //     ],
        //     [
        //         'nama.required' => 'Kolom Nama dibutuhkan!',
        //         'nim.required' => 'Kolom NIM dibutuhkan!',
        //         'nim.max' => 'Isi kolom NIM dgn Benar! Contoh format NIM yang sesuai: 17.01.071.106',
        //         'nim.min' => 'Isi kolom NIM dgn Benar! Contoh format NIM yang sesuai: 17.01.071.106',
        //         'prodi.required' => 'Kolom Prodi dibutuhkan!',
        //         'password.required' => 'Kolom Password dibutuhkan!',
        //         'password.min' => 'Password minimal 8 digit!',
        //         'telp.required' => 'Kolom Telp dibutuhkan!',
        //         'siakadfoto.required' => 'Foto Siakad dibutuhkan!',
        //         'siakadfoto.max' => 'Foto Siakad maximal size 2MB!',
        //     ]);
        //     $helper_nim = CustomHelper::UniqueVoters($request->nim, 'nim');
        //     $helper_telp = CustomHelper::UniqueVoters($request->telp, 'nmor_wa');
        //     if ($helper_nim && $helper_telp) {
        //         $token = mt_rand(100000, 999999);
        //         $helper_token = CustomHelper::UniqueVoters($token, 'token');
        //         while(!$helper_token) {
        //             $token = mt_rand(100000, 999999);
        //             $helper_token = CustomHelper::UniqueVoters($token, 'token');
        //         }
        //         if($file = $request->file('siakadfoto')) {
        //             $name = Carbon::now()->timestamp . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
        //             $destinationPath = public_path('/image/siakad');
        //             if($file->move($destinationPath, $name)) {
        //                 $voter = new Voters;
        //                 $voter->nama = $request->nama;
        //                 $voter->nim = $request->nim;
        //                 $voter->prodi = $request->prodi;
        //                 $voter->token = $token;
        //                 $voter->password = Hash::make($request->password);
        //                 $voter->nmor_wa = $request->telp;
        //                 $voter->foto_siakad = $name;
        //                 $voter->has_vote = 0;
        //                 $voter->verified = 0;
        //                 $voter_save = $voter->save();
        //                 if ($voter_save) {
        //                     return redirect('/masuk')->with('afterregis', $token);
        //                 }
        //                 else {
        //                     return redirect()->route('register')->with(['status' => 'error','message' => ' Data Gagal Ditambah! Check Database Connection.']);
        //                 }
        //             }
        //             else {
        //                 return redirect()->route('register')->with(['status' => 'error','message' => ' Data Gagal Ditambah! Check File Permission.']);
        //             }
        //         }
        //         else {
        //             return redirect()->route('register')->with(['status' => 'error','message' => ' Data Gagal Ditambah! Check Format Gambar yg dikirim.']);
        //         }
        //     }
        //     else {
        //         return redirect()->route('register')->with(['status' => 'error','message' => ' Data Gagal Ditambah! Check NIM dan No.Telp.']);
        //     }
        // }

    // public function redirectLoginAfterRegis($token)
    // {
    //     $voters = Voters::where('token', $token)->first();
    //     if ($voters) {
    //         return redirect('/masuk')->with('openlink', $token);
    //     }
    //     else {
    //         return redirect('/masuk');
    //     }
    // }
    // BERANDAROUTE 
        // public function beranda()
        // {
        //     $tim_bem = Tim::where('pemilihan', 'BEM')->get();
        //     $tim_dpm = Tim::where('pemilihan', 'DPM')->get();
        //     $kandidat = Kandidat::all();
        //     return view('tampilan.beranda', ['tim_dpm' => $tim_dpm, 'tim_bem' => $tim_bem, 'kandidat' => $kandidat])->with('bem', TRUE);
        // }

    public function beranda()
    {
        $voting = Voting::where('id', 1)->first();
        $tim_dpm = Tim::where('pemilihan', 'DPM')->get();
        $kandidat = Kandidat::all();
        return view('tampilan.beranda2', ['voting' => $voting, 'tim_dpm' => $tim_dpm, 'kandidat' => $kandidat])->with('dpm', TRUE);
    }
    // PILIHBEMROUTE 
        // public function pilihbem(Request $request)
        // {
        //     $request->validate([
        //         'pilihan' => 'required',
        //         'pemilihID' => 'required',
        //     ],
        //     [
        //         'pilihan.required' => 'ERROR, PILIHAN ID TIDAK DAPAT DI COLLECT OLEH SISTEM!',
        //         'pemilihID.required' => 'ERROR, PEMILIH ID TIDAK DAPAT DI COLLECT OLEH SISTEM!',
        //     ]);
        //     $bemvote = $request->pilihan;
        //     $votersID = $request->pemilihID;
        //     return redirect(route('beranda'))->with(['bemvote' => $bemvote, 'votersID' => $votersID, 'dpm' => TRUE, 'bem' => FALSE]);
        // }
    // PILIHDPMROUTE 
        // public function pilihdpm(Request $request)
        // {
        //     $request->validate([
        //         'bemvote' => 'required',
        //         'pilihan' => 'required',
        //         'pemilihID' => 'required',
        //     ],
        //     [
        //         'bemvote.required' => 'ERROR, BEMVOTE TIDAK DAPAT DI COLLECT OLEH SISTEM!',
        //         'pilihan.required' => 'ERROR, PILIHAN ID TIDAK DAPAT DI COLLECT OLEH SISTEM!',
        //         'pemilihID.required' => 'ERROR, PEMILIH ID TIDAK DAPAT DI COLLECT OLEH SISTEM!',
        //     ]);
        //     $finalvote = new Tervote;
        //     $finalvote->tim_id = $request->bemvote;
        //     $finalvote->voting_dpm = $request->pilihan;
        //     $finalvote->voters_id = $request->pemilihID;
        //     $savevote = $finalvote->save();

        //     $hasvote = Voters::where('id', $request->pemilihID)->first();
        //     $votersudpate = $hasvote->update([
        //         'has_vote' => 1,
        //     ]);

        //     if($savevote && $votersudpate) {
        //         return redirect(route('aftervote'))->with('pageakhir',TRUE);
        //     }
        //     else {
        //         return redirect(route('beranda'))->with(['status' => 'error','message' => ' Data Gagal Ditambah, Hubungi Administrator!.']);
        //     }
        // }

    public function pilih(Request $request)
    {
        $request->validate([
            'pilihan' => 'required',
            'pemilihID' => 'required',
        ],
        [
            'pilihan.required' => 'ERROR, PILIHAN ID TIDAK DAPAT DI COLLECT OLEH SISTEM!',
            'pemilihID.required' => 'ERROR, PEMILIH ID TIDAK DAPAT DI COLLECT OLEH SISTEM!',
        ]);
        if ($request->bemvote == null) {
            $finalvote = new Tervote;
            $finalvote->tim_id = '6';
            $finalvote->voting_dpm = $request->pilihan;
            $finalvote->voters_id = $request->pemilihID;
            $savevote = $finalvote->save();
    
            $hasvote = Voters::where('id', $request->pemilihID)->first();
            $votersudpate = $hasvote->update([
                'has_vote' => 1,
            ]);
    
            if($savevote && $votersudpate) {
                return redirect(route('aftervote'))->with('pageakhir',TRUE);
            }
            else {
                return redirect(route('beranda'))->with(['status' => 'error','message' => ' Data Gagal Ditambah, Hubungi Administrator!.']);
            }
        }
        else {
            return redirect(route('beranda'))->with(['status' => 'error','message' => ' Data Gagal Ditambah, Hubungi Administrator!.']);
        }

    }

    public function telahmemilih()
    {
        return view('tampilan.aftervote');
    }
}
