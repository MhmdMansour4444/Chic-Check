<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Category;

class CategoryController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:50',
        ]);

        $category = new Category([
            'name' => $request->name,
        ]);

        $category->save();

        return response()->json(['message' => 'Category created successfully'], 201);
    }

    public function get(Request $request)
    {
        $categories = Category::all();

        return response()->json($categories, 200);
    }

    public function update(Request $request, $categoryId)
    {
        $request->validate([
            'name' => 'required|string|max:50',
        ]);

        $category = Category::findOrFail($categoryId);

        $category->name = $request->name;
        $category->save();

        return response()->json(['message' => 'Category updated successfully'], 200);
    }

    public function delete($categoryId)
    {
        $category = Category::findOrFail($categoryId);
        $category->delete();

        return response()->json(['message' => 'Category deleted successfully'], 200);
    }
}
