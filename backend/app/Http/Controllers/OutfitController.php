<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Outfit;

class OutfitController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'name' => 'nullable|string|max:100',
            'is_public' => 'nullable|boolean',
        ]);

        $outfit = new Outfit([
            'user_id' => Auth::id(),
            'name' => $request->name,
            'is_public' => $request->is_public ?? 0,
        ]);

        $outfit->save();
        if ($request->has('clothes')) {
            $outfit->clothes()->sync($request->clothes);
        }

        return response()->json(['message' => 'Outfit created successfully'], 201);
    }

    public function read(Request $request)
    {
        $outfits = Outfit::with('user', 'clothes')->latest()->paginate(10);

        return response()->json($outfits, 200);
    }

    public function update(Request $request, $outfitId)
    {
        $request->validate([
            'name' => 'nullable|string|max:100',
            'is_public' => 'nullable|boolean',
        ]);

        $outfit = Outfit::findOrFail($outfitId);

        $outfit->update([
            'name' => $request->name,
            'is_public' => $request->is_public ?? $outfit->is_public,
        ]);
        if ($request->has('clothes')) {
            $outfit->clothes()->sync($request->clothes);
        }

        return response()->json(['message' => 'Outfit updated successfully'], 200);
    }

    public function delete($outfitId)
    {
        $outfit = Outfit::findOrFail($outfitId);
        $outfit->delete();

        return response()->json(['message' => 'Outfit deleted successfully'], 200);
    }
}
