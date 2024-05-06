<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use App\Models\User;

class UserController extends Controller
{
    public function create(Request $request)
    {
        $request->validate([
            'username' => 'required|string|max:50|unique:users',
            'email' => 'required|email|unique:users',
            'password' => 'required|string|min:6',
        ]);

        $user = new User([
            'username' => $request->username,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $user->save();

        return response()->json(['message' => 'User created successfully'], 201);
    }

    public function show($id)
    {
        $user = User::findOrFail($id);

        return response()->json($user, 200);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'username' => 'required|string|max:50|unique:users,username,' . $id,
            'email' => 'required|email|unique:users,email,' . $id,
            'profile_pic' => 'nullable|image|max:2048',
            'preferences' => 'nullable|string',
        ]);

        $user = User::findOrFail($id);

        $user->username = $request->username;
        $user->email = $request->email;
        $user->preferences = $request->preferences;

        if ($request->hasFile('profile_pic')) {
            $profilePicPath = $request->file('profile_pic')->store('profile_pics');
            if ($user->profile_pic) {
                Storage::delete($user->profile_pic);
            }

            $user->profile_pic = $profilePicPath;
        }

        $user->save();

        return response()->json(['message' => 'User updated successfully'], 200);
    }

    public function delete($id)
    {
        $user = User::findOrFail($id);
        if ($user->profile_pic) {
            Storage::delete($user->profile_pic);
        }

        $user->delete();

        return response()->json(['message' => 'User deleted successfully'], 200);
    }
}
