<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Functie extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = ['naam'];

    // protected $with = ['werknemers'];

    public function werknemers()
    {
        return $this->hasMany(Werknemer::class, 'functie_id', 'id');
    }
}
