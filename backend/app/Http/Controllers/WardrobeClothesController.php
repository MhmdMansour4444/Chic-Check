<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Wardrobe;
use App\Models\Cloth;
use App\Models\WardrobeCloth;

class WardrobeClothController extends Controller
{
    public function attachClothToWardrobe(Request $request, $wardrobeId)
    {
        $request->validate([
            'clothes_id' => 'required|exists:clothes,id',
        ]);

        $wardrobe = Wardrobe::findOrFail($wardrobeId);
        $cloth = Cloth::findOrFail($request->clothes_id);

        $wardrobe->clothes()->attach($cloth->id);

        return response()->json(['message' => 'Cloth attached to wardrobe successfully'], 200);
    }

    public function detachClothFromWardrobe(Request $request, $wardrobeId)
    {
        $request->validate([
            'clothes_id' => 'required|exists:clothes,id',
        ]);

        $wardrobe = Wardrobe::findOrFail($wardrobeId);
        $cloth = Cloth::findOrFail($request->clothes_id);

        $wardrobe->clothes()->detach($cloth->id);

        return response()->json(['message' => 'Cloth detached from wardrobe successfully'], 200);
    }
}
