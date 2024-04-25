<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Wardrobe extends Model
{
    protected $fillable = ['name', 'user_id'];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function clothes()
    {
        return $this->belongsToMany(Cloth::class, 'wardrobe_clothes', 'wardrobe_id', 'clothes_id');
    }

}