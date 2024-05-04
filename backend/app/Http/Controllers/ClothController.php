<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Cloth;

class ClothController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'type' => 'required|string|max:50',
            'image_path' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
        ]);

        $cloth = new Cloth([
            'user_id' => Auth::id(),
            'name' => $request->name,
            'type' => $request->type,
            'brand' => $request->brand,
            'size' => $request->size,
            'color' => $request->color,
            'material' => $request->material,
            'image_path' => $request->image_path,
            'category_id' => $request->category_id,
            'is_public' => $request->is_public ?? 0,
        ]);

        $cloth->save();

        return response()->json(['message' => 'Cloth created successfully'], 201);
    }

    public function get(Request $request)
    {
        $clothes = Cloth::with('user', 'category') -> orderBy('id', 'desc')-> take(10)-> get();
        return response()->json($clothes, 200);
    }

    public function update(Request $request, $clothId)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'type' => 'required|string|max:50',
            'image_path' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
        ]);

        $cloth = Cloth::findOrFail($clothId);

        $cloth->update([
            'name' => $request->name,
            'type' => $request->type,
            'brand' => $request->brand,
            'size' => $request->size,
            'color' => $request->color,
            'material' => $request->material,
            'image_path' => $request->image_path,
            'category_id' => $request->category_id,
            'is_public' => $request->is_public ?? 0,
        ]);
        return response()->json(['message' => 'Cloth updated successfully'], 200);
    }

    public function delete($clothId)
    {
        $cloth = Cloth::findOrFail($clothId);
        $cloth->delete();

        return response()->json(['message' => 'Cloth deleted successfully'], 200);
    }
}
