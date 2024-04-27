<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ItemCompatibility extends Model
{
    protected $fillable = ['first_clothes_id', 'second_clothes_id', 'match_percentage'];

    public function firstCloth() {
        return $this->belongsTo(Cloth::class, 'first_clothes_id');
    }
    
    public function secondCloth() {
        return $this->belongsTo(Cloth::class, 'second_clothes_id');
    }
}