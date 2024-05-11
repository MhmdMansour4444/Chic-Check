<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Intervention\Image\Laravel\Facades\Image;

class ImageController extends Controller
{
    public function save(Request $request)
    {
        $request->validate([
            'image1' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
            'image2' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $image1Path = $request->file('image1')->store('images', 'local');
        $image2Path = $request->file('image2')->store('images', 'local');

        $processedImage = $this->combineImages($image1Path, $image2Path);

        return response()->json(['processed_image_path' => $processedImage]);
    }

    private function combineImages($image1Path, $image2Path)
    {
        $image1 = Image::make(Storage::disk('local')->path($image1Path));
        $image2 = Image::make(Storage::disk('local')->path($image2Path));

        $combinedImage = $image1->insert($image2, 'right');

        $processedImagePath = 'processed/' . uniqid() . '.jpg';
        $combinedImage->save(storage_path('app/' . $processedImagePath));

        return $processedImagePath;
    }
}
