<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cloth extends Model
{
    protected $fillable = [
        'user_id',
        'name',
        'type',
        'brand',
        'size',
        'color',
        'material',
        'image_path',
        'category_id',
        'is_public',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    public function outfits()
    {
        return $this->belongsToMany(Outfit::class, 'outfit_clothes', 'clothing_id', 'outfit_id');
    }

    public function wardrobes()
    {
        return $this->belongsToMany(Wardrobe::class, 'wardrobe_clothes', 'clothes_id', 'wardrobe_id');
    }

    public function compatibilities()
    {
        return $this->hasMany(ItemCompatibility::class, 'first_clothes_id');
    }

}
