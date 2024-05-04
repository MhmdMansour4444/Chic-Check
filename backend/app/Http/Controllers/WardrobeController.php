<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Wardrobe;

class WardrobeController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:50',
        ]);

        $wardrobe = new Wardrobe([
            'name' => $request->name,
            'user_id' => Auth::id(),
        ]);

        $wardrobe->save();

        return response()->json(['message' => 'Wardrobe created successfully'], 201);
    }

    public function get(Request $request)
    {
        $wardrobes = Wardrobe::with('user', 'clothes')->latest()->paginate(10);

        return response()->json($wardrobes, 200);
    }

    public function update(Request $request, $wardrobeId)
    {
        $request->validate([
            'name' => 'required|string|max:50',
        ]);

        $wardrobe = Wardrobe::findOrFail($wardrobeId);

        $wardrobe->update([
            'name' => $request->name,
        ]);

        return response()->json(['message' => 'Wardrobe updated successfully'], 200);
    }

    public function delete($wardrobeId)
    {
        $wardrobe = Wardrobe::findOrFail($wardrobeId);
        $wardrobe->delete();

        return response()->json(['message' => 'Wardrobe deleted successfully'], 200);
    }
}
