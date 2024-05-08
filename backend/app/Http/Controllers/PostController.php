<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Post;
use Illuminate\Support\Facades\Auth;

class PostController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'content' => 'required|string',
            'image' => 'nullable|image|max:2048',
        ]);

        $post = new Post([
            'user_id' => Auth::id(),
            'content' => $request->content,
            'image' => $request->hasFile('image') ? $request->file('image')->store('posts') : null,
            'timestamp' => now(),
        ]);

        $post->save();

        return response()->json(['message' => 'Post created successfully'], 201);
    }

    public function get(Request $request)
    {
        $posts = Post::with('user')->latest()->paginate(10);

        return response()->json($posts, 200);
    }

    public function delete($postId)
    {
        $post = Post::findOrFail($postId);
        $post->delete();

        return response()->json(['message' => 'Post deleted successfully'], 200);
    }
}
