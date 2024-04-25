<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Outfit extends Model
{
    protected $fillable = [
        'user_id',
        'name',
        'date_created',
        'is_public',
        'outfit_score',
    ];
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function clothes()
    {
        return $this->belongsToMany(Cloth::class, 'outfit_clothes', 'outfit_id', 'clothing_id');
    }
}
