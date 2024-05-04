<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ItemCompatibility;
use App\Models\cloth;

class ItemCompatibilityController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'first_clothes_id' => 'required|exists:clothes,id',
            'second_clothes_id' => 'required|exists:clothes,id',
            'match_percentage' => 'nullable|numeric|min:0|max:100',
        ]);

        $compatibility = new ItemCompatibility([
            'first_clothes_id' => $request->first_clothes_id,
            'second_clothes_id' => $request->second_clothes_id,
            'match_percentage' => $request->match_percentage,
        ]);
        $compatibility->save();
        return response()->json(['message' => 'Item compatibility added'], 201);

    }

    public function get(Request $request)
    {
        $compatibilities = ItemCompatibility::with('firstCloth', 'secondCloth');
        return response()->json($compatibilities, 200);
    }

    public function delete($compatibilityId)
    {
        $compatibility = ItemCompatibility::findOrFail($compatibilityId);
        $compatibility->delete();

        return response()->json(['message' => 'Item compatibility deleted.']);
    }
}
