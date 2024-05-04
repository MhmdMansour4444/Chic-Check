<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Forum;

class ForumController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'description' => 'nullable|string',
        ]);

        $forum = new Forum([
            'name' => $request->name,
            'description' => $request->description,
        ]);

        $forum->save();

        return response()->json(['message' => 'Forum created successfully'], 201);
    }

    public function index(Request $request)
    {
        $forums = Forum::with('posts')->latest()->paginate(10);

        return response()->json($forums, 200);
    }

    public function update(Request $request, $forumId)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'description' => 'nullable|string',
        ]);

        $forum = Forum::findOrFail($forumId);

        $forum->update([
            'name' => $request->name,
            'description' => $request->description,
        ]);

        return response()->json(['message' => 'Forum updated successfully'], 200);
    }

    public function delete($forumId)
    {
        $forum = Forum::findOrFail($forumId);
        $forum->delete();

        return response()->json(['message' => 'Forum deleted successfully'], 200);
    }
}
