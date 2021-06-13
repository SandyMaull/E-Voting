<?php

namespace App\Http\Middleware;

use App\Allowed;
use Closure;
use Illuminate\Support\Facades\Auth;

class CheckVerifiedUser
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next, $guard = 'voter')
    {
        if (Auth::guard($guard)->check()) {
            if (Allowed::where('nama', Auth::guard('voter')->user()->prodi)->first() === null) {
                Auth::guard('voter')->logout();
                return redirect(route('masuk'))->with([
                    'verif_middleware' => 'not_verified',
                    'errors' => 'Akun anda tidak dapat melakukan vote di E-Voting ini.',
                ]);
            }
            if (Auth::guard('voter')->user()->verified === 1) {
                if (Auth::guard('voter')->user()->has_vote === 0) {
                    return $next($request);
                }
                else {
                    Auth::guard('voter')->logout();
                    return redirect(route('masuk'))->with([
                        'verif_middleware' => 'has_vote',
                        'errors' => 'Anda Sudah Memilih!',
                    ]);
                }
            }
            else {
                Auth::guard('voter')->logout();
                return redirect(route('masuk'))->with([
                    'verif_middleware' => 'not_verified',
                    'errors' => 'User Belum Terverifikasi!',
                ]);
            }
        }
        return redirect(route('masuk'));
        // dd($hasvote);
    }
}
