<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Allowed extends Model
{
    protected $table = 'allowed_section';
    protected $fillable = [
        'nama'
    ];
}
