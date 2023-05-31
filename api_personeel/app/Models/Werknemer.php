<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Werknemer extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = ['naam', 'functie_id', 'telefoon', 'email', 'sinds'];

    public function functie()
    {
        return $this->belongsTo(Functie::class, 'functie_id', 'id');
    }
}
