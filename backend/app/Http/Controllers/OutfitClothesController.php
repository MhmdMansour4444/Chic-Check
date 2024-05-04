<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Outfit;
use App\Models\Cloth;
use App\Models\OutfitCloth;

class OutfitClothController extends Controller
{
    public function attachClothToOutfit(Request $request, $outfitId)
    {
        $request->validate([
            'clothing_id' => 'required|exists:clothes,id',
        ]);

        $outfit = Outfit::findOrFail($outfitId);
        $cloth = Cloth::findOrFail($request->clothing_id);

        $outfit->clothes()->attach($cloth->id);

        return response()->json(['message' => 'Cloth attached to outfit successfully'], 200);
    }

    public function detachClothFromOutfit(Request $request, $outfitId)
    {
        $request->validate([
            'clothing_id' => 'required|exists:clothes,id',
        ]);

        $outfit = Outfit::findOrFail($outfitId);
        $cloth = Cloth::findOrFail($request->clothing_id);

        $outfit->clothes()->detach($cloth->id);

        return response()->json(['message' => 'Cloth detached from outfit successfully'], 200);
    }
}
